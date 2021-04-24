import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/utils/screen_utils.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_icon.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';

ThemeData appTheme(BuildContext context) {
  ScreenUtil.init(context);
  return ThemeData(
      fontFamily: 'QS',
      primaryColor: AppColor.primaryColor,
      buttonTheme: ButtonThemeData(
        //update and enhance in screens where necessary
        buttonColor: AppColor.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LayoutConstants.roundedRadius),
        ),
      ),
      scaffoldBackgroundColor: AppColor.backgroundColor,
      iconTheme: ThemeIcon.getDefaultIconTheme(),
      appBarTheme:
          const AppBarTheme(color: AppColor.backgroundColor, elevation: 0.0),
      toggleableActiveColor: AppColor.primaryColor,
      cursorColor: AppColor.primaryColor);
}
