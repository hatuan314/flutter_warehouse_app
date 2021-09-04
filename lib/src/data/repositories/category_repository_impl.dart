import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/utils/connectivity_utils.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';

import 'package:flutterwarehouseapp/src/data/data_sources/local/category_hive.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/remote/category_datasource.dart';
import 'package:flutterwarehouseapp/src/data/models/category_model.dart';
import 'package:flutterwarehouseapp/src/domain/entities/category_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/hive_entity.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/category_repository.dart';

import 'mixin_repository.dart';

class CategoryRepositoryImpl extends CategoryRepository with MixinRepository {
  final CategoryDataSource categoryDS;
  final CategoryHive categoryHive;

  CategoryRepositoryImpl({
    @required this.categoryDS,
    @required this.categoryHive,
  });

  @override
  Future<bool> setCategory(CategoryEntity category) async {
    bool isConnect = await ConnectivityUtils.checkConnectInternet();
    if (isConnect) {
      String document = await setCategoryCloud(category);
      if (ValidatorUtils.isNullEmpty(document)) {
        category.hive = HiveEntity(document: document, isSync: true);
      } else {
        category.hive = HiveEntity.normal();
      }
    } else {
      category.hive = HiveEntity.normal();
    }
    int key = await setCategoryLocal(category);
    if (key != null) {
      return true;
    }
    return false;
  }

  @override
  Future<String> setCategoryCloud(CategoryEntity category) async {
    DocumentReference doc = await categoryDS.setCategory(category.toModel());
    return doc.id;
  }

  @override
  Future<int> setCategoryLocal(CategoryEntity category) async {
    int key = await categoryHive.setCategory(category);
    return key;
  }

  @override
  Future<List<CategoryEntity>> getCategoryListCloud() async {
    QuerySnapshot snapshot = await categoryDS.getCategoryList();
    List<CategoryEntity> categories = getCloudDataList<CategoryModel>(snapshot);
    return categories;
  }

  @override
  Future<List<CategoryEntity>> getCategoryListLocal() {
    return categoryHive.getAllCategories();
  }

  @override
  Future<void> setCategoriesLocal(List<CategoryEntity> categories) async {
    await categoryHive.setCategories(categories);
  }

  @override
  Future updateByIndex(CategoryEntity category, index) async {
    await categoryHive.updateByIndex(category, index);
  }

  @override
  Future updateByKey(CategoryEntity category, int key) async {
    await categoryHive.updateByKey(category, key);
  }
}
