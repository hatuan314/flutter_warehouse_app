import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/extensions/list_extensions.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';

class AppbarWidget extends StatelessWidget {
  final bool isLeading;
  final Color backgroundColor;
  final Color leadingColor;
  final String title;
  final Widget tabBar;
  final List<Widget> actions;
  final Function onLeading;

  const AppbarWidget({
    Key key,
    this.isLeading = true,
    this.backgroundColor,
    this.leadingColor,
    this.tabBar,
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      isLeading
                          ? GestureDetector(
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
                            )
                          : SizedBox.shrink(),
                      Padding(
                        padding: isLeading
                            ? EdgeInsets.zero
                            : EdgeInsets.symmetric(
                                horizontal: LayoutConstants.paddingHorizontalApp,
                          vertical: LayoutConstants.paddingVerticalApp
                              ),
                        child: Text(
                          '$title',
                          style: ThemeText.subtitle1.copyWith(color: AppColor.white),
                        ),
                      ),
                    ],
                  ),
                  actions.isNotSafe
                      ? SizedBox()
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: actions,
                        ),
                ],
              ),
              tabBar ?? SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
