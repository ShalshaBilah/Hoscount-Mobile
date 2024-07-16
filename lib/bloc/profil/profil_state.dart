import 'package:hoscountmobile/data/model/response/profile_response_model.dart';
import 'package:hoscountmobile/bloc/profil/profil_bloc.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileResponseModel profile;
  ProfileLoaded({
    required this.profile,
  });
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError({
    required this.message,
  });
}

class ProfileUpdated extends ProfileState {
  final String message;
  ProfileUpdated({
    required this.message,
  });
}
