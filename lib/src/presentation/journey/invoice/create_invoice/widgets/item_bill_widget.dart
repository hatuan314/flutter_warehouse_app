import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/common/utils/currency_utils.dart';
import 'package:flutterwarehouseapp/common/utils/number_utils.dart';
import 'package:flutterwarehouseapp/src/domain/entities/item_bill_entity.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';

class ItemBillWidget extends StatelessWidget {
  final ItemBillEntity itemBill;

  const ItemBillWidget({Key key, this.itemBill}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColor.paleGrey))),
      padding: EdgeInsets.only(bottom: LayoutConstants.paddingHorizontal10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            itemBill.name,
            style: ThemeText.body1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${StringConstants.quantityTxt}: ${NumberUtils.convertNumber(itemBill.qty, 'vi')}',
                style: ThemeText.body2.copyWith(color: AppColor.hintColor),
              ),
              Text(
                '${CurrencyUtils.convertFormatMoney(itemBill.totalPrice, 'vi')}',
                style: ThemeText.body2.copyWith(color: AppColor.hintColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}
