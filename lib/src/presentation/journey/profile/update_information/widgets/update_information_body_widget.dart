import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/profile/update_information/blocs/blocs.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/profile/update_information/blocs/update_info_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/profile/update_information/blocs/update_info_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/profile/update_information/update_information_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';
import 'package:flutterwarehouseapp/src/widgets/button/button_widget.dart';

import 'user_information_form_widget.dart';

class UpdateProfileBodyWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final User fireUser;
  final bool isRegistration;

  UpdateProfileBodyWidget({Key key, this.fireUser, this.isRegistration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateInfoBloc, UpdateInfoState>(
      listener: (context, state) {
        if (state.viewState == ViewState.success) {
          Navigator.pushReplacementNamed(context, RouteList.main);
        }
      },
      child: Padding(
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
                    title: UpdateInformationConstants.startTxt,
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        BlocProvider.of<UpdateInfoBloc>(context)
                            .add(CreateInfoEvent(
                          isRegistration: isRegistration,
                          uid: fireUser.uid,
                          imageUri: null,
                          phone: fireUser.phoneNumber,
                          email: emailController.text.trim(),
                          fullName: fullNameController.text.trim(),
                        ));
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
