// GraphQL Queries
class GraphQLQueries {
  // Example query - replace with your actual queries
  static const String getDailyReadings = r'''
    query DailyReadingsForChurch($churchId: ID!, $date: String!) {
      dailyReadingsForChurch(churchId: $churchId, date: $date) {
        schedule {
          name
        }
        entries {
          sortOrder
          type
          references
          content
          bibleContent {
            content
            reference
          }
        }
        message
      }
    }
  ''';
}
