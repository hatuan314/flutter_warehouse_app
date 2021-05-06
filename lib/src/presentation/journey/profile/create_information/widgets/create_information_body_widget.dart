import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/profile/create_information/create_information_constants.dart';
import 'package:flutterwarehouseapp/src/widgets/button/button_widget.dart';

import 'user_information_form_widget.dart';

class UpdateProfileBodyWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: LayoutConstants.paddingVertical20),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UserInformationFormWidget(
              fullNameController: fullNameController,
              emailController: emailController,
              fullNameValidator: (value) {
                if (value.isEmpty) {
                  return StringConstants.emptyField;
                }
                return null;
              },
              emailValidator: (value) {
                if (value.isNotEmpty) {
                  return ValidatorUtils.validateEmail(value);
                }
                return null;
              },
            ),
            SafeArea(
              bottom: true,
              child: ButtonWidget(
                  title: CreateInformationConstants.startTxt,
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      log('Start');
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
