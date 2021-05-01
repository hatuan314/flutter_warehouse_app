import 'package:flutter/material.dart';

abstract class LoginEvent {}

class SubmitPhoneEvent extends LoginEvent {
  final String phone;

  SubmitPhoneEvent(this.phone);
}

class VerifyFailedEvent extends LoginEvent {
  final String errorMsg;

  VerifyFailedEvent(this.errorMsg);
}

class CodeSendEvent extends LoginEvent {
  final String verificationId;
  final int forceResendingToken;

  CodeSendEvent(
      {@required this.verificationId, @required this.forceResendingToken});
}
