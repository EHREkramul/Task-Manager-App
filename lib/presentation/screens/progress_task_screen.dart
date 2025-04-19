import 'package:flutter/material.dart';

import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';
import '../../data/service/network_client.dart';
import '../../data/service/network_response.dart';
import '../../data/utils/urls.dart';
import '../utils/snack_bar_message.dart';
import '../widgets/centered_circular_progress_bar.dart';
import '../widgets/task_item.dart';
import '../widgets/no_task_indicator.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _getProgressTaskInProgress = false;
  List<TaskModel> _taskList = <TaskModel>[];

  @override
  void initState() {
    _getAllProgressTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Visibility(
          visible: _getProgressTaskInProgress == false,
          replacement: CenteredCircularProgressBar(),
          child:
              _taskList.isEmpty
                  ? NoTasksScreen()
                  : ListView.builder(
                    itemCount: _taskList.length,
                    itemBuilder:
                        (context, index) => TaskItem(
                          statusColor: Colors.purple,
                          task: _taskList[index],
                          updateData: _getAllProgressTaskList,
                        ),
                  ),
        ),
      ),
    );
  }

  Future<void> _getAllProgressTaskList() async {
    setState(() {
      _getProgressTaskInProgress = true;
    });
    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.progressTaskUrl,
    );

    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data!);
      _taskList = taskListModel.taskList!;
    } else {
      showSnackBarMessage(response.errorMessage!, true);
    }

    setState(() {
      _getProgressTaskInProgress = false;
    });
  }
}
