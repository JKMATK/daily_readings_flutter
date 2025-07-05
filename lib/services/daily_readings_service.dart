import '../graphql/queries.dart';
import 'graphql_client.dart';

class DailyReadingsService {
  // Fetch all daily readings
  static Future<List<Map<String, dynamic>>> getDailyReadings() async {
    try {
      final result = await GraphQLClientService.query(GraphQLQueries.getDailyReadings);
      
      if (result.data != null) {
        final List<dynamic> readings = result.data!['dailyReadings'] ?? [];
        return readings.cast<Map<String, dynamic>>();
      }
      
      return [];
    } catch (e) {
      print('Error fetching daily readings: $e');
      return [];
    }
  }
} 