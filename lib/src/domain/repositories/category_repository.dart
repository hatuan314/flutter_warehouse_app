import 'package:flutterwarehouseapp/src/domain/entities/category_entity.dart';

abstract class CategoryRepository {
  Future<bool> setCategory(CategoryEntity category);

  Future<String> setCategoryCloud(CategoryEntity category);

  Future<int> setCategoryLocal(CategoryEntity category);

  Future<void> setCategoriesLocal(List<CategoryEntity> categories);

  Future<List<CategoryEntity>> getCategoryListCloud();

  Future<List<CategoryEntity>> getCategoryListLocal();

  Future updateByKey(CategoryEntity category, int key);

  Future updateByIndex(CategoryEntity category, index);

}
