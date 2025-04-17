import 'package:flutter/material.dart';

import 'no_task_screen.dart';
import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';
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

  bool _getNewTaskInProgress = false;
  List<TaskModel> _taskList = <TaskModel>[];

  @override
  void initState() {
    _getTaskStatusCount();
    _getAllNewTaskList();
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
        visible:
            _statusCountInProgress == false && _getNewTaskInProgress == false,
        replacement: CenteredCircularProgressBar(),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            spacing: 10,
            children: [
              _buildSummarySection(),
              Expanded(
                child:
                    _taskList.isEmpty
                        ? NoTasksScreen(category: 'New')
                        : ListView.builder(
                          itemCount: _taskList.length,
                          itemBuilder:
                              (context, index) => TaskItem(
                                statusColor: Colors.blue,
                                task: _taskList[index],
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
        SummaryCard(count: newTask.count.toString(), status: 'New Task'),
        SummaryCard(count: completedTask.count.toString(), status: 'Completed'),
        SummaryCard(count: canceledTask.count.toString(), status: 'Canceled'),
        SummaryCard(count: progressTask.count.toString(), status: 'Progress'),
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

  Future<void> _getAllNewTaskList() async {
    setState(() {
      _getNewTaskInProgress = true;
    });
    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.newTaskUrl,
    );

    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data!);
      _taskList = taskListModel.taskList!;
    } else {
      showSnackBarMessage(response.errorMessage!, true);
    }

    setState(() {
      _getNewTaskInProgress = false;
    });
  }
}
