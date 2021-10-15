import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/data/models/bill_model.dart';
import 'package:flutterwarehouseapp/src/domain/entities/bill_entity.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/create_invoice/create_invoice_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/create_invoice/widgets/create_invoice_body_widget.dart';
import 'package:flutterwarehouseapp/src/widgets/scaffold/scaffold_widget.dart';

class CreateInvoiceScreen extends StatelessWidget {
  final String billJson;

  const CreateInvoiceScreen({Key key, this.billJson}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BillEntity bill = BillModel.fromJson(jsonDecode(billJson));
    return ScaffoldWidget(
      isLeading: true,
      onLeading: () {
        Navigator.pop(context);
      },
      title: ValidatorUtils.isNullEmpty(billJson)
          ? CreateInvoiceConstants.createInvoiceTitle
          : CreateInvoiceConstants.editInvoiceTitle,
      child: CreateInvoiceBodyWidget(
        customer: bill.customer,
        description: bill.description,
      ),
    );
  }
}
