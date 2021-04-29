import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/utils/phone_utils.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/loader_bloc/bloc.dart';

import 'blocs.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoaderBloc loaderBloc;

  FirebaseAuth _auth;

  LoginBloc({@required this.loaderBloc});

  @override
  LoginState get initialState => LoginState(state: AuthState.initial);

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    switch (event.runtimeType) {
      case SubmitPhoneEvent:
        yield* _mapSubmitPhoneEventToState(event);
        break;
      case VerifyFailedEvent:
        yield* _mapVerifyFailedEventToState(event);
        break;
      case CodeSendEvent:
        yield* _mapCodeSendEventToState(event);
        break;
    }
  }

  Stream<LoginState> _mapSubmitPhoneEventToState(
      SubmitPhoneEvent event) async* {
    loaderBloc.add(StartLoading());
    _auth = FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
        phoneNumber: PhoneUtils.convertInternationalPhone(event.phone),
        // phoneNumber: event.phone,
        verificationCompleted: _verificationCompleted,
        verificationFailed: _verificationFailed,
        codeSent: _codeSent,
        codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout);
  }

  Stream<LoginState> _mapVerifyFailedEventToState(
      VerifyFailedEvent event) async* {
    yield LoginState(state: AuthState.error, errorMsg: event.errorMsg);
    loaderBloc.add(FinishLoading());
  }

  Stream<LoginState> _mapCodeSendEventToState(CodeSendEvent event) async* {
    yield LoginState(state: AuthState.sendCode, errorMsg: '');
    loaderBloc.add(FinishLoading());
  }

  void _verificationCompleted(PhoneAuthCredential phoneAuthCredential) {
    log('LoginBloc - verificationCompleted - phoneAuthCredential: ${phoneAuthCredential.smsCode}');
  }

  void _verificationFailed(FirebaseAuthException error) {
    add(VerifyFailedEvent(error.message));
  }

  void _codeSent(String verificationId, int forceResendingToken) {
    log('LoginBloc - codeSent - forceResendingToken: $forceResendingToken');
    log('LoginBloc - codeSent - verificationId: $verificationId');
    add(CodeSendEvent(
        verificationId: verificationId,
        forceResendingToken: forceResendingToken));
  }

  void _codeAutoRetrievalTimeout(String verificationId) {
    log('LoginBloc - codeAutoRetrievalTimeout - verificationId: $verificationId');
  }
}
