import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class SearchForm extends StatelessWidget {
  TextEditingController controller;
  ValueChanged<String> onchange;

  SearchForm({this.controller, this.onchange});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white
      ),
      child: TextFormField(
        controller: controller,
        style: TextStyle(fontSize: ScreenUtil().setSp(18), color: Colors.black87),
        cursorColor: Colors.black87,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          fillColor: Colors.white,
          hintText: 'Tìm kiếm ...',
          hintStyle: TextStyle(
              color: Colors.black38,
              fontSize: ScreenUtil().setSp(18),
              fontWeight: FontWeight.w500),
          contentPadding:
          new EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(12)),
          enabledBorder: formBoder(color: Colors.black87),
          focusedBorder: formBoder(color: Colors.black87),
        ),
        onChanged: onchange,
      ),
    );
  }

  static InputBorder formBoder({Color color = Colors.black87}) {
    return OutlineInputBorder(
        borderSide: BorderSide(color: color, width: ScreenUtil().setWidth(1.2)),
        borderRadius: BorderRadius.all(Radius.circular(20)));
  }
}