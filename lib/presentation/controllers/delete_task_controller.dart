import 'package:get/get.dart';

import '../../data/service/network_client.dart';
import '../../data/service/network_response.dart';
import '../../data/utils/urls.dart';

class DeleteTaskController extends GetxController {
  bool _deleteTaskInProgress = false;
  bool get deleteTaskInProgress => _deleteTaskInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> deleteTask(String taskId) async {
    bool isDeleted = false;

    _deleteTaskInProgress = true;
    update();
    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.deleteTaskUrl(taskId),
    );

    if (response.isSuccess) {
      isDeleted = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _deleteTaskInProgress = false;
    update();

    return isDeleted;
  }
}
