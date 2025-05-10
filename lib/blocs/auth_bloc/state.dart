// AuthState: Defines all possible authentication states
// These states represent different phases of authentication process

import '../../models/user_model.dart';

/// Base class for all authentication states
abstract class AuthState {}

/// Initial state when no authentication action has been taken
class AuthInitial extends AuthState {}

/// State during authentication process
class AuthLoading extends AuthState {}

/// State when authentication is successful
class AuthSuccess extends AuthState {
  AuthSuccess(this.user);

  final UserModel user;
}

/// State when authentication fails
class AuthFailure extends AuthState {
  AuthFailure(this.message);

  final String message;
}
