import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  GraphQLService() {
    final HttpLink httpLink = HttpLink(
      'https://graphqlzero.almansi.me/api', // API endpoint
    );
    final HttpLink httpLink2 = HttpLink(
      'https://rickandmortyapi.com/graphql', // API endpoint
    );

    //    final AuthLink authLink = AuthLink(
    //   getToken: () async => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
    //   // OR
    //   // getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
    // );
    // You can also use the AuthLink to add authentication headers if needed
    // final Link link = authLink.concat(httpLink);

    client = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    );

    //    // The default store is the InMemoryStore, which does NOT persist to disk. We can use HiveStore

    client2 = GraphQLClient(
        link: httpLink2, cache: GraphQLCache(store: InMemoryStore()));
  }

  late GraphQLClient client;
  late GraphQLClient client2;
}
