import 'package:flutter/material.dart';

import 'package:flutterwarehouseapp/common/extensions/string_extensions.dart';
import 'package:flutterwarehouseapp/common/utils/connectivity_utils.dart';
import 'package:flutterwarehouseapp/src/domain/entities/category_entity.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/category_repository.dart';

class CategoryUseCase {
  final CategoryRepository categoryRepo;

  CategoryUseCase({@required this.categoryRepo});

  Future<bool> setCategory(CategoryEntity category) async {
    bool isConnect = await ConnectivityUtils.checkConnectInternet();
    if (isConnect) {
      String document = await categoryRepo.setCategoryCloud(category);
      if (document.isSafe) {
        category.document = document;
        category.isSync = true;
      }
    }
    bool flag = await categoryRepo.setCategoryLocal(category);
    return flag;
  }

  Future<List<CategoryEntity>> getCategoryList() async {
    List<CategoryEntity> categoryList = await categoryRepo.getCategoryListLocal();
    if (categoryList.isEmpty) {
      categoryList = await categoryRepo.getCategoryListCloud();
      if (categoryList.isNotEmpty) {
        await categoryRepo.setCategoriesLocal(categoryList);
      }
    }
    return categoryList;
  }
}