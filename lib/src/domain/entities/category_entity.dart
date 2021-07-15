import 'package:flutterwarehouseapp/src/data/models/category_model.dart';
import 'package:hive/hive.dart';

part 'category_entity.g.dart';

@HiveType(typeId: 2)
class CategoryEntity {
  @HiveField(0)
  String document;
  @HiveField(1)
  String name;
  @HiveField(2)
  int color;
  @HiveField(3)
  DateTime createTime;
  @HiveField(4)
  DateTime lastUpdate;
  @HiveField(5)
  bool isSync = true;

  CategoryEntity(
      {this.document, this.name, this.color, this.createTime, this.lastUpdate, this.isSync = true});

  CategoryModel toModel() => CategoryModel(
    document: document,
    name: name,
    color: color,
    createAt: createTime,
    lastUpdate: lastUpdate,
    isSync: isSync,
  );
}
