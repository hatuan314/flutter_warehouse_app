import 'package:flutter/cupertino.dart';

class AppUtils {
  static void unFocusKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    FocusManager.instance.primaryFocus.unfocus();
  }
}