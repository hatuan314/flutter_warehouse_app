import 'package:flutter/material.dart';

import 'package:flutterwarehouseapp/src/presentation/journey/profile/update_information/update_information_constants.dart';
import 'package:flutterwarehouseapp/src/widgets/avatar/avatar_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/text_form/text_form_widget.dart';
import 'package:flutterwarehouseapp/common/extensions/screen_utils_extensions.dart';

class UserInformationFormWidget extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final Function(String) handlerOnFullNameSubmitted;
  final Function(String) handlerOnEmailSubmitted;
  final Function(String) fullNameValidator;
  final Function(String) emailValidator;

  const UserInformationFormWidget({
    Key key,
    @required this.fullNameController,
    @required this.emailController,
    this.handlerOnFullNameSubmitted,
    this.handlerOnEmailSubmitted,
    @required this.fullNameValidator,
    @required this.emailValidator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 50.h,
        ),
        AvatarWidget(),
        SizedBox(
          height: 30.h,
        ),
        TextFormWidget(
          controller: fullNameController,
          hintText: UpdateInformationConstants.fullNameTxt,
          handlerOnSubmitted: handlerOnFullNameSubmitted,
          validator: fullNameValidator,
        ),
        SizedBox(
          height: 8,
        ),
        TextFormWidget(
          controller: emailController,
          hintText: UpdateInformationConstants.emailTxt,
          handlerOnSubmitted: handlerOnEmailSubmitted,
          validator: emailValidator,
        ),
      ],
    );
  }
}
