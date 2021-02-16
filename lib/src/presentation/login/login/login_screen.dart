import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/image_constants.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/login/login/login_constants.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';
import 'package:flutterwarehouseapp/src/widgets/button/button_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/text_form/text_form_widget.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(
            ImageConstants.loginBackground,
            // height: MediaQuery.of(context).size.height * 0.75,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: LayoutConstants.paddingHorizontal20,
              vertical: 0
            ),
            child: SafeArea(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LoginConstants.loginTxt,
                      style: ThemeText.getDefaultTextTheme()
                          .headline6
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: LayoutConstants.paddingVertical20,
                    ),
                    TextFormWidget(
                      controller: phoneController,
                      hintText: LoginConstants.hintPhoneTxt,
                    ),
                    SizedBox(
                      height: LayoutConstants.paddingVertical20,
                    ),
                    ButtonWidget(
                      title: LoginConstants.loginTxt,
                      onPressed: () => _onLogin(context),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onLogin(BuildContext context) {}
}
