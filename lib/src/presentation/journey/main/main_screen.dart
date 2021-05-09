import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.white,
      child: Center(child: Text('Main Screen'),),
    );
  }

}