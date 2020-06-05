import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutterwarehouseapp/common/utils/utils.dart';
import 'package:flutterwarehouseapp/src/invoice/domain/domain.dart';

class ProductFormWidget extends StatelessWidget {
  final ProductOfInvoiceEntity productOfInvoiceEntity;

  String _name = '';
  String _amount = '0';
  String _price = '0';

  ProductFormWidget({Key key, this.productOfInvoiceEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (productOfInvoiceEntity != null) {
      _name = productOfInvoiceEntity.productName;
      _amount = productOfInvoiceEntity.amount;
      _price =
          formatMoney(double.parse(productOfInvoiceEntity.enteredPrice));
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('$_name',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.w500)),
                Text(
                  'x$_amount',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: ScreenUtil().setSp(14),
                      fontWeight: FontWeight.w400),
                )
              ],
            )),
        Expanded(
          flex: 1,
          child: Text(
            '$_price đ',
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
