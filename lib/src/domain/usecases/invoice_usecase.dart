import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/configs/default_env.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/data/models/item_bill_model.dart';
import 'package:flutterwarehouseapp/src/domain/entities/bill_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/item_bill_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/product_entity.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/image_repository.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/invoice_repository.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/product_repository.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/snackbar_type.dart';
import 'package:image_picker/image_picker.dart';

class InvoiceUseCase {
  final InvoiceRepository invoiceRepo;
  final ProductRepository productRepo;
  final ImageRepository imageRepo;

  InvoiceUseCase({
    @required this.invoiceRepo,
    @required this.productRepo,
    @required this.imageRepo,
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
    log('>>>>>>>>>InvoiceUseCase.isLimitedProductQty.itemBill.index: ${itemBill.index}');
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

  Future<List<BillEntity>> getAllBills() async {
    List<BillEntity> billList = await invoiceRepo.getBillListLocal();
    if (ValidatorUtils.isNullEmptyList(billList)) {
      billList = await invoiceRepo.getBillListCloud();
      invoiceRepo.setBillLocalList(billList);
    }
    return billList;
  }

  Future<List<BillEntity>> getExportBillList() async {
    List<BillEntity> billList = await invoiceRepo.getExportBillList();
    if (ValidatorUtils.isNullEmptyList(billList)) {
      List<BillEntity> allBills = await invoiceRepo.getBillListCloud();
      billList = fixBugBillDateNull(billList);
      bool flag = await invoiceRepo.setBillLocalList(allBills);
      if (flag) {
        billList = await invoiceRepo.getExportBillList();
      } else {
        billList = fillBillList(allBills, 'EXPORT');
      }
    } else {
      billList = fixBugBillDateNull(billList);
    }
    billList = sortByBillDate(billList);
    return billList;
  }

  List<BillEntity> fixBugBillDateNull(List<BillEntity> billList) {
    for (final BillEntity bill in billList) {
      if (ValidatorUtils.isNullEmpty(bill.billDate)) {
        bill.billDate = bill.createAt;
      }
    }
    return billList;
  }

  Future<List<BillEntity>> getImportBillList() async {
    List<BillEntity> billList = await invoiceRepo.getImportBillList();
    if (ValidatorUtils.isNullEmptyList(billList)) {
      List<BillEntity> allBills = await invoiceRepo.getBillListCloud();
      billList = fixBugBillDateNull(billList);
      bool flag = await invoiceRepo.setBillLocalList(allBills);
      if (flag) {
        billList = await invoiceRepo.getImportBillList();
      } else {
        billList = fillBillList(allBills, 'IMPORT');
      }
    } else {
      billList = fixBugBillDateNull(billList);
    }
    billList = sortByBillDate(billList);
    return billList;
  }

  List<BillEntity> fillBillList(List<BillEntity> allBills, String fillKey) {
    List<BillEntity> fillBills = [];
    for (final BillEntity bill in allBills) {
      if (bill.type == fillKey) {
        fillBills.add(bill);
      }
    }
    return fillBills;
  }

  Future<List<String>> uploadImages({List<PickedFile> imageFiles, String uid}) async {
    List<String> pathList = [];
    List<Uint8List> imageUint8ListArray = [];
    pathList = await imageRepo.uploadImages(
      imageUint8ListArray: imageUint8ListArray,
      uid: uid,
      collection: DefaultConfig.billCollection,
    );
    if (ValidatorUtils.isNullEmptyList(pathList)) {
      pathList = getImageLocalPaths(imageFiles);
    }
    return pathList;
  }

  List<String> getImageLocalPaths(List<PickedFile> imageFiles) {
    List<String> pathList = [];
    for (final PickedFile file in imageFiles) {
      pathList.add(file.path);
    }
    return pathList;
  }

  List<BillEntity> sortByBillDate(List<BillEntity> billList) {
    billList.sort((a, b) => b.billDate.compareTo(a.billDate));
    return billList;
  }

  List<ItemBillEntity> getItemBillListFromJson(List itemsJson) {
    List<ItemBillEntity> itemBills = [];
    if (!ValidatorUtils.isNullEmptyList(itemsJson)) {
      for (final String json in itemsJson) {
        ItemBillEntity itemBill = ItemBillModel.fromJson(jsonDecode(json));
        itemBills.add(itemBill);
      }
    }
    return itemBills;
  }

  Future<void> updateInvoice({int index, BillEntity bill}) async {
    await invoiceRepo.updateBill(index: index, bill: bill);
  }
}
