import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/auth_state.dart';

abstract class ConfirmOtpState extends Equatable {}

class ConfirmOtpInitialState extends ConfirmOtpState {
  final AuthState authState;
  final bool activeResendBtn;
  final User fireUser;
  final String errorMsg;
  final String route;

  ConfirmOtpInitialState(
      {@required this.activeResendBtn,
      @required this.authState,
      this.fireUser,
      this.errorMsg = '',
      this.route = ''});

  ConfirmOtpInitialState update({
    bool activeResendBtn,
    String errorMsg,
    AuthState authState,
    User fireUser,
    String route,
  }) =>
      ConfirmOtpInitialState(
        activeResendBtn: activeResendBtn ?? this.activeResendBtn,
        errorMsg: errorMsg ?? this.errorMsg,
        authState: authState ?? this.authState,
        fireUser: fireUser ?? this.fireUser,
        route: route ?? this.route,
      );

  @override
  List<Object> get props => [
        this.activeResendBtn,
        this.errorMsg,
        this.authState,
        this.fireUser,
      ];
}
