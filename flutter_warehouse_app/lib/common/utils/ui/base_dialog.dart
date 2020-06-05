import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class BaseDialog extends StatelessWidget {
  IconData iconHeader;
  Widget body;
  String title;
  BaseDialog({this.iconHeader, this.body, this.title = ''});


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
            _buildBody(),
            _buildHeaderAppBar()
          ],
        ),
      ),
    );
  }

  _buildBody() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(35)),
      padding: EdgeInsets.only(
          left: ScreenUtil().setHeight(20),
          top: ScreenUtil().setWidth(20),
          right: ScreenUtil().setHeight(20),
          bottom: ScreenUtil().setWidth(8)),
      child: Column(
        children: <Widget>[
          _headerForm(),
          SizedBox(height: ScreenUtil().setHeight(25)),
          body,
        ],
      ),
    );
  }

  Widget _headerForm() {
    return Visibility(
      visible: title.isNotEmpty,
      child: Column(
        children: <Widget>[
          SizedBox(height: ScreenUtil().setHeight(20)),
          Text(
            title.isEmpty ? '' : '$title',
            style: TextStyle(
                color: Colors.black87,
                fontSize: ScreenUtil().setSp(28),
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),

        ],
      ),
    );
  }

}