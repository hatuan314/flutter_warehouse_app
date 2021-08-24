import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/enums/bill_enum.dart';
import 'package:flutterwarehouseapp/common/utils/bill_utils.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/create_invoice/create_invoice_constants.dart';
import 'package:flutterwarehouseapp/src/widgets/bottom_sheet/bottom_sheet_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/touchable_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/unit_item_widget.dart';

class SelectBillTypeBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomSheetWidget(
      title: CreateInvoiceConstants.selectBillTypeTxt,
      bodyPadding: EdgeInsets.zero,
      child: ListView.builder(
        padding: EdgeInsets.zero,
          itemCount: BillEnum.values.length,
          itemBuilder: (context, index) {
            return TouchableWidget(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: UnitItemWidget(
                name: BillUtils.convertToString(BillEnum.values[index]),
              ),
            );
      }),
    );
  }

}