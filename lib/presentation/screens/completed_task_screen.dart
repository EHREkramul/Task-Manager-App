import 'package:flutter/material.dart';

import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';
import '../../data/service/network_client.dart';
import '../../data/service/network_response.dart';
import '../../data/utils/urls.dart';
import '../utils/snack_bar_message.dart';
import '../widgets/centered_circular_progress_bar.dart';
import '../widgets/task_item.dart';
import 'no_task_screen.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _getCompletedTaskInProgress = false;
  List<TaskModel> _taskList = <TaskModel>[];

  @override
  void initState() {
    _getAllCompletedTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Visibility(
          visible: _getCompletedTaskInProgress == false,
          replacement: CenteredCircularProgressBar(),
          child:
              _taskList.isEmpty
                  ? NoTasksScreen(category: 'Completed')
                  : ListView.builder(
                    itemCount: _taskList.length,
                    itemBuilder:
                        (context, index) => TaskItem(
                          statusColor: Colors.green,
                          task: _taskList[index],
                        ),
                  ),
        ),
      ),
    );
  }

  Future<void> _getAllCompletedTaskList() async {
    setState(() {
      _getCompletedTaskInProgress = true;
    });
    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.completedTaskUrl,
    );

    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data!);
      _taskList = taskListModel.taskList!;
    } else {
      showSnackBarMessage(response.errorMessage!, true);
    }

    setState(() {
      _getCompletedTaskInProgress = false;
    });
  }
}
