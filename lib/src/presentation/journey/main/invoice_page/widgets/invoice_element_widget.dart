import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/enum_constants.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/utils/currency_utils.dart';
import 'package:flutterwarehouseapp/src/domain/entities/bill_entity.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';
import 'package:intl/intl.dart';

class InvoiceElementWidget extends StatelessWidget {
  final BillEntity bill;
  final Function onPressed;
  final BillEnum billType;

  const InvoiceElementWidget({Key key, this.bill, this.onPressed, this.billType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.translucent,
      child: Card(
        color: AppColor.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LayoutConstants.roundedRadius),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: LayoutConstants.paddingHorizontalApp,
          vertical: LayoutConstants.paddingVerticalApp / 2,
        ),
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                billType == BillEnum.Export ? bill?.customer ?? '' : bill.distributor,
                style: ThemeText.body2.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(bill?.createAt)),
                style: ThemeText.caption.copyWith(fontWeight: FontWeight.w500, color: AppColor.blue),
              ),
              SizedBox(height: LayoutConstants.paddingVertical10,),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Text(
                        'Tổng tiền:',
                        style: ThemeText.caption,
                      )),
                  Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          CurrencyUtils.convertFormatMoney(bill.totalAmount, 'vi'),
                          style: ThemeText.body2.copyWith(
                            color: billType == BillEnum.Export ? AppColor.green : AppColor.red,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
