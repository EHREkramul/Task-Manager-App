import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
    required this.index,
    required this.statusColor,
  });

  final String title;
  final String description;
  final DateTime date;
  final String status;
  final int index;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      elevation: 4,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
            Text(
              'Date: ${DateFormat('dd MMMM, yyyy hh:mm a').format(date)}',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(status, style: TextStyle(color: Colors.white)),
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
                  onPressed: () {},
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
}
