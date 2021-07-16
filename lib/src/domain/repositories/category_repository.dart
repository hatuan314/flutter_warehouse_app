import 'package:flutterwarehouseapp/src/domain/entities/category_entity.dart';

abstract class CategoryRepository {
  Future<String> setCategoryCloud(CategoryEntity category);

  Future<bool> setCategoryLocal(CategoryEntity category);

  Future<bool> setCategoriesLocal(List<CategoryEntity> categories);

  Future<List<CategoryEntity>> getCategoryListCloud();

  Future<List<CategoryEntity>> getCategoryListLocal();

}
