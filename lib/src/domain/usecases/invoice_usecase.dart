import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/domain/entities/bill_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/item_bill_entity.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/invoice_repository.dart';

class InvoiceUseCase {
  final InvoiceRepository invoiceRepo;

  InvoiceUseCase({@required this.invoiceRepo});

  Future<bool> createInvoice(BillEntity bill) async {
    return invoiceRepo.setBill(bill);
  }

  List getItemBillJsonArray(List<ItemBillEntity> itemList) {
    List dataList = [];
    if (!ValidatorUtils.isNullEmptyList(itemList)) {
      for (final ItemBillEntity item in itemList) {
        dataList.add(json.encode(item.toJson()));
      }
    }
    return dataList;
  }
}