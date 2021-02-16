import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';

class ButtonWidget extends RaisedButton {
  ButtonWidget({@required String title, @required Function onPressed})
      : super(
          elevation: 0,
          padding: EdgeInsets.symmetric(
            vertical: LayoutConstants.paddingVertical15,
          ),
          color: AppColor.primaryColor,
          onPressed: onPressed,
          child: SizedBox(
            width: double.infinity,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: ThemeText.getDefaultTextTheme().button,
              ),
            ),
          ),
        );
}
