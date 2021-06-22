import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/extensions/string_extensions.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/add_distributor/add_distributor_constants.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/widgets/text_form/text_form_widget.dart';

class DistributorFormWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController firstPhoneController;
  final TextEditingController secondPhoneController;
  final TextEditingController firstEmailController;
  final TextEditingController secondEmailController;

  const DistributorFormWidget({
    Key key,
    @required this.nameController,
    @required this.firstPhoneController,
    @required this.secondPhoneController,
    @required this.firstEmailController,
    @required this.secondEmailController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormWidget.withPrefixIcon(
            autoFocus: true,
            controller: nameController,
            icon: Icons.store,
            hintText: AddDistributorConstants.nameTxt,
            backgroundColor: AppColor.white,
            validator: (value) {
              return ValidatorUtils.validateEmptyField(value);
            }),
        SizedBox(
          height: LayoutConstants.paddingVertical10,
        ),
        TextFormWidget.withPrefixIcon(
            controller: firstPhoneController,
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
            hintText: AddDistributorConstants.firstPhoneTxt,
            backgroundColor: AppColor.white,
            validator: (value) {
              if (value.isSafe)
                return ValidatorUtils.validatePhoneNumber(value);
              return null;
            }),
        SizedBox(
          height: LayoutConstants.paddingVertical10,
        ),
        TextFormWidget.withPrefixIcon(
            controller: secondPhoneController,
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
            hintText: AddDistributorConstants.secondPhoneTxt,
            backgroundColor: AppColor.white,
            validator: (value) {
              if (value.isSafe)
                return ValidatorUtils.validatePhoneNumber(value);
              return null;
            }),
        SizedBox(
          height: LayoutConstants.paddingVertical10,
        ),
        TextFormWidget.withPrefixIcon(
            controller: firstEmailController,
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            hintText: AddDistributorConstants.firstEmailTxt,
            backgroundColor: AppColor.white,
            validator: (value) {
              if (value.isSafe) return ValidatorUtils.validateEmail(value);
              return null;
            }),
        SizedBox(
          height: LayoutConstants.paddingVertical10,
        ),
        TextFormWidget.withPrefixIcon(
            controller: secondEmailController,
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            hintText: AddDistributorConstants.secondEmailTxt,
            backgroundColor: AppColor.white,
            validator: (value) {
              if (value.isSafe) return ValidatorUtils.validateEmail(value);
              return null;
            }),
      ],
    );
  }
}
