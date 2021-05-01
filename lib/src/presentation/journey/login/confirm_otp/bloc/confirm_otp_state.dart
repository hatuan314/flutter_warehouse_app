import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';

abstract class ConfirmOtpState extends Equatable {}

class ConfirmOtpInitialState extends ConfirmOtpState {
  final ViewState verifyState;
  final bool activeResendBtn;
  final String errorMsg;

  ConfirmOtpInitialState(
      {@required this.activeResendBtn,
      @required this.verifyState,
      this.errorMsg = ''});

  ConfirmOtpInitialState update({
    bool activeResendBtn,
    ViewState verifyState,
    String errorMsg,
  }) =>
      ConfirmOtpInitialState(
          activeResendBtn: activeResendBtn ?? this.activeResendBtn,
          verifyState: verifyState ?? this.verifyState,
          errorMsg: errorMsg ?? this.errorMsg);

  @override
  List<Object> get props => [this.activeResendBtn];
}
