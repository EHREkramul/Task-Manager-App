import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/profile_details_model.dart';
import '../../data/models/user_model.dart';
import '../../data/service/network_client.dart';
import '../../data/service/network_response.dart';
import '../../data/utils/urls.dart';
import 'auth_controller.dart';

class UpdateUserProfileController extends GetxController {
  bool _updateProfileInProgress = false;
  bool get updateProfileInProgress => _updateProfileInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> updateUserProfile(
    String email,
    String firstName,
    String lastName,
    String mobile,
    String password,
    XFile? pickedImage,
  ) async {
    bool isProfileUpdated = false;

    _updateProfileInProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email.trim(),
      "firstName": firstName.trim(),
      "lastName": lastName.trim(),
      "mobile": mobile.trim(),
    };
    if (password.isNotEmpty) {
      requestBody['password'] = password;
    }
    if (pickedImage != null) {
      List<int> imageBytes = await pickedImage.readAsBytes();
      String encodedImage = base64Encode(imageBytes);
      requestBody['photo'] = encodedImage;
    }
    NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.updateProfileUrl,
      body: requestBody,
    );

    _updateProfileInProgress = false;
    update();

    if (response.isSuccess) {
      await _getProfileDetails();
      update();
      isProfileUpdated = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    return isProfileUpdated;
  }

  Future<void> _getProfileDetails() async {
    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.profileDetailsUrl,
    );
    if (response.isSuccess) {
      ProfileDetailsModel profileDetailsModel = ProfileDetailsModel.fromJson(
        response.data!,
      );
      UserModel userModel = profileDetailsModel.userModelList!.first;

      AuthController.saveUserInformation(userModel);
      update();
    } else {
      _errorMessage = response.errorMessage;
    }
  }
}
