import 'package:flutter/material.dart';

import '../widgets/task_item.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          spacing: 10,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder:
                    (context, index) => TaskItem(
                      index: index,
                      status: 'Progress',
                      title: 'Lorem Ipsum is simply dummy',
                      date: DateTime.now(),
                      statusColor: Colors.purple,
                      description:
                          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
