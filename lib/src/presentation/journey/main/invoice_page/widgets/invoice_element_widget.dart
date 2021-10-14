import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/enum_constants.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/common/utils/currency_utils.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/domain/entities/bill_entity.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';
import 'package:flutterwarehouseapp/src/themes/theme_text.dart';
import 'package:intl/intl.dart';

class InvoiceElementWidget extends StatelessWidget {
  final BillEntity bill;
  final Function onPressed;
  final BillEnum billType;

  const InvoiceElementWidget({Key key, this.bill, this.onPressed, this.billType}) : super(key: key);

  String get _customerName {
    if (billType == BillEnum.Export) {
      if (ValidatorUtils.isNullEmpty(bill.customer)) {
        return 'Hóa đơn ${DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(bill?.billDate ?? bill?.createAt))}';
      }
      return bill.customer;
    }
    if (billType == BillEnum.Import) {
      return bill.distributor;
    }
    return '';
  }

  Widget _descriptionWidget() {
    if (ValidatorUtils.isNullEmpty(bill.description)) {
      return SizedBox.shrink();
    }
    return Text(
      '${StringConstants.noteTxt}: ${bill.description}',
      style: ThemeText.caption.copyWith(fontStyle: FontStyle.italic),
    );
  }

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
        ).copyWith(bottom: LayoutConstants.paddingVerticalApp),
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: LayoutConstants.paddingVerticalApp,
            horizontal: LayoutConstants.paddingHorizontalApp,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(billType == BillEnum.Export ? Icons.account_circle_rounded : Icons.store),
                  SizedBox(width: LayoutConstants.paddingHorizontal5,),
                  Text(
                    _customerName,
                    style: ThemeText.body2.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: LayoutConstants.paddingVertical5,
              ),
              Text(
                DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(bill?.billDate ?? bill?.createAt)),
                style: ThemeText.caption.copyWith(fontWeight: FontWeight.w500, color: AppColor.blue),
              ),
              SizedBox(
                height: LayoutConstants.paddingVertical10,
              ),
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
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ],
              ),
              _descriptionWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
