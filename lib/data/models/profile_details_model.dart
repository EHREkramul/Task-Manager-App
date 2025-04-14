import 'user_model.dart';

class ProfileDetailsModel {
  String? status;
  List<UserModel>? userModelList;

  ProfileDetailsModel({this.status, this.userModelList});

  ProfileDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      userModelList = <UserModel>[];
      json['data'].forEach((v) {
        userModelList!.add(UserModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    if (userModelList != null) {
      data['data'] = userModelList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
