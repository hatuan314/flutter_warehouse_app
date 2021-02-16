import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/common/extensions/screen_utils_extensions.dart';

class ThemeText {
  static TextTheme getDefaultTextTheme() => TextTheme(
        headline3: TextStyle(
          fontSize: 48.sp,
          color: AppColor.textColor,
          fontWeight: FontWeight.bold,
          letterSpacing: 0,
        ),
        headline5: TextStyle(
          fontSize: 24.sp,
          color: AppColor.textColor,
          fontWeight: FontWeight.normal,
          letterSpacing: 0,
        ),
        headline6: TextStyle(
          fontSize: 20.sp,
          color: AppColor.textColor,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
        bodyText1: TextStyle(
          fontSize: 16.sp,
          color: AppColor.textColor,
          letterSpacing: 0.5,
        ),
        bodyText2: TextStyle(
          fontSize: 14.sp,
          color: AppColor.textColor,
          letterSpacing: 0.25,
        ),
        button: TextStyle(
          fontSize: 14.sp,
          color: AppColor.white,
          letterSpacing: 1.25,
          fontWeight: FontWeight.bold,
        ),
        caption: TextStyle(
          fontSize: 12.sp,
          color: AppColor.textColor,
          letterSpacing: 0.4,
        ),
        overline: TextStyle(
          fontSize: 10.sp,
          color: AppColor.textColor,
          letterSpacing: 1.5,
        ),
      );
}
