import 'package:flutter/material.dart';

import 'package:flutterwarehouseapp/common/extensions/screen_utils_extensions.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';

import 'appbar_widget.dart';

class ScaffoldWidget extends StatelessWidget {
  final bool isLeading;
  final String title;
  final Function onLeading;
  final Widget child;
  final Widget floatingActionButton;
  final List<Widget> actions;

  const ScaffoldWidget({
    Key key,
    this.isLeading = false,
    this.title,
    this.onLeading,
    this.child,
    this.actions,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      // appBar: AppBar(
      //   backgroundColor: AppColor.primaryColor,
      //   elevation: 0,
      //   titleSpacing: 0,
      //   // leadingWidth: 48.w,
      //   leading: isLeading
      //       ? IconButton(
      //     padding: EdgeInsets.zero,
      //           onPressed: onLeading,
      //           icon: Icon(
      //             Icons.arrow_back_ios,
      //             color: AppColor.white,
      //           ),
      //         )
      //       : SizedBox(),
      //   title: Text(
      //     '$title',
      //     style: ThemeText.subtitle1.copyWith(color: AppColor.white),
      //   ),
      //   centerTitle: false,
      //   actions: actions,
      // ),
      body: Column(
        children: [
          AppbarWidget(
            onLeading: onLeading,
            title: '$title',
            actions: actions,
          ),
          Expanded(child: child),
        ],
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
