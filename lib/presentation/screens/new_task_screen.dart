import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/new_task_controller.dart';
import '../widgets/no_task_indicator.dart';
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
  final NewTaskController newTaskController = Get.find<NewTaskController>();

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
          Get.to(AddNewTaskScreen());
        },
        backgroundColor: Color.fromARGB(255, 33, 191, 115),
        foregroundColor: Colors.white,
        shape: CircleBorder(),
        child: Icon(Icons.add, size: 30),
      ),
      body: GetBuilder<NewTaskController>(
        builder: (controller) {
          return Visibility(
            visible:
                newTaskController.statusCountInProgress == false &&
                newTaskController.getNewTaskInProgress == false,
            replacement: CenteredCircularProgressBar(),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                spacing: 10,
                children: [
                  _buildSummarySection(),
                  Expanded(
                    child:
                        controller.taskList.isEmpty
                            ? NoTasksScreen()
                            : ListView.builder(
                              itemCount: controller.taskList.length,
                              itemBuilder:
                                  (context, index) => TaskItem(
                                    statusColor: Colors.blue,
                                    task: controller.taskList[index],
                                    updateData: () {
                                      _getAllNewTaskList();
                                      _getTaskStatusCount();
                                    },
                                  ),
                            ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummarySection() {
    return Row(
      children: [
        SummaryCard(
          count: newTaskController.newTask.count.toString(),
          status: 'New Task',
        ),
        SummaryCard(
          count: newTaskController.completedTask.count.toString(),
          status: 'Completed',
        ),
        SummaryCard(
          count: newTaskController.canceledTask.count.toString(),
          status: 'Canceled',
        ),
        SummaryCard(
          count: newTaskController.progressTask.count.toString(),
          status: 'Progress',
        ),
      ],
    );
  }

  Future<void> _getTaskStatusCount() async {
    final bool isSuccess = await newTaskController.getTaskStatusCount();

    if (!isSuccess) {
      showSnackBarMessage(newTaskController.statusCountErrorMessage!, true);
    }
  }

  Future<void> _getAllNewTaskList() async {
    final bool isSuccess = await newTaskController.getAllNewTaskList();
    if (!isSuccess) {
      showSnackBarMessage(newTaskController.errorMessage!, true);
    }
  }
}
