import 'user_model.dart';

class LoginModel {
  String? status;
  UserModel? userModel;
  String? token;

  LoginModel({this.status, this.userModel, this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userModel = UserModel.fromJson(json['data']);
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['status'] = status;
    if (userModel != null) {
      data['data'] = userModel!.toJson();
    }

    data['token'] = token;

    return data;
  }
}
