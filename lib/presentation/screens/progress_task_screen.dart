import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/progress_task_controller.dart';
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
        child: GetBuilder<ProgressTaskController>(
          builder: (controller) {
            return Visibility(
              visible: controller.getProgressTaskInProgress == false,
              replacement: CenteredCircularProgressBar(),
              child:
                  controller.taskList.isEmpty
                      ? NoTasksScreen()
                      : ListView.builder(
                        itemCount: controller.taskList.length,
                        itemBuilder:
                            (context, index) => TaskItem(
                              statusColor: Colors.purple,
                              task: controller.taskList[index],
                              updateData: _getAllProgressTaskList,
                            ),
                      ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _getAllProgressTaskList() async {
    final bool isSuccess =
        await Get.find<ProgressTaskController>().getAllProgressTaskList();

    if (!isSuccess) {
      showSnackBarMessage(
        Get.find<ProgressTaskController>().errorMessage!,
        true,
      );
    }
  }
}
