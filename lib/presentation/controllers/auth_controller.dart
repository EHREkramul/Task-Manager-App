import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/user_model.dart';

class AuthController {
  static String? token;
  static UserModel? userModel;

  static final String _tokenKey = 'token';
  static final String _userDataKey = 'user-data';

  static Future<void> saveUserInformation(
    String accessToken,
    UserModel userModelData,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_tokenKey, accessToken);
    sharedPreferences.setString(
      _userDataKey,
      jsonEncode(userModelData.toJson()),
    );

    token = accessToken;
    userModel = userModelData;
  }

  static Future<void> getUserInformation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString(_tokenKey);
    String? userModelString = sharedPreferences.getString(_userDataKey);

    if (userModelString != null) {
      UserModel userModelData = UserModel.fromJson(jsonDecode(userModelString));
      userModel = userModelData;
    }
    token = accessToken;
  }
}
