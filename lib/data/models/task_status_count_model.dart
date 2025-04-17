class TaskStatusCountModel {
  String? status;
  int? count;

  TaskStatusCountModel({this.status, this.count});

  TaskStatusCountModel.fromJson(Map<String, dynamic> json) {
    status = json['_id'];
    count = json['sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = status;
    data['sum'] = count;
    return data;
  }
}
