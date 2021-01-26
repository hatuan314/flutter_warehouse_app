import 'package:flutter/material.dart';

import 'package:flutterwarehouseapp/common/extensions/screen_utils_extensions.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';

class ThemeText {
  static TextTheme getDefaultTextTheme() => TextTheme(
    headline3: TextStyle(fontSize: 48.sp, color: AppColor.textColor, fontWeight: FontWeight.bold),
    bodyText2: TextStyle(fontSize: 16.sp, color: AppColor.textColor)
  );
}