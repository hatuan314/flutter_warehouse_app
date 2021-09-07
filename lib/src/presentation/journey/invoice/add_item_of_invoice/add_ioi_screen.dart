import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/add_item_of_invoice/add_item_constants.dart';
import 'package:flutterwarehouseapp/src/widgets/scaffold/scaffold_widget.dart';

import 'ioi_body_widget.dart';

class AddIoiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      isLeading: true,
      onLeading: () {
        Navigator.of(context).pop();
      },
      title: AddItemOfInvoiceConstants.addItemTitle,
      child: SingleChildScrollView(child: AddItemOfInvoiceBodyWidget()),
    );
  }

}