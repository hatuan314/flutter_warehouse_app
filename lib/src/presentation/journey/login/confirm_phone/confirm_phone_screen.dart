import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/constants/argument_constants.dart';
import 'package:flutterwarehouseapp/common/constants/image_constants.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/snackbar_type.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/dev_mode_screen.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/auth_state.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/confirm_phone/blocs/blocs.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';
import 'package:flutterwarehouseapp/src/widgets/button/button_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/text_form/text_form_widget.dart';

import 'confirm_phone_constants.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.backgroundColor,
      child: Stack(
        children: [
          Column(
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
                    horizontal: LayoutConstants.paddingHorizontal20,
                    vertical: 0),
                child: Form(
                  key: formKey,
                  child: BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) {
                    if (state.state == AuthState.error) {
                      BlocProvider.of<SnackbarBloc>(context).add(ShowSnackbar(
                          title: state.errorMsg, type: SnackBarType.error));
                    }
                    if (state.state == AuthState.sendCode) {
                      Navigator.pushNamed(context, RouteList.confirmOtp,
                          arguments: {
                            ArgumentConstants.verificationIdArgument:
                                state.verificationId,
                            ArgumentConstants.phoneArgument:
                                phoneController.text
                          });
                    }
                  }, builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LoginConstants.loginTxt,
                          style: ThemeText.headline6.copyWith(
                              fontWeight: FontWeight.w900,
                              color: AppColor.primaryColor),
                        ),
                        SizedBox(
                          height: LayoutConstants.paddingVertical20,
                        ),
                        TextFormWidget(
                          autoFocus: true,
                          handlerOnSubmitted: (phone) =>
                              _onLogin(context, phone),
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          hintText: LoginConstants.hintPhoneTxt,
                          validator: (value) {
                            return ValidatorUtils.validatePhoneNumber(value);
                          },
                        ),
                        SizedBox(
                          height: LayoutConstants.paddingVertical20,
                        ),
                        ButtonWidget(
                          title: LoginConstants.loginTxt,
                          onPressed: () =>
                              _onLogin(context, phoneController.text),
                        )
                      ],
                    );
                  }),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DevModeScreen()));
              },
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Dev Mode',
                    style: ThemeText.caption,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onLogin(BuildContext context, String phone) {
    if (formKey.currentState.validate()) {
      BlocProvider.of<LoginBloc>(context).add(SubmitPhoneEvent(phone));
    }
  }
}
