import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/constants/image_constants.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/snackbar_type.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/login/blocs/blocs.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';
import 'package:flutterwarehouseapp/src/widgets/button/button_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/text_form/text_form_widget.dart';

import 'login_constants.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            ImageConstants.loginBackground,
            // height: MediaQuery.of(context).size.height * 0.75,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: LayoutConstants.paddingHorizontal20, vertical: 0),
            child: SafeArea(
              child: Form(
                key: formKey,
                child: BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if(state.state == AuthState.error) {
                        BlocProvider.of<SnackbarBloc>(context).add(ShowSnackbar(
                            title: state.errorMsg,
                            type: SnackBarType.error));
                      }
                      if (state.state == AuthState.sendCode) {
                        BlocProvider.of<SnackbarBloc>(context).add(ShowSnackbar(
                            title: "Send OTP Code",
                            type: SnackBarType.success));
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LoginConstants.loginTxt,
                            style: ThemeText.headline6
                                .copyWith(fontWeight: FontWeight.w900),
                          ),
                          SizedBox(
                            height: LayoutConstants.paddingVertical20,
                          ),
                          TextFormWidget(
                            handlerOnSubmitted: (phone) =>
                                _onLogin(context, phone),
                            controller: phoneController,
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
