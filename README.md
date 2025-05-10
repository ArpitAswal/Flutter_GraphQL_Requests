# Flutter GraphQL Authentication App

A Flutter application demonstrating GraphQL integration for user authentication and management using the BLoC pattern.

## Features

- User authentication
- User registration
- GraphQL API integration
- Clean architecture with BLoC pattern
- Form validation
- Responsive UI design

## Project Structure

```
lib/
├── blocs/
│   └── auth_bloc/
│       ├── bloc.dart
│       ├── event.dart
│       └── state.dart
├── infrastructures/
│   ├── auth_service.dart
│   └── client_service.dart
├── models/
│   └── user_model.dart
├── presentation/
│   ├── login_page.dart
│   └── signup_page.dart
└── main.dart
```

## Architecture

The project follows a clean architecture approach:

- **Presentation Layer**: Contains UI components and widgets
- **Business Logic Layer**: Uses BLoC pattern for state management
- **Infrastructure Layer**: Handles API communication and data persistence
- **Domain Layer**: Contains business logic and models

## Dependencies

- flutter_bloc: State management
- graphql_flutter: GraphQL client
- flutter: SDK

## Getting Started

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Configure your GraphQL endpoint in `client_service.dart`
4. Run the app using `flutter run`

## Working

1. LogIn Page: The API returns the user detail from User ID 0 to 10.
2. SignUp Page: The API will return that User is created and always it's generated User ID is 11.

This API 'https://graphqlzero.almansi.me/api', is used for only SignIn/SignUp testting through GraphQL Requests.




