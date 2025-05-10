// AuthBloc: Manages authentication state and handles auth-related events
// Implements the business logic for user authentication and registration

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../infrastructures/auth_service.dart';
import 'event.dart';
import 'state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.authService) : super(AuthInitial()) {
    on<GetUserEvent>(_onGetUser);
    on<CreateUserEvent>(_onCreateUser);
  }

  final AuthService authService;

  // Handle Get User Event
  Future<void> _onGetUser(GetUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authService.getUser(event.id);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  // Handle Create User Event
  Future<void> _onCreateUser(
      CreateUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user =
          await authService.createUser(event.username, event.name, event.email);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
