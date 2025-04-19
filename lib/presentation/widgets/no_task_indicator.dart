import 'package:flutter/material.dart';

class NoTasksScreen extends StatelessWidget {

  const NoTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.event_busy, // You can choose any icon you prefer
            size: 80,
            color: Colors.grey[500], // Soft gray color for the icon
          ),
          SizedBox(height: 20),
          Text(
            'No tasks available',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600], // Soft gray color for the text
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
