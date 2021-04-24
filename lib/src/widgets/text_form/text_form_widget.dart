import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';

class TextFormWidget extends TextFormField {
  TextFormWidget({
    TextEditingController controller,
    @required String hintText,
    String errorText,
  }) : super(
          controller: controller,
          style: ThemeText.body1,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: ThemeText.body1.copyWith(
                  color: AppColor.hintColor,
                ),
            errorText: errorText,
            errorStyle: ThemeText.body1.copyWith(
                  color: AppColor.errorColor,
                ),
          ),
          cursorColor: AppColor.textColor,
        );
}
