import '../graphql/queries.dart';
import 'graphql_client.dart';

class DailyReadingsService {
  // Fetch all daily readings
  static Future<List<Map<String, dynamic>>> getDailyReadings() async {
    try {
      final result = await GraphQLClientService.query(
        GraphQLQueries.getDailyReadings,
        variables: {
          'churchId': 'e077ba9a-9c4b-41c3-8e15-407507c717aa',
          'date': '2025-07-09',
        },
      );
      
      if (result.data != null) {
        final List<dynamic> readings = result.data!['dailyReadingsForChurch'] ?? [];
        return readings.cast<Map<String, dynamic>>();
      }
      
      return [];
    } catch (e) {
      print('Error fetching daily readings: $e');
      return [];
    }
  }
} 