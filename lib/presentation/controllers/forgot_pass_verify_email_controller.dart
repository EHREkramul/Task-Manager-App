import 'package:get/get.dart';

import '../../data/service/network_client.dart';
import '../../data/service/network_response.dart';
import '../../data/utils/urls.dart';

class ForgotPassVerifyEmailController extends GetxController {
  bool _verifyEmailInProgress = false;
  bool get verifyEmailInProgress => _verifyEmailInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> verifyEmail(String email) async {
    bool isVerified = false;

    _verifyEmailInProgress = true;
    update();

    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.verifyEmailUrl(email),
    );

    if (response.isSuccess) {
      isVerified = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _verifyEmailInProgress = false;
    update();

    return isVerified;
  }
}
