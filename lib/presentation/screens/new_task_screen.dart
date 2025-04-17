import 'package:flutter/material.dart';

import '../../data/models/task_status_count_list_model.dart';
import '../../data/models/task_status_count_model.dart';
import '../../data/service/network_client.dart';
import '../../data/service/network_response.dart';
import '../../data/utils/urls.dart';
import '../utils/snack_bar_message.dart';
import '../widgets/centered_circular_progress_bar.dart';
import '../widgets/summary_card.dart';
import '../widgets/task_item.dart';
import 'add_new_task_screen.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _statusCountInProgress = false;

  TaskStatusCountModel newTask = TaskStatusCountModel(count: 0);
  TaskStatusCountModel completedTask = TaskStatusCountModel(count: 0);
  TaskStatusCountModel progressTask = TaskStatusCountModel(count: 0);
  TaskStatusCountModel canceledTask = TaskStatusCountModel(count: 0);

  @override
  void initState() {
    _getTaskStatusCount();
    super.initState();
  }

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
      body: Visibility(
        visible: _statusCountInProgress == false,
        replacement: CenteredCircularProgressBar(),
        child: Padding(
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
      ),
    );
  }

  Widget _buildSummarySection() {
    return Row(
      children: [
        SummaryCard(count: canceledTask.count.toString(), status: 'Canceled'),
        SummaryCard(count: completedTask.count.toString(), status: 'Completed'),
        SummaryCard(count: progressTask.count.toString(), status: 'Progress'),
        SummaryCard(count: newTask.count.toString(), status: 'New Task'),
      ],
    );
  }

  Future<void> _getTaskStatusCount() async {
    setState(() {
      _statusCountInProgress = true;
    });
    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.taskStatusCountUrl,
    );

    if (response.isSuccess) {
      TaskStatusCountListModel taskStatusCountListModel =
          TaskStatusCountListModel.fromJson(response.data!);
      List<TaskStatusCountModel> taskStatusCountList =
          taskStatusCountListModel.statusCountList!;

      for (var task in taskStatusCountList) {
        if (task.status == 'New') {
          newTask = task;
        } else if (task.status == 'Completed') {
          completedTask = task;
        } else if (task.status == 'Canceled') {
          canceledTask = task;
        } else {
          progressTask = task;
        }
      }
    } else {
      showSnackBarMessage(response.errorMessage!, true);
    }

    setState(() {
      _statusCountInProgress = false;
    });
  }
}
