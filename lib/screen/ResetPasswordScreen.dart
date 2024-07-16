import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoscountmobile/bloc/reset_password/reset_password_bloc.dart';
import 'package:hoscountmobile/bloc/reset_password/reset_password_event.dart';
import 'package:hoscountmobile/bloc/reset_password/reset_password_state.dart';

class ResetPasswordPage extends StatelessWidget {
  final TextEditingController _tokenController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reset Password'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
            listener: (context, state) {
              if (state is ResetPasswordSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Password reset successful!')),
                );
              } else if (state is ResetPasswordFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Password reset failed: ${state.error}')),
                );
              } else if (state is TokenValidationFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Token validation failed: ${state.error}')),
                );
              } else if (state is TokenValidationSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content:
                          Text('Token is valid, please reset your password')),
                );
              }
            },
            builder: (context, state) {
              if (state is ResetPasswordLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return Column(
                children: [
                  TextField(
                    controller: _tokenController,
                    decoration: const InputDecoration(labelText: 'Token'),
                  ),
                  TextField(
                    controller: _newPasswordController,
                    decoration:
                        const InputDecoration(labelText: 'New Password'),
                    obscureText: true,
                  ),
                  TextField(
                    controller: _confirmPasswordController,
                    decoration:
                        const InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     final token = _tokenController.text;

                  //     if (token.isNotEmpty) {
                  //       BlocProvider.of<ResetPasswordBloc>(context).add(
                  //         ValidateToken(token: token),
                  //       );
                  //     }
                  //   },
                  //   child: Text('Validate Token'),
                  // ),
                  // ElevatedButton(
                  ElevatedButton(
                    onPressed: () {
                      final token = _tokenController.text;
                      final newPassword = _newPasswordController.text;
                      final confirmPassword = _confirmPasswordController.text;

                      if (token.isNotEmpty &&
                          newPassword.isNotEmpty &&
                          confirmPassword.isNotEmpty) {
                        BlocProvider.of<ResetPasswordBloc>(context).add(
                          ResetPasswordSubmitted(
                            token: token,
                            newPassword: newPassword,
                            confirmPassword: confirmPassword,
                          ),
                        );
                      }
                    },
                    child: const Text('Reset Password'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
