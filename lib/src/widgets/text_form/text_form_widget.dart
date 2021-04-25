import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';

class TextFormWidget extends TextFormField {
  TextFormWidget({
    TextEditingController controller,
    @required String hintText,
    @required Function(String) handlerOnSubmitted,
    @required Function(String) validator,
  }) : super(
          controller: controller,
          style: ThemeText.body1,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: ThemeText.body2.copyWith(
              color: AppColor.hintColor,
            ),
            errorStyle: ThemeText.caption.copyWith(
              color: AppColor.errorColor,
            ),
            focusColor: AppColor.paleGrey,
            hoverColor: AppColor.paleGrey,
            fillColor: AppColor.paleGrey,
            filled: true,
            border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.paleGrey,
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(LayoutConstants.roundedRadius))),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.paleGrey,
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(LayoutConstants.roundedRadius))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.paleGrey,
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(LayoutConstants.roundedRadius))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.primaryColor,
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(LayoutConstants.roundedRadius))),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.primaryColor,
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(LayoutConstants.roundedRadius))),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.red,
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(LayoutConstants.roundedRadius))),
          ),
          cursorColor: AppColor.textColor,
          validator: (value) => validator(value),
          onFieldSubmitted: (value) => handlerOnSubmitted(value),
        );
}
