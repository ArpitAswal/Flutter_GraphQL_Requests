// AuthEvent: Defines all possible authentication events that can be dispatched
// These events trigger state changes in the AuthBloc

abstract class AuthEvent {}

/// Event for retrieving user data
class GetUserEvent extends AuthEvent {
  GetUserEvent(this.id);

  final String id;
}

/// Event for creating a new user
class CreateUserEvent extends AuthEvent {
  CreateUserEvent(this.username, this.name, this.email);

  final String email;
  final String name;
  final String username;
}
