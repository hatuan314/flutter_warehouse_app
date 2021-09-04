import 'package:flutter/material.dart';

import 'package:flutterwarehouseapp/src/domain/entities/category_entity.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/category_repository.dart';

class CategoryUseCase {
  final CategoryRepository categoryRepo;

  CategoryUseCase({@required this.categoryRepo});

  Future<bool> setCategory(CategoryEntity category) => categoryRepo.setCategory(category);

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