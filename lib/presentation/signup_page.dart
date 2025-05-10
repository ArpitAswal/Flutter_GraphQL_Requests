import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth_bloc/bloc.dart';
import '../blocs/auth_bloc/event.dart';
import '../blocs/auth_bloc/state.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  // final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GraphQL Signup'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                      'User Created: ${state.user.id} ${state.user.name}, ${state.user.email}, ${state.user.username}')),
            );
            Navigator.pop(context);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.app_registration,
                            size: 80,
                            color: Colors.blue,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: usernameController,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Username is required';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Username',
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              labelText: 'Full Name (optional)',
                              prefixIcon: Icon(Icons.badge),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Email is required';
                              }
                              if (!value!.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          // const SizedBox(height: 16),
                          // TextFormField(
                          //   controller: passwordController,
                          //   obscureText: true,
                          //   validator: (value) {
                          //     if (value?.isEmpty ?? true) {
                          //       return 'Password is required';
                          //     }
                          //     if (value!.length < 6) {
                          //       return 'Password must be at least 6 characters';
                          //     }
                          //     return null;
                          //   },
                          //   decoration: const InputDecoration(
                          //     labelText: 'Password',
                          //     prefixIcon: Icon(Icons.lock),
                          //     border: OutlineInputBorder(),
                          //   ),
                          // ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                              ),
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  context.read<AuthBloc>().add(
                                        CreateUserEvent(
                                          usernameController.text,
                                          nameController.text,
                                          emailController.text,
                                        ),
                                      );
                                }
                              },
                              child: const Text('Sign Up'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
