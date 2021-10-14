import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/enum_constants.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/domain/entities/bill_entity.dart';
import 'package:flutterwarehouseapp/src/widgets/view_state_widget/empty_widget.dart';

import 'invoice_element_widget.dart';

class InvoiceWidget extends StatelessWidget {
  final List<BillEntity> billList;
  final Function(BillEntity) onPressedBill;
  final BillEnum billType;

  const InvoiceWidget({Key key, this.billList, this.onPressedBill, this.billType}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (ValidatorUtils.isNullEmptyList(billList)) {
      return EmptyWidget();
    }
    return CustomScrollView(
      slivers: [
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return InvoiceElementWidget(
            bill: billList[index],
            onPressed: () => onPressedBill(billList[index]),
            billType: billType,
          );
        }, childCount: billList.length) ),
      ],
    );
  }

}