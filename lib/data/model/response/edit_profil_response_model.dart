import 'dart:convert';

class EditProfileResponseModel {
  String? message;

  EditProfileResponseModel({this.message});

  factory EditProfileResponseModel.fromJson(String str) =>
      EditProfileResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EditProfileResponseModel.fromMap(Map<String, dynamic> json) =>
      EditProfileResponseModel(
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "message": message,
      };
}
