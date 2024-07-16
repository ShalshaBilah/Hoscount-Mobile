import 'package:hoscountmobile/data/model/requests/register_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class RegisterEvent {}

class SaveRegisterEvent extends RegisterEvent {
  final RegisterModel request;

  SaveRegisterEvent({required this.request});
}
