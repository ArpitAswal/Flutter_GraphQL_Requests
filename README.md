# Using GraphQL with Flutter: A tutorial with examples

## Overview of graphql_flutter Package

The graphql_flutter package is a Flutter library that provides a simple and effective way to interact with GraphQL APIs. It allows developers to perform queries, mutations, and subscriptions using a Flutter-friendly API.
The graphql_flutter package is a powerful tool for Flutter developers looking to integrate GraphQL into their applications. It simplifies the process of making API calls and managing data, making it easier to build responsive and dynamic applications.

As the name implies, graphql_flutter is a GraphQL client for Flutter. It exports widgets and providers that can be used to fetch data from a GraphQL backend, including:

- **HttpLink** — This is used to set the endpoint or URL of the backend
- **GraphQLClient** — This class is used to fetch the query/mutation from a GraphQL endpoint and also to connect to a GraphQL server
- **GraphQLCache** — This class is used to cache our queries and mutations. It has options store where we pass to it the type of store in its caching operation
- **GraphQLProvider** — This widget wraps the whole graphql_flutter widgets so they can make queries/mutations. The GraphQL client to use is passed to this widget. This client is what this provider makes available to all widgets in its tree
- **Query** — This widget is used to make a query to a GraphQL backend
- **Mutation** — This widget is used to make a mutation to a GraphQL backend
- **Subscription** — This widget is used to set up a subscription

## Setting up graphql_flutter and GraphQLProvider

- Add the package graphql_flutter to the dependencies section of your pubspec.yaml file:

**dependencies:**
  graphql_flutter: ^5.0.0
  
- To use the widgets, we have to import the package like this:
#### import 'package:graphql_flutter/graphql_flutter.dart';

- First of all, before we begin making GraphQL queries and mutations, we have to wrap our root widget with GraphQLProvider. The GraphQLProvider must be provided a GraphQLClient instance to its client property.

- The GraphQLClient is provided with the GraphQL server URL and a caching mechanism.

GrpahQLProvider(
    client: GraphQLClient(...)
)

final httpLink = HttpLink(uri: "http://10.0.2.2:4000/");

ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
        cache: InMemoryCache(),
        link: httpLink
    )
);

1. The URL of the GraphQL server is created using HttpLink. The instance of the HttpLink is passed to the GraphQLClient in a link property, which tells the GraphQLClient the URL of the GraphQL endpoint.

2. The cache passed to GraphQLClient tells it the cache mech to use. The InMemoryCache instance makes use of an in-memory database to persist or store caches.

3. The instance of the GraphQLClient is passed to a ValueNotifier. This ValueNotifer is used to hold a single value and has listeners that notify when the single value changes. graphql flutter uses this to notify its widgets when the data from a GraphQL endpoint changes, which helps keep graphql flutter reactive.

- Now, we’ll wrap our MaterialApp widget with GraphQLProvider:

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: client,
        child: MaterialApp(
            title: 'GraphQL Demo',
            theme: ThemeData(
                primarySwatch: Colors.blue,
            ),
            home: MyHomePage(
                title: 'GraphQL Demo'
            ),
        )
    );
  }
}

## Queries

The Query widget must not be the top-most widget in a tree. It can be placed anywhere else provided the widget that will make use of its data is underneath or wrapped by it.

Also, the Query widget has two properties passed to it: **options** and **builder**.

#### options:

**options: QueryOptions(
    document: gql(readCounters),
    variables: {
    'conuterId': 23,
    },
    pollInterval: Duration(seconds: 10),
),**

- The option property is where the configuration of the query is passed to the Query widget. This options prop is an instance of the QueryOptions. The QueryOptions class exposes properties we use to set options for the Query widget.

- The document property is used to set the query string or to pass in the query we want the Query widget to perform. Here, we passed in the readCounters string:

**final String readCounters = """
    query readCounters(\$counterId: Int!) {
        counter {
            name
            id
        }
    }
""";**

- The variables property is where the query variables are sent to the Query widget. We have 'counterId': 23, there. This will be passed in place of $counterId in the readCounters query string.

- The pollInterval is the time interval during which the Query widget will poll or refresh the query data. The time is set to 10 seconds, so after every 10 seconds, the Query widget will perform HTTP requests to refresh the query data.

#### builder

 builder: (QueryResult result, { VoidCallback refetch, FetchMore fetchMore }) {
                if (result.hasException) {
                    return Text(result.exception.toString());
                }

                if (result.isLoading) {
                    return Text('Loading');
                }

                // it can be either Map or List
                List counters = result.data['counter'];

                return ListView.builder(
                itemCount: repositories.length,
                itemBuilder: (context, index) {
                    return Text(counters\[index\]['name']);
                });
            }
            
- The builder property is a function. The function is called when the Query widget makes an HTTP request to the GraphQL server endpoint. The builder function is called by the Query widget with the data from the query, a function that is used to refetch the data, and a function that is used for pagination. This is used to fetch more data.

- The builder function returns widgets below the Query widget. The result arg is an instance of the QueryResult. The QueryResult has properties that we can use to know the state of the query and the data returned by the Query widget.

**QueryResult.hasException** is set if the query encounters an error.

**QueryResult.isLoading** is set if the query is still in progress. We can use this property to display a UI progress to our users to tell them that something is on the way.

**QueryResult.data** holds the data returned by the GraphQL endpoint

#### Mutations

Let’s see how to use the Mutation widget in graphql_flutter to make mutation queries.

The Mutation widget is used like this:
**
Mutation(
  options: MutationOptions(
    document: gql(addCounter),
    update: (GraphQLDataProxy cache, QueryResult result) {
      return cache;
    },
    onCompleted: (dynamic resultData) {
      print(resultData);
    },
  ),
  builder: (
    RunMutation runMutation,
    QueryResult result,
  ) {
    return FlatButton(
      onPressed: () => runMutation({
        'counterId': 21,
      }),
      child: Text('Add Counter')
    );
  },
);
**

Just like the Query widget, the Mutation widget takes some properties.

- options is an instance of the MutationOptions class. This is where the mutation string and other configurations occur
document is used to set the mutation string. Here we have an addCounter mutation passed to the document. It will be run by the Mutation widget
- update is called when we want to update the cache. The update function is called with the previous cache (cache) and the result of the mutation result. Anything returned from the update becomes the new value of the cache. Here, we are updating the cache based on the results
- onCompleted is called when the mutations have been called on the GraphQL endpoint. Then the onCompleted function is called with the mutation result
- builder is used to return the widget that will be under the Mutation widget tree. This function is called with a RunMutation instance, runMutation, and a QueryResult instance, result.
- runMutation is used to run the mutation in this Mutation widget. Whenever it is called, the Mutattion widget triggers the mutation. This runMutation function is passed the mutation variables as parameters. Here, the runMutation is called with the counterId variable, 21

Now, when the mutation from the Mutation is complete, the builder is called so the Mutation rebuilds its tree. runMutation and the result of the mutation is passed to the builder function.

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

3. Home Page: The API returs the Character with its image, name & status etc. 
API: 'https://rickandmortyapi.com/graphql',




