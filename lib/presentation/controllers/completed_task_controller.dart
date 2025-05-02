import 'package:get/get.dart';

import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';
import '../../data/service/network_client.dart';
import '../../data/service/network_response.dart';
import '../../data/utils/urls.dart';

class CompletedTaskController extends GetxController {
  bool _getCompletedTaskInProgress = false;
  List<TaskModel> _taskList = <TaskModel>[];
  String? _errorMessage;

  List<TaskModel> get taskList => _taskList;
  bool get getCompletedTaskInProgress => _getCompletedTaskInProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> getAllCompletedTaskList() async {
    bool isSuccess = false;

    _getCompletedTaskInProgress = true;
    update();
    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.completedTaskUrl,
    );

    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data!);
      _taskList = taskListModel.taskList!;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _getCompletedTaskInProgress = false;
    update();

    return isSuccess;
  }
}
