import 'package:flutter/material.dart';

import 'package:flutterwarehouseapp/src/themes/theme_color.dart';

import 'appbar_widget.dart';

class ScaffoldWidget extends StatelessWidget {
  final bool isLeading;
  final String title;
  final Function onLeading;
  final Color backgroundColor;
  final Widget child;
  final Widget floatingActionButton;
  final Widget tabBar;
  final List<Widget> actions;

  const ScaffoldWidget({
    Key key,
    this.isLeading = false,
    this.title,
    this.onLeading,
    this.backgroundColor,
    this.child,
    this.actions,
    this.floatingActionButton,
    this.tabBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColor.white,
      body: Column(
        children: [
          AppbarWidget(
            isLeading: isLeading ?? true,
            onLeading: onLeading,
            title: '$title',
            actions: actions,
            tabBar: tabBar ?? SizedBox.shrink(),
          ),
          Expanded(child: child),
        ],
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
