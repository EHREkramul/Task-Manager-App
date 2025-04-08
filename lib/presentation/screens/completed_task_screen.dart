import 'package:flutter/material.dart';

import '../widgets/summary_card.dart';
import '../widgets/task_item.dart';
import 'add_new_task_screen.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
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
                      status: 'Completed',
                      title: 'Lorem Ipsum is simply dummy',
                      date: DateTime.now(),
                      statusColor: Colors.green,
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
