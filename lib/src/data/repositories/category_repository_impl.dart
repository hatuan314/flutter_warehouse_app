import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutterwarehouseapp/src/data/data_sources/local/category_hive.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/remote/category_datasource.dart';
import 'package:flutterwarehouseapp/src/data/models/category_model.dart';
import 'package:flutterwarehouseapp/src/domain/entities/category_entity.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/category_repository.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/common_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryDataSource categoryDS;
  final CategoryHive categoryHive;
  final CommonRepository commonRepo;

  CategoryRepositoryImpl({
    @required this.categoryDS,
    @required this.categoryHive,
    @required this.commonRepo,
  });

  @override
  Future<String> setCategoryCloud(CategoryEntity category) async {
    DocumentReference doc = await categoryDS.setCategory(category.toModel());
    return doc.id;
  }

  @override
  Future<bool> setCategoryLocal(CategoryEntity category) async {
    int key = await categoryHive.setCategory(category);
    log('>>>>>>>>>>>>>CategoryRepositoryImpl.setCategoryLocal.key: $key');
    return key != null;
  }

  @override
  Future<List<CategoryEntity>> getCategoryListCloud() async {
    QuerySnapshot snapshot = await categoryDS.getCategoryList();
    List<CategoryEntity> categories = commonRepo.getCloudDataList<CategoryModel>(snapshot);
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
}
