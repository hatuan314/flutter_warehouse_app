import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/configs/default_env.dart';
import 'package:flutterwarehouseapp/common/configs/firebase_setup.dart';
import 'package:flutterwarehouseapp/src/data/models/distributor_model.dart';

import 'base_service.dart';

class DistributorDataSource {
  final SetupFirebaseDatabase setup;
  final BaseService service;

  DistributorDataSource({@required this.setup, @required this.service});

  Future<QuerySnapshot> getDistributorList() async {
    return service.getQuerySnapshotList(
        setup.mainDoc.collection(DefaultConfig.distributorsCollection));
  }

  Future<DocumentReference> setDistributor(DistributorModel distributor) async {
    return service.setDocumentRef(
      ref: setup.mainDoc.collection(DefaultConfig.distributorsCollection),
      request: distributor.toJson(),
    );
  }

  Future<void> updateDistributor(DistributorModel distributor) async {
    await service.updateDocument(
      ref: setup.mainDoc.collection(DefaultConfig.distributorsCollection),
      request: distributor.toJson(),
      document: distributor.hive.document,
    );
  }

  Future<void> removeDistributor(String document) async {
    await service.deleteDocument(
      ref: setup.mainDoc.collection(DefaultConfig.distributorsCollection),
      document: document,
    );
  }
}
