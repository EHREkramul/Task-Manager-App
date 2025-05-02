import 'package:get/get.dart';

import '../../data/service/network_client.dart';
import '../../data/service/network_response.dart';
import '../../data/utils/urls.dart';

class SetPasswordController extends GetxController {
  bool _resetPassInProgress = false;
  bool get resetPassInProgress => _resetPassInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> resetPassword(
    String email,
    String otp,
    String newPassword,
  ) async {
    bool isResetSuccess = false;

    _resetPassInProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "OTP": otp,
      "password": newPassword,
    };

    NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.resetPasswordUrl,
      body: requestBody,
    );

    if (response.isSuccess) {
      isResetSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _resetPassInProgress = false;
    update();

    return isResetSuccess;
  }
}
