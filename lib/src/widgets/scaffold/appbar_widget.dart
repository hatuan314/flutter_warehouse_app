import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/extensions/list_extensions.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';

class AppbarWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color leadingColor;
  final String title;
  final List<Widget> actions;
  final Function onLeading;

  const AppbarWidget({
    Key key,
    this.backgroundColor,
    this.leadingColor,
    @required this.title,
    this.actions,
    @required this.onLeading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? AppColor.primaryColor,
      child: SafeArea(
        bottom: false,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: onLeading,
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      height: LayoutConstants.buttonHeight,
                      width: LayoutConstants.buttonHeight,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: LayoutConstants.iconSize,
                        color: leadingColor ?? AppColor.white,
                      ),
                    ),
                  ),
                  Text(
                    '$title',
                    style: ThemeText.subtitle1.copyWith(color: AppColor.white),
                  ),
                ],
              ),
              actions.isNotSafe ? SizedBox() : Row(
                mainAxisSize: MainAxisSize.min,
                children: actions,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
