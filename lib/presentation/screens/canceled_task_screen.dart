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

class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
  bool _getCanceledTaskInProgress = false;
  List<TaskModel> _taskList = <TaskModel>[];

  @override
  void initState() {
    _getAllCanceledTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Visibility(
          visible: _getCanceledTaskInProgress == false,
          replacement: CenteredCircularProgressBar(),
          child:
              _taskList.isEmpty
                  ? NoTasksScreen(category: 'NewTask')
                  : ListView.builder(
                    itemCount: _taskList.length,
                    itemBuilder:
                        (context, index) => TaskItem(
                          statusColor: Colors.redAccent,
                          task: _taskList[index],
                          updateData: _getAllCanceledTaskList,
                        ),
                  ),
        ),
      ),
    );
  }

  Future<void> _getAllCanceledTaskList() async {
    setState(() {
      _getCanceledTaskInProgress = true;
    });
    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.canceledTaskUrl,
    );

    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data!);
      _taskList = taskListModel.taskList!;
    } else {
      showSnackBarMessage(response.errorMessage!, true);
    }

    setState(() {
      _getCanceledTaskInProgress = false;
    });
  }
}
