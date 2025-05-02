import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/presentation/controllers/completed_task_controller.dart';

import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';
import '../../data/service/network_client.dart';
import '../../data/service/network_response.dart';
import '../../data/utils/urls.dart';
import '../utils/snack_bar_message.dart';
import '../widgets/centered_circular_progress_bar.dart';
import '../widgets/task_item.dart';
import '../widgets/no_task_indicator.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
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
        child: GetBuilder<CompletedTaskController>(
          builder: (controller) {
            return Visibility(
              visible: controller.getCompletedTaskInProgress == false,
              replacement: CenteredCircularProgressBar(),
              child:
                  controller.taskList.isEmpty
                      ? NoTasksScreen()
                      : ListView.builder(
                        itemCount: controller.taskList.length,
                        itemBuilder:
                            (context, index) => TaskItem(
                              statusColor: Colors.green,
                              task: controller.taskList[index],
                              updateData: _getAllCompletedTaskList,
                            ),
                      ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _getAllCompletedTaskList() async {
    final bool isSuccess =
        await Get.find<CompletedTaskController>().getAllCompletedTaskList();

    if (!isSuccess) {
      showSnackBarMessage(
        Get.find<CompletedTaskController>().errorMessage!,
        true,
      );
    }
  }
}
