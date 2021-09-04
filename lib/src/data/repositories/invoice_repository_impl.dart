import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/utils/connectivity_utils.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/local/invoice_hive.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/remote/invoice_datasource.dart';
import 'package:flutterwarehouseapp/src/data/models/bill_model.dart';
import 'package:flutterwarehouseapp/src/data/repositories/mixin_repository.dart';
import 'package:flutterwarehouseapp/src/domain/entities/bill_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/hive_entity.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/invoice_repository.dart';

class InvoiceRepositoryImpl extends InvoiceRepository with MixinRepository {
  final InvoiceHive invoiceHive;
  final InvoiceDataSource invoiceDs;

  InvoiceRepositoryImpl({@required this.invoiceHive, @required this.invoiceDs});

  @override
  Future<List<BillEntity>> getBillListCloud() async {
    QuerySnapshot snapshot = await invoiceDs.getBillList();
    List<BillEntity> bills = getCloudDataList<BillModel>(snapshot);
    return bills;
  }

  @override
  Future<List<BillEntity>> getBillListLocal() {
    // TODO: implement getBillListLocal
    throw UnimplementedError();
  }

  @override
  Future<void> remove({int index, String document}) async {}

  @override
  Future<bool> setBill(BillEntity bill) async {
    bool isConnect = await ConnectivityUtils.checkConnectInternet();
    if (isConnect) {
      String document = await setBillCloud(bill);
      if (!ValidatorUtils.isNullEmpty(document)) {
        bill.hive = HiveEntity(document: document, isSync: true);
      } else {
        bill.hive = HiveEntity.normal();
      }
    } else {
      bill.hive = HiveEntity.normal();
    }
    int key = await invoiceHive.setInvoice(bill);
    if (key != null) {
      return true;
    }
    return false;
  }

  @override
  Future<String> setBillCloud(BillEntity bill) async {
    DocumentReference ref = await invoiceDs.setBill(bill.toModel());
    if (!ValidatorUtils.isNullEmpty(ref)) {
      return ref.id;
    }
    return '';
  }

  @override
  Future<bool> setBillLocalList(List<BillEntity> distributorList) {
    // TODO: implement setBillLocalList
    throw UnimplementedError();
  }

  @override
  Future<void> update({int index, BillEntity distributor}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
