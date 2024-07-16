import 'dart:convert';

class PasswordModel {
  final String current_password;
  final String new_password;

  PasswordModel({required this.current_password, required this.new_password});

  Map<String, dynamic> toMap() {
    return {
      'current_password': current_password,
      'new_password': new_password,
    };
  }

  factory PasswordModel.fromMap(Map<String, dynamic> map) {
    return PasswordModel(
      current_password: map['current_password'] ?? '',
      new_password: map['new_password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PasswordModel.fromJson(String source) =>
      PasswordModel.fromMap(json.decode(source));
}
