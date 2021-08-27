import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/common/utils/currency_utils.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';

class TotalAmountWidget extends StatelessWidget {
  final int totalAmount;

  const TotalAmountWidget({Key key, this.totalAmount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColor.paleGrey))),
      padding: EdgeInsets.only(bottom: LayoutConstants.paddingHorizontal10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            StringConstants.totalAmountTxt,
            style: ThemeText.body1.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            '${CurrencyUtils.convertFormatMoney(totalAmount, 'vi')}',
            style: ThemeText.headline6.copyWith(color: AppColor.primaryColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
