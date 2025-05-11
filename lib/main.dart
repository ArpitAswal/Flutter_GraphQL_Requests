// Main entry point for the Flutter application
// This file sets up the app's routing and dependency injection

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_requets/blocs/riclk_morty_bloc/bloc.dart';
import 'package:graphql_requets/blocs/riclk_morty_bloc/event.dart';
import 'package:graphql_requets/presentation/home_page.dart';
import 'blocs/auth_bloc/bloc.dart';
import 'infrastructures/auth_service.dart';
import 'infrastructures/client_service.dart';
import 'presentation/login_page.dart';
import 'presentation/signup_page.dart';

// Entry point of the application
void main() async {
  // Initialize hive for persistence
  await initHiveForFlutter();

  runApp(const MyApp());
}

// Root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GraphQLService graphQLService = GraphQLService();

    return GraphQLProvider(
      client: ValueNotifier(graphQLService.client2),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter GraphQL Auth',
        initialRoute: '/homePage',
        // Define the app's routes and inject dependencies
        routes: {
          // SignIn route with AuthBloc provider
          '/': (context) => GraphQLProvider(
                client: ValueNotifier(graphQLService.client),
                child: BlocProvider(
                  create: (_) => AuthBloc(AuthService()),
                  child: LoginPage(),
                ),
              ),
          // Signup route with AuthBloc provider
          '/signup': (context) => GraphQLProvider(
                client: ValueNotifier(graphQLService.client),
                child: BlocProvider(
                  create: (_) => AuthBloc(AuthService()),
                  child: SignupPage(),
                ),
              ),
          // Home route with RickMorty provider
          '/homePage': (context) => BlocProvider(
                create: (_) => RickMortyBloc()..add(FetchCharacters()),
                child: const HomePage(),
              ),
        },
      ),
    );
  }
}
