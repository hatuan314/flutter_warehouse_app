import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';
import 'package:flutterwarehouseapp/src/widgets/text_form/text_form_constants.dart';

class TextFormWidget extends TextFormField {
  TextFormWidget({
    TextEditingController controller,
    bool autoFocus = false,
    TextInputType keyboardType,
    @required String hintText,
    Color backgroundColor,
    Function(String) handlerOnSubmitted,
    @required Function(String) validator,
  }) : super(
          controller: controller,
          style: ThemeText.body1,
          keyboardType: keyboardType,
          autofocus: autoFocus,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: ThemeText.body2.copyWith(
              color: AppColor.hintColor,
            ),
            errorStyle: ThemeText.caption.copyWith(
              color: AppColor.errorColor,
            ),
            contentPadding: EdgeInsets.fromLTRB(
                TextFormConstants.paddingHorizontal,
                TextFormConstants.paddingTop,
                TextFormConstants.paddingHorizontal,
                TextFormConstants.paddingBottom),
            focusColor: AppColor.paleGrey,
            hoverColor: AppColor.paleGrey,
            fillColor: backgroundColor ?? AppColor.paleGrey,
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

  TextFormWidget.withPrefixIcon({
    bool autoFocus = false,
    TextEditingController controller,
    TextInputType keyboardType,
    @required String hintText,
    Color backgroundColor,
    @required IconData icon,
    Function(String) handlerOnSubmitted,
    @required Function(String) validator,
  }) : super(
          controller: controller,
          style: ThemeText.body1,
          keyboardType: keyboardType,
          autofocus: autoFocus,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: ThemeText.body2.copyWith(
              color: AppColor.hintColor,
            ),
            errorStyle: ThemeText.caption.copyWith(
              color: AppColor.errorColor,
            ),
            contentPadding: EdgeInsets.fromLTRB(
                TextFormConstants.paddingHorizontal,
                TextFormConstants.paddingTop,
                TextFormConstants.paddingHorizontal,
                TextFormConstants.paddingBottom),
            focusColor: AppColor.paleGrey,
            hoverColor: AppColor.paleGrey,
            fillColor: backgroundColor ?? AppColor.paleGrey,
            filled: true,
            prefixIcon: Icon(
              icon,
              color: AppColor.grey,
            ),
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
