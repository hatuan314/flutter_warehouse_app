import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductOfInvoiceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: RichText(
              text: TextSpan(
                  text: 'product 1111111111111111111',
                  style: TextStyle(
                      color: Colors.indigo,
                      fontSize: ScreenUtil().setSp(18),
                      fontWeight: FontWeight.w500),
                  children: [
                    TextSpan(
                      text: '\tx2',
                      style: TextStyle(
                        color: Colors.indigo,
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.w400
                      ),
                    )
                  ]),
              maxLines: 3,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '12.000.000 đ',
              style: TextStyle(
                  color: Colors.indigo,
                  fontSize: ScreenUtil().setSp(18),
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
    );
  }
}
