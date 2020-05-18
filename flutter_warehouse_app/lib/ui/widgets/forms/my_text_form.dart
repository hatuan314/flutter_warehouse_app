import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextForm extends StatelessWidget {
  TextEditingController controller;
  FocusNode currentNode;
  FocusNode nextNode;
  String hintText;
  FormFieldValidator<String> validator;
  TextInputType keyboardType;

  MyTextForm(
      {this.controller,
      this.keyboardType,
      this.currentNode,
      this.nextNode,
      this.hintText,
      this.validator});

  static InputBorder formBoder({Color color = Colors.black87}) {
    return OutlineInputBorder(
        borderSide: BorderSide(color: color, width: ScreenUtil().setWidth(1.2)),
        borderRadius: BorderRadius.all(Radius.circular(8)));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      controller: controller,
      style: TextStyle(fontSize: ScreenUtil().setSp(18), color: Colors.black87),
      focusNode: currentNode,
      onFieldSubmitted: (term) {
        currentNode.unfocus();
        if (nextNode != null) FocusScope.of(context).requestFocus(nextNode);
      },
      keyboardType: keyboardType ?? TextInputType.text,
      textInputAction: TextInputAction.next,
      cursorColor: Colors.black87,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
            color: Colors.black38,
            fontSize: ScreenUtil().setSp(18),
            fontWeight: FontWeight.w500),
        contentPadding:
            new EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(12)),
        errorStyle: TextStyle(
          color: Colors.red,
          fontSize: ScreenUtil().setSp(16),
        ),
        errorBorder: formBoder(color: Colors.red),
        focusedErrorBorder: formBoder(color: Colors.red),
        enabledBorder: formBoder(color: Colors.black87),
        focusedBorder: formBoder(color: Colors.black87),
      ),
      validator: (value) => validator(value),
    );
  }
}
