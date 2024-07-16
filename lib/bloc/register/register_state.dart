import 'package:hoscountmobile/data/model/response/register_response_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterLoaded extends RegisterState {
  final RegisterResponseModel model;

  RegisterLoaded({required this.model});
}
