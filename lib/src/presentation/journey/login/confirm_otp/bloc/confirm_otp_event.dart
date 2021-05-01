import 'package:flutter/cupertino.dart';

abstract class ConfirmOtpEvent {}

class ActiveResendOtpBtnEvent extends ConfirmOtpEvent {}

class ResendOtpEvent extends ConfirmOtpEvent {}

class VerifyOtpEvent extends ConfirmOtpEvent {
  final String verificationId;
  final String smsCode;

  VerifyOtpEvent({@required this.verificationId, @required this.smsCode});
}
