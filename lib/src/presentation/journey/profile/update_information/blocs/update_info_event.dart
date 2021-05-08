import 'package:flutter/material.dart';

abstract class UpdateInfoEvent {}

class CreateInfoEvent extends UpdateInfoEvent {
  final String uid;
  final String imageUri;
  final String phone;
  final String email;
  final String fullName;

  CreateInfoEvent(
      {@required this.uid,
      @required this.imageUri,
      @required this.phone,
      @required this.email,
      @required this.fullName});
}
