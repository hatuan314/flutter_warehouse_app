import 'package:flutterwarehouseapp/src/presentation/journey/login/auth_state.dart';

class LoginState {
  final AuthState state;
  String errorMsg;
  String verificationId;
  int forceResendingToken;

  LoginState(
      {this.state,
      this.errorMsg = '',
      this.verificationId,
      this.forceResendingToken});

  LoginState update({
    AuthState state,
    String errorMsg,
    String verificationId,
    int forceResendingToken,
  }) =>
      LoginState(
        state: state ?? this.state,
        errorMsg: errorMsg ?? this.errorMsg,
        verificationId: verificationId ?? this.verificationId,
        forceResendingToken: forceResendingToken ?? this.forceResendingToken,
      );
}
