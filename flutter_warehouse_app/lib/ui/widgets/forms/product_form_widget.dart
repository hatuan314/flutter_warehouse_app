import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductFormWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductFormWidgetState();

}

class _ProductFormWidgetState extends State<ProductFormWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Product 1', style: TextStyle(
                    color: Colors.black87,
                    fontSize: ScreenUtil().setSp(16),
                    fontWeight: FontWeight.w500)),
                Text('x2', style: TextStyle(
                    color: Colors.black54,
                    fontSize: ScreenUtil().setSp(14),
                    fontWeight: FontWeight.w400),)
              ],
            )),
        Expanded(
          flex: 1,
          child: Text(
            '12.000.000 đ',
            style: TextStyle(
                color: Colors.black87,
                fontSize: ScreenUtil().setSp(16),
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.right,
          ),
        )
      ],
    );
  }

}