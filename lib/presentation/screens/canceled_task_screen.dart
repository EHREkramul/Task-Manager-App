import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/canceled_task_controller.dart';
import '../utils/snack_bar_message.dart';
import '../widgets/centered_circular_progress_bar.dart';
import '../widgets/task_item.dart';
import '../widgets/no_task_indicator.dart';

class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
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
        child: GetBuilder<CanceledTaskController>(
          builder: (controller) {
            return Visibility(
              visible: controller.getCanceledTaskInProgress == false,
              replacement: CenteredCircularProgressBar(),
              child:
                  controller.taskList.isEmpty
                      ? NoTasksScreen()
                      : ListView.builder(
                        itemCount: controller.taskList.length,
                        itemBuilder:
                            (context, index) => TaskItem(
                              statusColor: Colors.redAccent,
                              task: controller.taskList[index],
                              updateData: _getAllCanceledTaskList,
                            ),
                      ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _getAllCanceledTaskList() async {
    final bool isSuccess =
        await Get.find<CanceledTaskController>().getAllCanceledTaskList();

    if (!isSuccess) {
      showSnackBarMessage(
        Get.find<CanceledTaskController>().errorMessage!,
        true,
      );
    }
  }
}
