import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';

class BottomSheetWidget extends StatelessWidget {
  final String title;
  final Widget child;
  final EdgeInsets bodyPadding;
  final bool isExpanded;

  const BottomSheetWidget({Key key, @required this.title, @required this.child, this.bodyPadding, this.isExpanded = false}) : super(key: key);

  Widget _buildBody(BuildContext context) {
    if(isExpanded) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppBar(
            backgroundColor: AppColor.transparent,
            elevation: 0,
            title: Text(
              title,
              style: ThemeText.body1.copyWith(fontWeight: FontWeight.w600),
            ),
            actions: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.cancel,
                  color: AppColor.black,
                ),
              )
            ],
            centerTitle: true,
          ),
          Padding(
            padding: bodyPadding ?? EdgeInsets.only(top: LayoutConstants.paddingVertical20),
            child: child,
          )
        ],
      );
    } else {
      return Scaffold(
        backgroundColor: AppColor.transparent,
        appBar: AppBar(
          backgroundColor: AppColor.transparent,
          elevation: 0,
          title: Text(
            title,
            style: ThemeText.body1.copyWith(fontWeight: FontWeight.w600),
          ),
          actions: [
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.cancel,
                color: AppColor.black,
              ),
            )
          ],
          centerTitle: true,
        ),
        body: Padding(
          padding: bodyPadding ?? EdgeInsets.only(top: LayoutConstants.paddingVertical20),
          child: child,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(LayoutConstants.roundedRadius)),
      padding: EdgeInsets.symmetric(
        horizontal: LayoutConstants.paddingHorizontalApp,
        vertical: LayoutConstants.paddingVerticalApp,
      ),
      child: SafeArea(child: _buildBody(context)),
    );
  }
}
