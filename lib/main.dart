// Main entry point for the Flutter application
// This file sets up the app's routing and dependency injection

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/auth_bloc/bloc.dart';
import 'infrastructures/auth_service.dart';
import 'presentation/login_page.dart';
import 'presentation/signup_page.dart';

// Entry point of the application
void main() {
  runApp(const MyApp());
}

// Root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter GraphQL Auth',
      // Define the app's routes and inject dependencies
      routes: {
        // Home route with AuthBloc provider
        '/': (context) => BlocProvider(
              create: (_) => AuthBloc(AuthService()),
              child: LoginPage(),
            ),
        // Signup route with AuthBloc provider
        '/signup': (context) => BlocProvider(
              create: (_) => AuthBloc(AuthService()),
              child: SignupPage(),
            ),
      },
    );
  }
}
