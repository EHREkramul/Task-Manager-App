import 'package:get/get.dart';

import '../../data/service/network_client.dart';
import '../../data/service/network_response.dart';
import '../../data/utils/urls.dart';

class ChangeTaskStatusController extends GetxController {
  bool _statusUpdateInProgress = false;
  bool get statusUpdateInProgress => _statusUpdateInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> changeTaskStatus(String sId, String newStatus) async {
    bool isSuccess = false;

    _statusUpdateInProgress = true;
    update();

    final NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.updateTaskStatusUrl(sId, newStatus),
    );

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _statusUpdateInProgress = false;
    update();

    return isSuccess;
  }
}
