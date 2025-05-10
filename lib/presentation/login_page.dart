import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth_bloc/bloc.dart';
import '../blocs/auth_bloc/event.dart';
import '../blocs/auth_bloc/state.dart';

class LoginPage extends StatelessWidget {
  // final TextEditingController passwordController =TextEditingController();

  LoginPage({super.key});

  final TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GraphQL Login'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'User Info: ${state.user.id} ${state.user.name}, ${state.user.email}, ${state.user.username}')),
          );
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      }, builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                elevation: 8.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.account_circle,
                        size: 80,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: idController,
                        decoration: const InputDecoration(
                          labelText: 'User ID',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // TextField(
                      //   controller: passwordController,
                      //   obscureText: true,
                      //   decoration: const InputDecoration(
                      //     labelText: 'Password',
                      //     prefixIcon: Icon(Icons.lock),
                      //     border: OutlineInputBorder(),
                      //   ),
                      // ),
                      // const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: () {
                            if (idController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please fill the User ID')),
                              );
                              return;
                            }
                            context
                                .read<AuthBloc>()
                                .add(GetUserEvent(idController.text));
                          },
                          child: const Text('Login'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/signup'),
                        child: const Text('Don\'t have an account? Sign up'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
