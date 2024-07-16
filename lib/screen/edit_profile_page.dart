import 'dart:io';

import 'package:hoscountmobile/bloc/profil/profil_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoscountmobile/bloc/profil/profil_event.dart';
import 'package:hoscountmobile/bloc/profil/profil_state.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  TextEditingController? _nameController;
  TextEditingController? _emailController;
  String? nameError;
  String? emailError;

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(GetProfileEvent());
    _nameController = TextEditingController();
    _emailController = TextEditingController();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void validateInputs() {
    setState(() {
      nameError = _nameController!.text.isEmpty ? 'Name cannot be empty' : null;
      emailError =
          _emailController!.text.isEmpty ? 'Email cannot be empty' : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.read<ProfileBloc>().add(GetProfileEvent());
          } else if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.read<ProfileBloc>().add(GetProfileEvent());
          }
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoaded) {
              _nameController!.text = state.profile.name ?? '';
              _emailController!.text = state.profile.email ?? '';

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: _image != null
                                ? FileImage(_image!)
                                : NetworkImage(state.profile.avatar ??
                                        'https://example.com/default-avatar.png')
                                    as ImageProvider,
                          ),
                          const Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.add_a_photo,
                                  size: 20, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: const OutlineInputBorder(),
                        errorText: nameError,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: const OutlineInputBorder(),
                        errorText: emailError,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        validateInputs();
                        if (nameError == null && emailError == null) {
                          context.read<ProfileBloc>().add(EditProfileEvent(
                                avatar: _image,
                                name: _nameController!.text,
                                email: _emailController!.text,
                              ));
                        }
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              );
            } else if (state is ProfileError) {
              return Center(child: Text(state.message));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController?.dispose();
    _emailController?.dispose();
    super.dispose();
  }
}
