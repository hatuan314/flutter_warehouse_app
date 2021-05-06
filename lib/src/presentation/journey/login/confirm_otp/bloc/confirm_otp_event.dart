import 'package:flutter/cupertino.dart';

abstract class ConfirmOtpEvent {}

class ConfirmOtpInitialEvent extends ConfirmOtpEvent {}

class ActiveResendOtpBtnEvent extends ConfirmOtpEvent {}

class ResendOtpEvent extends ConfirmOtpEvent {
  final String phone;

  ResendOtpEvent({@required this.phone});
}

class VerifyOtpEvent extends ConfirmOtpEvent {
  final String verificationId;
  final String smsCode;

  VerifyOtpEvent({@required this.verificationId, @required this.smsCode});
}

class VerifyFailedEvent extends ConfirmOtpEvent {
  final String errorMsg;

  VerifyFailedEvent(this.errorMsg);
}

class CodeSendEvent extends ConfirmOtpEvent {
  final int forceResendingToken;

  CodeSendEvent({@required this.forceResendingToken});
}
