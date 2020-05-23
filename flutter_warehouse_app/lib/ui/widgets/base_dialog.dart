import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class BaseDialog extends StatelessWidget {
  IconData iconHeader;
  Widget body;
  BaseDialog({this.iconHeader, this.body});

  Widget _buildHeaderAppBar() {
    return Container(
      height: ScreenUtil().setHeight(70),
      width: ScreenUtil().setWidth(70),
      decoration:
      BoxDecoration(shape: BoxShape.circle, color: Colors.indigo[800]),
      alignment: Alignment.center,
      child: Icon(
        iconHeader,
        color: Colors.white,
        size: ScreenUtil().setHeight(34),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            body,
            _buildHeaderAppBar()
          ],
        ),
      ),
    );
  }

}