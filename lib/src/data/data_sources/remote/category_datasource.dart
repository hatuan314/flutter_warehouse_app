import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/configs/default_env.dart';
import 'package:flutterwarehouseapp/common/configs/firebase_setup.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/remote/base_service.dart';
import 'package:flutterwarehouseapp/src/data/models/category_model.dart';

class CategoryDataSource {
  final SetupFirebaseDatabase setup;
  final BaseService service;

  CategoryDataSource({@required this.setup, @required this.service});

  Future<DocumentReference> setCategory(CategoryModel category) async {
    return service.setDocumentRef(
      ref: setup.mainDoc.collection(DefaultConfig.categoriesCollection),
      request: category.toJson(),
    );
  }

  Future<QuerySnapshot> getCategoryList() async {
    return service.getQuerySnapshotList(
        setup.mainDoc.collection(DefaultConfig.categoriesCollection));
  }
}