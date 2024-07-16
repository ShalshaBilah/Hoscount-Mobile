// models/response/reset_password_response_model.dart
class ResetPasswordResponseModel {
  final String message;

  ResetPasswordResponseModel({required this.message});

  factory ResetPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponseModel(
      message: json['message'],
    );
  }
}
