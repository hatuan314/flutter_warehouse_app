import 'package:flutterwarehouseapp/src/domain/entities/category_entity.dart';

abstract class CategoryRepository {
  Future<String> setCategoryCloud(CategoryEntity category);

  Future<bool> setCategoryLocal(CategoryEntity category);
}
