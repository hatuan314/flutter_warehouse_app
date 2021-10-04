import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/enum_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/add_item_of_invoice/add_item_constants.dart';
import 'package:flutterwarehouseapp/src/widgets/scaffold/scaffold_widget.dart';

import 'widgets/ioi_body_widget.dart';

class AddIoiScreen extends StatelessWidget {
  final BillEnum billType;

  const AddIoiScreen({Key key, this.billType = BillEnum.Export}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      isLeading: true,
      onLeading: () {
        Navigator.of(context).pop();
      },
      title: AddItemOfInvoiceConstants.addItemTitle,
      child: SingleChildScrollView(
          child: AddItemOfInvoiceBodyWidget(
        billType: billType,
      )),
    );
  }
}
