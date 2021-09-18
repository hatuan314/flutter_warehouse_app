import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/configs/default_env.dart';
import 'package:flutterwarehouseapp/common/configs/firebase_setup.dart';
import 'package:flutterwarehouseapp/src/data/models/product_model.dart';

import 'base_service.dart';

class ProductDataSource {
  final SetupFirebaseDatabase setup;
  final BaseService service;

  ProductDataSource({@required this.setup, @required this.service});

  Future<DocumentReference> setProduct(ProductModel product) async {
    return service.setDocumentRef(
      ref: setup.mainDoc.collection(DefaultConfig.productCollection),
      request: product.toJson(),
    );
  }

  Future<QuerySnapshot> getProductList() async {
    return service.getQuerySnapshotList(
        setup.mainDoc.collection(DefaultConfig.productCollection));
  }
}
