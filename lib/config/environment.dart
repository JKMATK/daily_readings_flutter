class Environment {
  static const String _localGraphQLEndpoint = 'http://localhost:4002/';
  static const String _serverGraphQLEndpoint = ''; // Update this with your actual server endpoint
  
  // Set this to true for local development, false for production
  static const bool _isLocalDevelopment = true;
  
  static String get graphQLEndpoint {
    return _isLocalDevelopment ? _localGraphQLEndpoint : _serverGraphQLEndpoint;
  }
  
  static bool get isLocalDevelopment => _isLocalDevelopment;
  
  // You can add more environment-specific configurations here
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
} 