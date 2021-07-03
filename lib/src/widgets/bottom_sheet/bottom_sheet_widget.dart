import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';

class BottomSheerWidget extends StatelessWidget {
  final String title;
  final Widget child;

  const BottomSheerWidget({Key key, @required this.title, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LayoutConstants.roundedRadius)),
      padding: EdgeInsets.symmetric(
        horizontal: LayoutConstants.paddingHorizontalApp,
        vertical: LayoutConstants.paddingVerticalApp,
      ),
      child: Scaffold(
        backgroundColor: AppColor.transparent,
        appBar: AppBar(
          backgroundColor: AppColor.transparent,
          elevation: 0,
          leading: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColor.black,
            ),
          ),
          title: Text(
            title,
            style: ThemeText.body1.copyWith(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.only(top: LayoutConstants.paddingVertical20),
          child: child,
        ),
      ),
    );
  }
}
