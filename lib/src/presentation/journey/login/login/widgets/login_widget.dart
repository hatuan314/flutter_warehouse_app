import 'package:flutter/material.dart';

import 'package:flutterwarehouseapp/src/presentation/journey/login/login/login_constants.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';

class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          LoginConstants.loginTxt,
          style: ThemeText.headline6,
        ),

      ],
    );
  }
}
