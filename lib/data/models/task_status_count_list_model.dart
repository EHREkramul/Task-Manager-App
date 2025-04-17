import 'task_status_count_model.dart';

class TaskStatusCountListModel {
  String? status;
  List<TaskStatusCountModel>? statusCountList;

  TaskStatusCountListModel({this.status, this.statusCountList});

  TaskStatusCountListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      statusCountList = <TaskStatusCountModel>[];
      json['data'].forEach((v) {
        statusCountList!.add(TaskStatusCountModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    if (statusCountList != null) {
      data['data'] = statusCountList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
