import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseWidget {
  static Text text(String title,
      {double textSize, Color textColor, FontWeight fontWeight, int maxLines}) {
    return Text(
      '$title',
      style: TextStyle(
        fontSize: textSize ?? ScreenUtil().setSp(16),
        color: textColor ?? Colors.black87,
        fontFamily: 'QS',
        fontWeight: fontWeight ?? FontWeight.w500,
      ),
      maxLines: maxLines ?? 1,
    );
  }

  static AppBar appBar(String title) {
    return AppBar(
      title: text('$title',
          textSize: ScreenUtil().setSp(20),
          textColor: Colors.white,
          fontWeight: FontWeight.w600),
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: Colors.transparent,
    );
  }

  static TextFormField baseTextFrom(
      {BuildContext context,
        TextEditingController controller,
        FocusNode currentNode,
        FocusNode nextNode,
        String hintText,
        FormFieldValidator<String> validator}) {
    return TextFormField(
      controller: controller,
      style: TextStyle(fontSize: ScreenUtil().setSp(18), color: Colors.black87),
      focusNode: currentNode,
      onFieldSubmitted: (term) {
        currentNode.unfocus();
        if (nextNode != null) FocusScope.of(context).requestFocus(nextNode);
      },
      textInputAction: TextInputAction.next,
      cursorColor: Colors.black87,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.black38,
          fontSize: ScreenUtil().setSp(23),
        ),
        contentPadding: new EdgeInsets.symmetric(
            vertical: ScreenUtil().setHeight(15),
            horizontal: ScreenUtil().setWidth(30)),
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

  static InputBorder formBoder({Color color = Colors.black87}) {
    return OutlineInputBorder(
        borderSide: BorderSide(color: color, width: ScreenUtil().setWidth(1.2)),
        borderRadius: BorderRadius.all(Radius.circular(8)));
  }
}
