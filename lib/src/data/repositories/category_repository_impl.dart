import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutterwarehouseapp/src/data/data_sources/local/category_hive.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/remote/category_datasource.dart';
import 'package:flutterwarehouseapp/src/domain/entities/category_entity.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryDataSource categoryDS;
  final CategoryHive categoryHive;

  CategoryRepositoryImpl({@required this.categoryDS, @required this.categoryHive});

  @override
  Future<String> setCategoryCloud(CategoryEntity category) async {
    DocumentReference doc = await categoryDS.setCategory(category.toModel());
    return doc.id;
  }

  @override
  Future<bool> setCategoryLocal(CategoryEntity category) async {
    int key = await categoryHive.setCategory(category);
    return key != null;
  }
}
