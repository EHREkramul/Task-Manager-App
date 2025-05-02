import 'package:get/get.dart';

import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';
import '../../data/service/network_client.dart';
import '../../data/service/network_response.dart';
import '../../data/utils/urls.dart';

class CanceledTaskController extends GetxController {
  bool _getCanceledTaskInProgress = false;
  List<TaskModel> _taskList = <TaskModel>[];
  String? _errorMessage;

  List<TaskModel> get taskList => _taskList;
  bool get getCanceledTaskInProgress => _getCanceledTaskInProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> getAllCanceledTaskList() async {
    bool isSuccess = false;

    _getCanceledTaskInProgress = true;
    update();
    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.canceledTaskUrl,
    );

    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data!);
      _taskList = taskListModel.taskList!;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _getCanceledTaskInProgress = false;
    update();

    return isSuccess;
  }
}
