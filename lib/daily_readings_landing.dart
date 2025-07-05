import 'package:daily_readings/services/daily_readings_service.dart';
import 'package:flutter/material.dart';

class DailyReadingsLanding extends StatelessWidget {
  const DailyReadingsLanding({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DailyReadingsService.getDailyReadings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No data found.'));
        } else {
          final data = snapshot.data;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("This will be our landing page! Let's serve the C church"),
                const Text("We can include Verse of the day on top"),
                const Text("then we can add a list of daily readings"),
                Text(data.toString()), // Adjust to your actual model
              ],
            ),
          );
        }
      },
    );
  }
}
