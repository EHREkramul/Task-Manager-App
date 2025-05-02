import 'package:get/get.dart';

import '../../data/models/login_model.dart';
import '../../data/service/network_client.dart';
import '../../data/service/network_response.dart';
import '../../data/utils/urls.dart';
import 'auth_controller.dart';

class LoginController extends GetxController {
  bool _loginInProgress = false;
  String? _errorMessage;

  bool get loginInProgress => _loginInProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> loginUser(String email, String password) async {
    bool isSuccess = false;

    _loginInProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email.trim(),
      "password": password,
    };
    NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.loginUrl,
      body: requestBody,
    );

    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(response.data!);

      AuthController.saveUserLoginInformation(
        loginModel.token!,
        loginModel.userModel!,
      );
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _loginInProgress = false;
    update();
    return isSuccess;
  }
}
