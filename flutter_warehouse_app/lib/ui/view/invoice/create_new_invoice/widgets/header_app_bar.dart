import 'package:flutter/material.dart';

class HeaderAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  List<Widget> actions = [];

  HeaderAppBar({this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AppBar(
      title: Text('$title'),
      centerTitle: false,
      elevation: 0,
      actions: actions,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(56);

}