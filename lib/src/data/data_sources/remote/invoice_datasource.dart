import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/configs/default_env.dart';
import 'package:flutterwarehouseapp/common/configs/firebase_setup.dart';
import 'package:flutterwarehouseapp/src/data/models/bill_model.dart';

import 'base_service.dart';

class InvoiceDataSource {
  final SetupFirebaseDatabase setup;
  final BaseService service;

  InvoiceDataSource({@required this.setup, @required this.service});

  Future<QuerySnapshot> getBillList() async {
    return service.getQuerySnapshotList(setup.mainDoc.collection(DefaultConfig.billCollection));
  }

  Future<DocumentReference> setBill(BillModel bill) async {
    return service.setDocumentRef(
      ref: setup.mainDoc.collection(DefaultConfig.billCollection),
      request: bill.toJson(),
    );
  }

  Future<void> updateBill(BillModel bill) async {
    await service.updateDocument(
      ref: setup.mainDoc.collection(DefaultConfig.billCollection),
      request: bill.toJson(),
      document: bill.document,
    );
  }

  Future<void> removeBill(String document) async {
    await service.deleteDocument(
      ref: setup.mainDoc.collection(DefaultConfig.billCollection),
      document: document,
    );
  }
}
