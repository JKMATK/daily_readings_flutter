import 'package:daily_readings/bible_reader.dart';
import 'package:daily_readings/daily_readings_landing.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:daily_readings/services/graphql_client.dart';
import 'package:daily_readings/config/environment.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize GraphQL client
  await initGraphQLClient();
  
  runApp(const MyApp());
}

Future<void> initGraphQLClient() async {
  // Initialize the GraphQL client
  GraphQLClientService.client;
  
  if (Environment.isLocalDevelopment) {
    print('🚀 Running in LOCAL development mode');
    print('📡 GraphQL endpoint: ${Environment.graphQLEndpoint}');
  } else {
    print('🌐 Running in PRODUCTION mode');
    print('📡 GraphQL endpoint: ${Environment.graphQLEndpoint}');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: ValueNotifier(GraphQLClientService.client),
      child: MaterialApp(
        title: 'Daily Readings',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showReader = false;

  void _switchViews() {
    setState(() {
      _showReader = !_showReader;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_showReader ? "Bible" : "Daily Readings"),
      ),
      body: Center(
        child: _showReader ? const BibleReader() : const DailyReadingsLanding(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _switchViews,
        tooltip: 'Show Reader',
        child: _showReader ? const Icon(Icons.menu) : const Icon(Icons.book),
      ),
    );
  }
}
