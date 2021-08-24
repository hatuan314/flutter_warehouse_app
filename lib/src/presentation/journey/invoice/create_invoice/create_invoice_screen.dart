import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/create_invoice/create_invoice_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/create_invoice/widgets/create_invoice_body_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/scaffold/scaffold_widget.dart';

class CreateInvoiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      isLeading: true,
      onLeading: () {
        Navigator.pop(context);
      },
      title: CreateInvoiceConstants.createInvoiceTitle,
      child: CreateInvoiceBodyWidget(),
    );
  }

}