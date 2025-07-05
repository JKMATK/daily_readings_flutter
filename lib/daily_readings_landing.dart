import 'package:flutter/material.dart';

class DailyReadingsLanding extends StatelessWidget {
  const DailyReadingsLanding({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("This will be our landing page! Let's serve the C church"),
          Text("We can include Verse of the day on top"),
          Text("then we can add a list of daily readings"),
        ],
      ),
    );
  }
}
