import 'dart:io';

import 'package:hoscountmobile/bloc/profil/profil_bloc.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class ProfileEvent {}

class GetProfileEvent extends ProfileEvent {}

class EditProfileEvent extends ProfileEvent {
  final File? avatar;
  final String? name;
  final String? email;

  EditProfileEvent({
    this.avatar,
    required this.name,
    required this.email,
  });
}
