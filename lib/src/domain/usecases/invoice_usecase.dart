import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/domain/entities/bill_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/item_bill_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/product_entity.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/invoice_repository.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/product_repository.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/snackbar_type.dart';

class InvoiceUseCase {
  final InvoiceRepository invoiceRepo;
  final ProductRepository productRepo;

  InvoiceUseCase({
    @required this.invoiceRepo,
    @required this.productRepo,
  });

  Future<bool> createInvoice(BillEntity bill) async {
    return invoiceRepo.setBill(bill);
  }

  List getItemBillJsonArray(List<ItemBillEntity> itemList) {
    List dataList = [];
    if (!ValidatorUtils.isNullEmptyList(itemList)) {
      for (final ItemBillEntity item in itemList) {
        dataList.add(json.encode(item.toModel().toJson()));
      }
    }
    return dataList;
  }

  Future<bool> isLimitedProductQty(ItemBillEntity itemBill) async {
    ProductEntity product = await productRepo.getProduct(itemBill.index);
    if (itemBill.qty > product.qty) {
      locator<SnackbarBloc>().add(ShowSnackbar(
        title: 'Chỉ còn ${product.qty} ${product.name} của ${product.distributor} trong kho',
        type: SnackBarType.error,
      ));
      return true;
    }
    return false;
  }
}
