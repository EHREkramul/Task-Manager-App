import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/task_model.dart';
import '../../data/service/network_client.dart';
import '../../data/service/network_response.dart';
import '../../data/utils/urls.dart';
import '../utils/snack_bar_message.dart';

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
                IconButton(
                  onPressed: () {},
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
          ],
        ),
      ),
    );
  }

  Future<void> _deleteTask(String taskId) async {
    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.deleteTaskUrl(taskId),
    );

    if (response.isSuccess) {
      widget.updateData();
      showSnackBarMessage('Task Deleted Successfully');
    } else {
      showSnackBarMessage(response.errorMessage!, true);
    }
  }
}
