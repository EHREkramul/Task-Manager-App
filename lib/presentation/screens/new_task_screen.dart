import 'package:flutter/material.dart';

import '../widgets/summary_card.dart';
import '../widgets/task_item.dart';
import 'add_new_task_screen.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNewTaskScreen()),
          );
        },
        backgroundColor: Color.fromARGB(255, 33, 191, 115),
        foregroundColor: Colors.white,
        shape: CircleBorder(),
        child: Icon(Icons.add, size: 30),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          spacing: 10,
          children: [
            _buildSummarySection(),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder:
                    (context, index) => TaskItem(
                      index: index,
                      status: 'New',
                      title: 'Lorem Ipsum is simply dummy',
                      date: DateTime.now(),
                      statusColor: Colors.blue,
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

  Widget _buildSummarySection() {
    return Row(
      children: [
        SummaryCard(count: '09', status: 'Canceled'),
        SummaryCard(count: '10', status: 'Completed'),
        SummaryCard(count: '12', status: 'Progress'),
        SummaryCard(count: '02', status: 'New Task'),
      ],
    );
  }
}
