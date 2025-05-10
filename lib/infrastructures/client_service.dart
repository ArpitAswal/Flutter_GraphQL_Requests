import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  GraphQLService() {
    final HttpLink httpLink = HttpLink(
      'https://graphqlzero.almansi.me/api', // API endpoint
    );

    client = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    );
  }

  late GraphQLClient client;
}
