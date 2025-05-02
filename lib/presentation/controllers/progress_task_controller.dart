import 'package:get/get.dart';

import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';
import '../../data/service/network_client.dart';
import '../../data/service/network_response.dart';
import '../../data/utils/urls.dart';

class ProgressTaskController extends GetxController {
  bool _getProgressTaskInProgress = false;
  List<TaskModel> _taskList = <TaskModel>[];
  String? _errorMessage;

  List<TaskModel> get taskList => _taskList;
  bool get getProgressTaskInProgress => _getProgressTaskInProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> getAllProgressTaskList() async {
    bool isSuccess = false;

    _getProgressTaskInProgress = true;
    update();

    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.progressTaskUrl,
    );

    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data!);
      _taskList = taskListModel.taskList!;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _getProgressTaskInProgress = false;
    update();

    return isSuccess;
  }
}
