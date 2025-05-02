import 'package:get/get.dart';

import '../../data/service/network_client.dart';
import '../../data/service/network_response.dart';
import '../../data/utils/urls.dart';

class ForgotPassPinVerificationController extends GetxController {
  bool _verifyOtpInProgress = false;
  bool get verifyOtpInProgress => _verifyOtpInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> verifyOTP(String email, String pin) async {
    bool isVerified = false;
    _verifyOtpInProgress = true;
    update();

    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.verifyOtpUrl(email.trim(), pin.trim()),
    );

    if (response.isSuccess) {
      isVerified = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _verifyOtpInProgress = false;
    update();

    return isVerified;
  }
}
