import 'package:get/get.dart';

import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';
import '../../data/models/task_status_count_list_model.dart';
import '../../data/models/task_status_count_model.dart';
import '../../data/service/network_client.dart';
import '../../data/service/network_response.dart';
import '../../data/utils/urls.dart';

class NewTaskController extends GetxController {
  bool _getNewTaskInProgress = false;
  bool _statusCountInProgress = false;
  String? _errorMessage;
  String? _statusCountErrorMessage;
  List<TaskModel> _taskList = <TaskModel>[];

  bool get getNewTaskInProgress => _getNewTaskInProgress;
  bool get statusCountInProgress => _statusCountInProgress;
  String? get errorMessage => _errorMessage;
  String? get statusCountErrorMessage => _statusCountErrorMessage;
  List<TaskModel> get taskList => _taskList;

  TaskStatusCountModel _newTask = TaskStatusCountModel(status: 'New', count: 0);
  TaskStatusCountModel _completedTask = TaskStatusCountModel(
    status: 'Completed',
    count: 0,
  );
  TaskStatusCountModel _progressTask = TaskStatusCountModel(
    status: 'Progress',
    count: 0,
  );
  TaskStatusCountModel _canceledTask = TaskStatusCountModel(
    status: 'Canceled',
    count: 0,
  );

  TaskStatusCountModel get newTask => _newTask;
  TaskStatusCountModel get completedTask => _completedTask;
  TaskStatusCountModel get progressTask => _progressTask;
  TaskStatusCountModel get canceledTask => _canceledTask;

  Future<bool> getTaskStatusCount() async {
    bool isSuccess = false;

    _statusCountInProgress = true;
    update();

    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.taskStatusCountUrl,
    );

    if (response.isSuccess) {
      TaskStatusCountListModel taskStatusCountListModel =
          TaskStatusCountListModel.fromJson(response.data!);
      List<TaskStatusCountModel> taskStatusCountList =
          taskStatusCountListModel.statusCountList!;

      _newTask = taskStatusCountList.firstWhere(
        (task) => task.status == 'New',
        orElse: () => TaskStatusCountModel(status: 'New', count: 0),
      );
      _completedTask = taskStatusCountList.firstWhere(
        (task) => task.status == 'Completed',
        orElse: () => TaskStatusCountModel(status: 'Completed', count: 0),
      );
      _canceledTask = taskStatusCountList.firstWhere(
        (task) => task.status == 'Canceled',
        orElse: () => TaskStatusCountModel(status: 'Canceled', count: 0),
      );
      _progressTask = taskStatusCountList.firstWhere(
        (task) => task.status == 'Progress',
        orElse: () => TaskStatusCountModel(status: 'Progress', count: 0),
      );
      isSuccess = true;
    } else {
      _statusCountErrorMessage = response.errorMessage;
    }

    _statusCountInProgress = false;
    update();
    return isSuccess;
  }

  Future<bool> getAllNewTaskList() async {
    bool isSuccess = false;

    _getNewTaskInProgress = true;
    update();
    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.newTaskUrl,
    );

    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data!);
      _taskList = taskListModel.taskList!;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _getNewTaskInProgress = false;
    update();
    return isSuccess;
  }
}
