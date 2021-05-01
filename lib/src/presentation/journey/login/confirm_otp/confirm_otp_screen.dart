import 'dart:async';

import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/image_constants.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/confirm_otp/widgets/confirm_otp_body_widget.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'confirm_otp_constants.dart';

class ConfirmOtpScreen extends StatelessWidget {
  final String phone;
  final String verificationId;
  final TextEditingController otpController = TextEditingController();
  final CustomTimerController countdownTimerController =
      new CustomTimerController();
  final StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  ConfirmOtpScreen({Key key, this.phone, this.verificationId})
      : super(key: key);

  Widget _headerWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ConfirmOtpConstants.verifyPhoneTxt,
          style: ThemeText.headline6.copyWith(
            fontWeight: FontWeight.w900,
            color: AppColor.primaryColor,
          ),
        ),
        SizedBox(
          height: LayoutConstants.paddingVertical10,
        ),
        RichText(
            text: TextSpan(
          text: ConfirmOtpConstants.contentTxt,
          children: [
            TextSpan(
              text: phone,
              style: ThemeText.caption.copyWith(
                  fontWeight: FontWeight.w600, color: AppColor.primaryColor),
            )
          ],
          style: ThemeText.caption,
        )),
        SizedBox(
          height: LayoutConstants.paddingVertical20,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SafeArea(
            child: Image.asset(
              ImageConstants.loginBackground,
              // height: MediaQuery.of(context).size.height * 0.75,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: LayoutConstants.paddingHorizontal20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _headerWidget(),
                ConfirmOtpBodyWidget(
                  verificationId: verificationId,
                  countdownTimerController: countdownTimerController,
                  errorController: errorController,
                  otpController: otpController,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
