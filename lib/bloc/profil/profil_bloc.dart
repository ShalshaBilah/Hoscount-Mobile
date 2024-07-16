import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:hoscountmobile/bloc/profil/profil_state.dart';
import 'package:hoscountmobile/data/datasources/auth_datasources.dart';

import 'package:meta/meta.dart';

import '../../data/model/response/profile_response_model.dart';
import 'profil_event.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthDatasource authDatasource;
  ProfileBloc(
    this.authDatasource,
  ) : super(ProfileInitial()) {
    on<GetProfileEvent>((event, emit) async {
      try {
        emit(ProfileLoading());
        final result = await authDatasource.getProfile();
        emit(ProfileLoaded(profile: result));
      } catch (e) {
        emit(ProfileError(message: 'network problem: ${e.toString()}'));
      }
    });

    on<EditProfileEvent>((event, emit) async {
      try {
        emit(ProfileLoading());

        final result = await authDatasource.editProfile(
          avatar: event.avatar,
          name: event.name,
          email: event.email,
        );

        emit(ProfileUpdated(
            message: result.message ?? 'Profile updated successfully'));
      } catch (e) {
        emit(ProfileError(message: 'An error occurred: ${e.toString()}'));
      }
    });
  }
}
