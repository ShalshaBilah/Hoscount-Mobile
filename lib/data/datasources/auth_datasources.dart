import 'dart:convert';
import 'dart:io';

import 'package:hoscountmobile/data/localsources/auth_local_storage.dart';
import 'package:hoscountmobile/data/model/requests/login_model.dart';
import 'package:hoscountmobile/data/model/requests/password_model.dart';
import 'package:hoscountmobile/data/model/response/edit_profil_response_model.dart';
import 'package:hoscountmobile/data/model/response/forgotpassword_response_model.dart';
import 'package:hoscountmobile/data/model/response/login_response_model.dart';
import 'package:hoscountmobile/data/model/response/profile_response_model.dart';
import 'package:http/http.dart';

import '../model/requests/register_model.dart';
import '../model/response/register_response_model.dart';
import 'package:http/http.dart' as http;

class AuthDatasource {
  final baseUrl = 'http://194.31.53.102:21085';

  Future<RegisterResponseModel> register(RegisterModel registerModel) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      body: registerModel.toMap(),
    );

    final result = RegisterResponseModel.fromJson(response.body);
    return result;
  }

  Future<LoginResponseModel> login(LoginModel loginModel) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signin'),
      body: loginModel.toMap(),
    );

    if (response.statusCode == 200) {
      final result = LoginResponseModel.fromJson(response.body);
      return result;
    } else {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (response.statusCode == 403 &&
          responseBody['message'] ==
              'Please verify your email before logging in.') {
        throw Exception(
            'Email not verified. Please verify your email before logging in.');
      } else {
        throw Exception(responseBody['message']);
      }
    }
  }

  Future<ProfileResponseModel> getProfile() async {
    final token = await AuthLocalStorage().getToken();
    var headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(
      Uri.parse('$baseUrl/protected'),
      headers: headers,
    );

    final result = ProfileResponseModel.fromJson(response.body);
    return result;
  }

  Future<EditProfileResponseModel> editProfile({
    File? avatar,
    String? name,
    String? email,
  }) async {
    final token = await AuthLocalStorage().getToken();
    var headers = {
      'Authorization': 'Bearer $token',
      // 'Content-Type': 'multipart/form-data',
    };

    var request = MultipartRequest('PUT', Uri.parse('$baseUrl/edit_profile'));
    request.headers.addAll(headers);

    request.fields['name'] = name!;
    request.fields['email'] = email!;

    if (avatar != null) {
      request.files.add(await MultipartFile.fromPath('file', avatar.path));
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final result = EditProfileResponseModel.fromJson(responseBody);
      return result;
    } else {
      throw Exception('Failed to update profile');
    }
  }

  Future<ForgotPasswordResponseModel> forgotPassword(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/forgot_password'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {'email': email},
      );

      if (response.statusCode == 200) {
        return ForgotPasswordResponseModel.fromJson(json.decode(response.body));
      } else {
        final responseBody = jsonDecode(response.body);
        throw Exception(
            'Failed to send password reset email: ${responseBody['message']}');
      }
    } catch (e) {
      throw Exception('Failed to send password reset email: ${e.toString()}');
    }
  }

  Future<EditProfileResponseModel> changePassword(
      PasswordModel passwordModel) async {
    final token = await AuthLocalStorage().getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/change_password'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: passwordModel.toMap(),
    );

    final result = EditProfileResponseModel.fromJson(response.body);

    if (response.statusCode != 200) {
      throw Exception('current password is wrong!');
    }

    return result;
  }
}
