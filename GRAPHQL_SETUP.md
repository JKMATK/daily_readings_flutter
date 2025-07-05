# GraphQL Setup for Daily Readings Flutter App

This document explains how to use the GraphQL integration in your Flutter app.

## Environment Configuration

The app supports both local development and production environments. To switch between them:

### Local Development (Default)
- Edit `lib/config/environment.dart`
- Set `_isLocalDevelopment = true`
- The app will connect to `http://localhost:4002/`

### Production
- Edit `lib/config/environment.dart`
- Set `_isLocalDevelopment = false`
- Update `_serverGraphQLEndpoint` with your actual server URL

## File Structure

```
lib/
├── config/
│   └── environment.dart          # Environment configuration
├── services/
│   ├── graphql_client.dart       # GraphQL client service
│   └── daily_readings_service.dart # Example service using GraphQL
├── graphql/
│   └── queries.dart              # GraphQL queries, mutations, and subscriptions
└── main.dart                     # Updated to include GraphQL provider
```

## Usage Examples

### 1. Using the Service Layer (Recommended)

```dart
import 'package:daily_readings/services/daily_readings_service.dart';

// Fetch all daily readings
final readings = await DailyReadingsService.getDailyReadings();
```

### 2. Using GraphQL Widgets Directly

```dart
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:daily_readings/graphql/queries.dart';

// Query widget
Query(
  options: QueryOptions(
    document: gql(GraphQLQueries.getDailyReadings),
  ),
  builder: (QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore }) {
    if (result.hasException) {
      return Text('Error: ${result.exception.toString()}');
    }
    
    if (result.isLoading) {
      return CircularProgressIndicator();
    }
    
    final readings = result.data?['dailyReadings'] ?? [];
    return ListView.builder(
      itemCount: readings.length,
      itemBuilder: (context, index) {
        final reading = readings[index];
        return ListTile(
          title: Text(reading['title']),
          subtitle: Text(reading['content']),
        );
      },
    );
  },
)

// Mutation widget
Mutation(
  options: MutationOptions(
    document: gql(GraphQLMutations.createReading),
  ),
  builder: (RunMutation runMutation, QueryResult? result) {
    return ElevatedButton(
      onPressed: () {
        runMutation({
          'title': 'New Reading',
          'content': 'Content...',
        });
      },
      child: Text('Create Reading'),
    );
  },
)
```

### 3. Using the Client Directly

```dart
import 'package:daily_readings/services/graphql_client.dart';
import 'package:daily_readings/graphql/queries.dart';

// Execute a query
final result = await GraphQLClientService.query(
  GraphQLQueries.getDailyReadings,
);
```

## Customizing Queries

1. Update the queries in `lib/graphql/queries.dart` to match your GraphQL schema
2. Modify the service methods in `lib/services/daily_readings_service.dart` as needed
3. Update the data models to match your schema structure

## Error Handling

The GraphQL client includes built-in error handling:

- Network errors are caught and logged
- GraphQL errors are thrown as exceptions
- The service layer provides safe defaults (empty lists, null values)

## Testing

To test the GraphQL connection:

1. Ensure your local subgraph is running at `http://localhost:4002/`
2. Run the Flutter app
3. Check the console output for connection status
4. Use the GraphQL playground at `http://localhost:4002/` to test queries

## Troubleshooting

### Common Issues

1. **Connection refused**: Make sure your subgraph is running
2. **Schema mismatch**: Update queries to match your actual GraphQL schema
3. **CORS issues**: Ensure your subgraph allows requests from Flutter

### Debug Mode

Enable debug logging by adding this to your main.dart:

```dart
// Add this after GraphQLProvider
GraphQLProvider(
  client: ValueNotifier(GraphQLClientService.client),
  child: MaterialApp(
    // ... your app configuration
  ),
)
```

## Next Steps

1. Update the queries in `queries.dart` to match your actual GraphQL schema
2. Create data models for your entities
3. Implement error handling and loading states in your UI
4. Add authentication if required
5. Set up WebSocket connections for real-time features 