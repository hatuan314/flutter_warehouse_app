import 'package:flutter/material.dart';

import 'theme_color.dart';

class ThemeIcon {
  static IconThemeData getDefaultIconTheme() => const IconThemeData();
}

extension CustomIconTheme on IconThemeData {
  IconThemeData get appBarIconTheme => const IconThemeData(
    color: AppColor.primaryColor,
    size: 26,
  );
}
