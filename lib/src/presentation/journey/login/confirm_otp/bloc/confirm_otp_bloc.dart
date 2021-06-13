import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/configs/firebase_setup.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/common/utils/phone_utils.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/local/app_preference.dart';
import 'package:flutterwarehouseapp/src/domain/usecases/user_usecase.dart';

import 'package:flutterwarehouseapp/src/presentation/blocs/loader_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/user_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/auth_state.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/confirm_otp/confirm_otp_constants.dart';

import 'bloc.dart';

class ConfirmOtpBloc extends Bloc<ConfirmOtpEvent, ConfirmOtpState> {
  final SetupFirebaseDatabase setup;
  final AppPreference pref;
  final UserUseCase userUseCase;
  final LoaderBloc loaderBloc;
  final UserBloc userBloc;

  bool isTimeOut;

  ConfirmOtpBloc({
    @required this.setup,
    @required this.pref,
    @required this.userUseCase,
    @required this.loaderBloc,
    @required this.userBloc,
  });

  @override
  ConfirmOtpState get initialState => ConfirmOtpInitialState(
      activeResendBtn: false, authState: AuthState.initial);

  @override
  Stream<ConfirmOtpState> mapEventToState(ConfirmOtpEvent event) async* {
    switch (event.runtimeType) {
      case ConfirmOtpInitialEvent:
        yield* _mapConfirmOtpInitialEventToState(event);
        break;
      case ActiveResendOtpBtnEvent:
        yield* _mapActiveResendOtpBtnEventToState();
        break;
      case ResendOtpEvent:
        yield* _mapResendOtpEventToState(event);
        break;
      case VerifyOtpEvent:
        yield* _mapVerifyOtpEventToState(event);
        break;
      case VerifyFailedEvent:
        yield* _mapVerifyFailedEventToState(event);
        break;
      case CodeSendEvent:
        yield* _mapCodeSendEventToState(event);
        break;
      case VerifyOtpSuccessEvent:
        yield* _mapVerifyOtpSuccessEventToState(event);
        break;
    }
  }

  Stream<ConfirmOtpState> _mapVerifyOtpSuccessEventToState(
      VerifyOtpSuccessEvent event) async* {
    final currentState = state;
    if (currentState is ConfirmOtpInitialState) {
      final user = await userUseCase.getUser(event.fireUser.uid);
      if (user == null) {
        yield currentState.update(
            activeResendBtn: false,
            authState: AuthState.success,
            fireUser: event.fireUser,
            errorMsg: '',
            isRegistration: true);
      } else {
        userBloc.user = user;
        await pref.saveSession();
        yield currentState.update(
          activeResendBtn: false,
          authState: AuthState.success,
          fireUser: event.fireUser,
          errorMsg: '',
        );
      }
    }
  }

  Stream<ConfirmOtpState> _mapConfirmOtpInitialEventToState(
      ConfirmOtpInitialEvent event) async* {
    isTimeOut = false;
  }

  Stream<ConfirmOtpState> _mapVerifyFailedEventToState(
      VerifyFailedEvent event) async* {
    final currentState = state;
    if (currentState is ConfirmOtpInitialState) {
      yield currentState.update(
          authState: AuthState.error, errorMsg: event.errorMsg);
    }

    loaderBloc.add(FinishLoading());
  }

  Stream<ConfirmOtpState> _mapCodeSendEventToState(CodeSendEvent event) async* {
    final currentState = state;
    log('ConfirmOtpBloc - CodeSendEvent - 1');
    if (currentState is ConfirmOtpInitialState) {
      yield currentState.update(
        activeResendBtn: false,
        authState: AuthState.loading,
        errorMsg: '',
      );
      log('ConfirmOtpBloc - CodeSendEvent - 2');
      loaderBloc.add(StartLoading());
      yield currentState.update(
        activeResendBtn: false,
        authState: AuthState.sendCode,
        errorMsg: '',
      );
      loaderBloc.add(FinishLoading());
    }
  }

  Stream<ConfirmOtpState> _mapVerifyOtpEventToState(
      VerifyOtpEvent event) async* {
    final currentState = state;
    if (currentState is ConfirmOtpInitialState) {
      if (!isTimeOut) {
        try {
          loaderBloc.add(StartLoading());
          final credential = PhoneAuthProvider.credential(
              verificationId: event.verificationId, smsCode: event.smsCode);
          await setup.auth.signInWithCredential(credential).then(
              (userCredential) {
            add(VerifyOtpSuccessEvent(fireUser: userCredential.user));
          }, onError: (error) {
            add(VerifyFailedEvent(error.toString()));
          });
        } on Exception catch (e) {
          yield currentState.update(
              authState: AuthState.error, errorMsg: '${e.toString()}');
        }
      } else {
        add(VerifyFailedEvent(ConfirmOtpConstants.otpTimeOut));
      }
      loaderBloc.add(FinishLoading());
    }
  }

  Stream<ConfirmOtpState> _mapActiveResendOtpBtnEventToState() async* {
    final currentState = state;
    if (currentState is ConfirmOtpInitialState) {
      isTimeOut = true;
      yield currentState.update(
          authState: AuthState.initial, activeResendBtn: true);
    }
  }

  Stream<ConfirmOtpState> _mapResendOtpEventToState(
      ResendOtpEvent event) async* {
    setup.auth.verifyPhoneNumber(
        phoneNumber: PhoneUtils.convertInternationalPhone(event.phone),
        verificationCompleted: _verificationCompleted,
        verificationFailed: _verificationFailed,
        codeSent: _codeSent,
        codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout);
  }

  void _verificationCompleted(PhoneAuthCredential phoneAuthCredential) {
    log('ConfirmOtpBloc - verificationCompleted - phoneAuthCredential: ${phoneAuthCredential.smsCode}');
  }

  void _verificationFailed(FirebaseAuthException error) {
    add(VerifyFailedEvent(error.message));
  }

  void _codeSent(String verificationId, int forceResendingToken) {
    log('ConfirmOtpBloc - codeSent - forceResendingToken: $forceResendingToken');
    log('ConfirmOtpBloc - codeSent - verificationId: $verificationId');
    add(CodeSendEvent(forceResendingToken: forceResendingToken));
  }

  void _codeAutoRetrievalTimeout(String verificationId) {
    log('ConfirmOtpBloc - codeAutoRetrievalTimeout - verificationId: $verificationId');
  }
}
