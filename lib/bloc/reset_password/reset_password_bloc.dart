import 'package:bloc/bloc.dart';
import 'package:hoscountmobile/bloc/reset_password/reset_password_event.dart';
import 'package:hoscountmobile/bloc/reset_password/reset_password_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc() : super(ResetPasswordInitial()) {
    on<ResetPasswordSubmitted>(_onResetPasswordSubmitted);
    on<ValidateToken>(_onValidateToken);
  }

  Future<void> _onValidateToken(
    ValidateToken event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(ResetPasswordLoading());
    try {
      final url = 'http://192.168.202.81:5000/reset_password/${event.token}';
      print('Validating token with URL: $url');
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print('Token validation response: $responseBody');
        emit(TokenValidationSuccess());
      } else {
        final responseBody = jsonDecode(response.body);
        print('Token validation failed: $responseBody');
        emit(TokenValidationFailure(
            'Invalid or expired token: ${responseBody['message']}'));
      }
    } catch (error) {
      print('Error validating token: $error');
      emit(TokenValidationFailure('Error validating token: $error'));
    }
  }

  Future<void> _onResetPasswordSubmitted(
    ResetPasswordSubmitted event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(ResetPasswordLoading());
    try {
      final url = 'http://192.168.202.81:5000/reset_password/${event.token}';
      print('Resetting password with URL: $url');
      final response = await http.post(
        Uri.parse(url),
        body: {
          'new_password': event.newPassword,
          'confirm_password': event.confirmPassword,
        },
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print('Password reset response: $responseBody');
        emit(ResetPasswordSuccess());
      } else {
        final responseBody = jsonDecode(response.body);
        print('Password reset failed: $responseBody');
        emit(ResetPasswordFailure(
            'Failed to reset password: ${responseBody['message']}'));
      }
    } catch (error) {
      print('Error resetting password: $error');
      emit(ResetPasswordFailure('Failed to reset password: $error'));
    }
  }
}
