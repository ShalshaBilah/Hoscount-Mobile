import 'package:hoscountmobile/bloc/change_password/change_password_bloc.dart';
import 'package:hoscountmobile/data/model/requests/password_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController? currentPasswordController;
  TextEditingController? newPasswordController;

  bool _isObscured = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    currentPasswordController!.dispose();
    newPasswordController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        backgroundColor: const Color.fromRGBO(209, 209, 239, 1),
        centerTitle: true,
      ),
      body: BlocListener<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccess) {
            currentPasswordController!.clear();
            newPasswordController!.clear();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Password changed successfully')),
            );
          } else if (state is ChangePasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Failed to change password: ${state.error}')),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: currentPasswordController,
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscured ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
                obscureText: _isObscured,
              ),
              TextField(
                controller: newPasswordController,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscured ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
                obscureText: _isObscured,
              ),
              const SizedBox(height: 20),
              BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                builder: (context, state) {
                  if (state is ChangePasswordLoading) {
                    return const CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    onPressed: () {
                      final requestModel = PasswordModel(
                          current_password: currentPasswordController!.text,
                          new_password: newPasswordController!.text);
                      context
                          .read<ChangePasswordBloc>()
                          .add(ChangePassword(passwordModel: requestModel));
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: const Color.fromRGBO(209, 209, 239, 1),
                    ),
                    child: const Text('Change Password'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
