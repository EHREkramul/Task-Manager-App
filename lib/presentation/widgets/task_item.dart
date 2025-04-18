import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../app/app.dart';
import '../../data/models/task_model.dart';
import '../../data/service/network_client.dart';
import '../../data/service/network_response.dart';
import '../../data/utils/urls.dart';
import '../utils/snack_bar_message.dart';
import 'centered_circular_progress_bar.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({
    super.key,
    required this.task,
    required this.statusColor,
    required this.updateData,
  });
  final TaskModel task;
  final Color statusColor;
  final VoidCallback updateData;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _statusUpdateInProgress = false;
  bool _deleteTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    final TaskModel task = widget.task;
    final Color statusColor = widget.statusColor;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      elevation: 4,
      child: ListTile(
        title: Text(
          task.title ?? '',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.description ?? '',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
            Text(
              'Date: ${DateFormat('dd MMMM, yyyy hh:mm a').format(DateTime.parse(task.createdDate ?? '').toLocal())}',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    task.status ?? '',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: statusColor,
                  side: BorderSide.none,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                ),
                Spacer(),
                Visibility(
                  visible:
                      _deleteTaskInProgress == false &&
                      _statusUpdateInProgress == false,
                  replacement: CenteredCircularProgressBar(),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: _showUpdateStatusDialogue,
                        style: IconButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        icon: Icon(Icons.edit_note, color: Colors.green),
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        onPressed: () => _deleteTask(task.sId ?? ''),
                        style: IconButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        icon: Icon(Icons.delete, color: Colors.redAccent),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteTask(String taskId) async {
    setState(() {
      _deleteTaskInProgress = true;
    });
    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.deleteTaskUrl(taskId),
    );

    if (response.isSuccess) {
      widget.updateData();
      showSnackBarMessage('Task Deleted Successfully');
    } else {
      showSnackBarMessage(response.errorMessage!, true);
    }
    setState(() {
      _deleteTaskInProgress = false;
    });
  }

  void _showUpdateStatusDialogue() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('New'),
                trailing: isSelected('New'),
                onTap: () {
                  if (widget.task.status == 'New') {
                    Navigator.pop(context);
                  } else {
                    _changeTaskStatus('New');
                  }
                },
              ),

              ListTile(
                title: Text('Completed'),
                trailing: isSelected('Completed'),
                onTap: () {
                  if (widget.task.status == 'Completed') {
                    Navigator.pop(context);
                  } else {
                    _changeTaskStatus('Completed');
                  }
                },
              ),
              ListTile(
                title: Text('Canceled'),
                trailing: isSelected('Canceled'),
                onTap: () {
                  if (widget.task.status == 'Canceled') {
                    Navigator.pop(context);
                  } else {
                    _changeTaskStatus('Canceled');
                  }
                },
              ),
              ListTile(
                title: Text('Progress'),
                trailing: isSelected('Progress'),
                onTap: () {
                  if (widget.task.status == 'Progress') {
                    Navigator.pop(context);
                  } else {
                    _changeTaskStatus('Progress');
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget? isSelected(String status) {
    return widget.task.status == status ? Icon(Icons.done) : null;
  }

  Future<void> _changeTaskStatus(String newStatus) async {
    Navigator.pop(TaskManagerApp.navigatorKey.currentContext!);
    setState(() {
      _statusUpdateInProgress = true;
    });

    final NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.updateTaskStatusUrl(widget.task.sId!, newStatus),
    );

    if (response.isSuccess) {
      widget.updateData();
      showSnackBarMessage('Task marked as $newStatus');
    } else {
      setState(() {
        _statusUpdateInProgress = false;
      });
      showSnackBarMessage(response.errorMessage!, true);
    }
  }
}
