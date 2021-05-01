import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/configs/firebase_setup.dart';

import 'package:flutterwarehouseapp/src/presentation/blocs/loader_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';

import 'bloc.dart';

class ConfirmOtpBloc extends Bloc<ConfirmOtpEvent, ConfirmOtpState> {
  final SetupFirebaseDatabase setup;
  final LoaderBloc loaderBloc;

  ConfirmOtpBloc({@required this.setup, @required this.loaderBloc});

  @override
  ConfirmOtpState get initialState => ConfirmOtpInitialState(
      activeResendBtn: false, verifyState: ViewState.initial);

  @override
  Stream<ConfirmOtpState> mapEventToState(ConfirmOtpEvent event) async* {
    switch (event.runtimeType) {
      case ActiveResendOtpBtnEvent:
        yield* _mapActiveResendOtpBtnEventToState();
        break;
      case ResendOtpEvent:
        yield* _mapResendOtpEventToState();
        break;
      case VerifyOtpEvent:
        yield* _mapVerifyOtpEventToState(event);
        break;
    }
  }

  Stream<ConfirmOtpState> _mapVerifyOtpEventToState(
      VerifyOtpEvent event) async* {
    final currentState = state;
    if (currentState is ConfirmOtpInitialState) {
      try {
        loaderBloc.add(StartLoading());
        final credential = PhoneAuthProvider.credential(
            verificationId: event.verificationId, smsCode: event.smsCode);
        log('ConfirmOtpBloc - VerifyOtpEvent - credential: ${credential.asMap()}');
        await setup.auth.signInWithCredential(credential).then((userCredential) {
              log('ConfirmOtpBloc - VerifyOtpEvent - userCredential: ${userCredential.user.phoneNumber}');
            },
         onError: (error) {
           log('ConfirmOtpBloc - VerifyOtpEvent - error: ${error.toString()}');
         });
      } on Exception catch (e) {
        yield currentState.update(
            verifyState: ViewState.error, errorMsg: '${e.toString()}');
      }
      loaderBloc.add(FinishLoading());
    }
  }

  Stream<ConfirmOtpState> _mapActiveResendOtpBtnEventToState() async* {
    final currentState = state;
    if (currentState is ConfirmOtpInitialState) {
      yield currentState.update(activeResendBtn: true);
    }
  }

  Stream<ConfirmOtpState> _mapResendOtpEventToState() async* {
    final currentState = state;
    if (currentState is ConfirmOtpInitialState) {
      yield currentState.update(activeResendBtn: false);
    }
  }
}
