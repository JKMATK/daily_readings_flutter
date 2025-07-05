import 'package:graphql_flutter/graphql_flutter.dart';
import '../config/environment.dart';

class GraphQLClientService {
  static GraphQLClient? _client;
  
  static GraphQLClient get client {
    _client ??= _createClient();
    return _client!;
  }
  
  static GraphQLClient _createClient() {
    final HttpLink httpLink = HttpLink(
      Environment.graphQLEndpoint,
      defaultHeaders: {
        'Content-Type': 'application/json',
      },
    );
    
    return GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(
        store: InMemoryStore(),
      ),
    );
  }
  
  // Helper method to execute queries
  static Future<QueryResult> query(String document, {Map<String, dynamic>? variables}) async {
    final result = await client.query(
      QueryOptions(
        document: gql(document),
        variables: variables ?? {},
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    
    if (result.hasException) {
      throw result.exception!;
    }
    
    return result;
  }
  
  // Helper method to execute mutations
  static Future<QueryResult> mutate(String document, {Map<String, dynamic>? variables}) async {
    final result = await client.mutate(
      MutationOptions(
        document: gql(document),
        variables: variables ?? {},
      ),
    );
    
    if (result.hasException) {
      throw result.exception!;
    }
    
    return result;
  }
  
  // Helper method to subscribe to GraphQL subscriptions
  static Stream<QueryResult> subscribe(String document, {Map<String, dynamic>? variables}) {
    return client.subscribe(
      SubscriptionOptions(
        document: gql(document),
        variables: variables ?? {},
      ),
    );
  }
  
  // Method to reset the client (useful for testing or reconfiguration)
  static void reset() {
    _client = null;
  }
} 