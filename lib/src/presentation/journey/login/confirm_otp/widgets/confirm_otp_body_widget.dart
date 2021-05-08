import 'dart:async';
import 'dart:developer';

import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/constants/argument_constants.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/snackbar_type.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/auth_state.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/confirm_otp/bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/confirm_otp/confirm_otp_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ConfirmOtpBodyWidget extends StatelessWidget {
  final String phone;
  final String verificationId;
  final TextEditingController otpController;
  final CustomTimerController countdownTimerController;
  final StreamController<ErrorAnimationType> errorController;

  const ConfirmOtpBodyWidget(
      {Key key,
      this.phone,
      this.verificationId,
      this.otpController,
      this.countdownTimerController,
      this.errorController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConfirmOtpBloc, ConfirmOtpState>(
        listener: (context, state) {
      if (state is ConfirmOtpInitialState) {
        if (state.authState == AuthState.sendCode) {
          log('ConfirmOtpBodyWidget - AuthState');
          countdownTimerController.reset();
          countdownTimerController.start();
        }
        if (state.authState == AuthState.error) {
          BlocProvider.of<SnackbarBloc>(context).add(ShowSnackbar(
            title: state.errorMsg,
            type: SnackBarType.error,
          ));
        }
        if (state.authState == AuthState.success) {
          Navigator.pushReplacementNamed(context, RouteList.updateProfile,
              arguments: {ArgumentConstants.fireUserArgument: state.fireUser});
        }
      }
    }, builder: (context, state) {
      if (state is ConfirmOtpInitialState)
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PinCodeTextField(
              appContext: context,
              textStyle: ThemeText.headline4,
              length: 6,
              keyboardType: TextInputType.number,
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius:
                      BorderRadius.circular(LayoutConstants.roundedRadius),
                  borderWidth: 1,
                  fieldHeight: ConfirmOtpConstants.otpFieldHeight,
                  fieldWidth: ConfirmOtpConstants.otpFieldWidth,
                  disabledColor: AppColor.paleGrey,
                  inactiveFillColor: AppColor.paleGrey,
                  inactiveColor: AppColor.paleGrey,
                  selectedColor: AppColor.primaryColor,
                  selectedFillColor: AppColor.paleGrey,
                  activeFillColor: AppColor.paleGrey,
                  activeColor: AppColor.primaryColor),
              animationDuration: Duration(milliseconds: 300),
              cursorColor: AppColor.paleGrey,
              backgroundColor: AppColor.transparent,
              enableActiveFill: true,
              errorAnimationController: errorController,
              controller: otpController,
              onCompleted: (otpCode) {
                BlocProvider.of<ConfirmOtpBloc>(context).add(VerifyOtpEvent(
                    verificationId: verificationId, smsCode: otpCode));
              },
              onChanged: (value) {
                print(value);
              },
              beforeTextPaste: (text) {
                print("Allowing to paste $text");
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
            ),
            SizedBox(
              height: LayoutConstants.paddingVertical20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      ConfirmOtpConstants.resendOtpMsgTxt,
                      style: ThemeText.caption,
                    ),
                    CustomTimer(
                      controller: countdownTimerController,
                      from: Duration(seconds: 10),
                      to: Duration(seconds: 0),
                      onBuildAction: CustomTimerAction.auto_start,
                      builder: (CustomTimerRemainingTime remaining) {
                        return Text(
                          "${remaining.minutes}:${remaining.seconds}",
                          style: ThemeText.body2,
                        );
                      },
                      onFinish: () {
                        // onFinish
                        BlocProvider.of<ConfirmOtpBloc>(context)
                            .add(ActiveResendOtpBtnEvent());
                      },
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    if (state.activeResendBtn) {
                      otpController.clear();
                      BlocProvider.of<ConfirmOtpBloc>(context)
                          .add(ResendOtpEvent(phone: phone));
                    }
                  },
                  child: Text(
                    ConfirmOtpConstants.resendOtpTxt,
                    style: ThemeText.caption.copyWith(
                        fontWeight: FontWeight.w600,
                        color: state.activeResendBtn
                            ? AppColor.primaryColor
                            : AppColor.grey),
                  ),
                )
              ],
            ),
          ],
        );
      return SizedBox();
    });
  }
}
