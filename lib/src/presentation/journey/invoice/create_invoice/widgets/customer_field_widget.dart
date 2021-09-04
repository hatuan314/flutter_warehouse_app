import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/create_invoice/create_invoice_constants.dart';
import 'package:flutterwarehouseapp/src/widgets/text_form/text_form_widget.dart';

class CustomerFieldWidget extends StatelessWidget {
  final TextEditingController controller;

  const CustomerFieldWidget({Key key,@required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormWidget.withPrefixIcon(
      controller: controller,
      hintText: CreateInvoiceConstants.customerNameTxt,
      validator: (value) {
        return null;
      },
      icon: Icons.account_circle_rounded,
    );
  }

}