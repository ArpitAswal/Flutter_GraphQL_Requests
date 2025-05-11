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
      document: gql(mutation), // this is the mutation string you just created

      variables: {
        // this is the variables map
        'input': {
          'username': username, // Must provide username
          'name': name, // Optional but good to have
          'email': email,
        }
      },

      // or do something with the result.data on completion
      onCompleted: (dynamic resultData) {
        print(resultData);
      },
    );

    final result =
        await graphQLService.client.mutate(options); // Execute the mutation

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

  //Fetch the character
  Future<List<dynamic>> getCharacter() async {
    // This is a GraphQL query to fetch
    const String query = r'''
      query {
        characters {
          results {
            id
            name
            image
            status
          }
        }
      }
    ''';

    final options = QueryOptions(
      // QueryOptions is a class that contains the query and variables
      document: gql(query), // this is the query string you just created
    );

    final result =
        await graphQLService.client2.query(options); // Execute the query

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    return result.data!['characters']['results']
        as List<dynamic>; // Return the list of characters
  }
}
