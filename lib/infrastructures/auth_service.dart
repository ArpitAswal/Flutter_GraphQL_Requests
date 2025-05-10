// AuthService: Handles GraphQL operations for authentication
// Implements the data layer for user-related operations

import 'package:graphql_flutter/graphql_flutter.dart';
import '../models/user_model.dart';
import 'client_service.dart';

class AuthService {
  final GraphQLService graphQLService = GraphQLService();

  // Fetch user by ID (query)
  Future<UserModel> getUser(String id) async {
    const String query = r'''
      query GetUser($id: ID!) {
        user(id: $id) {
          id
          name
          email
          username
        }
      }
    ''';

    final options = QueryOptions(
      document: gql(query),
      variables: {'id': id},
    );

    final result = await graphQLService.client.query(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    return UserModel.fromJson(result.data!['user']);
  }

  // Create new user (mutation)
  Future<UserModel> createUser(
      String username, String name, String email) async {
    const String mutation = r'''
    mutation CreateUser($input: CreateUserInput!) {
      createUser(input: $input) {
        id
        username
        name
        email
      }
    }
  ''';

    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: {
        'input': {
          'username': username, // Must provide username
          'name': name, // Optional but good to have
          'email': email,
        }
      },
    );

    final result = await graphQLService.client.mutate(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    // Notice: 'createUser' field contains username + name + email
    return UserModel(
      id: result.data!['createUser']['id'],
      name: result.data!['createUser']['name'],
      email: result.data!['createUser']['email'],
      username: result.data!['createUser']['username'],
    );
  }
}
