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

  CategoryEntity(
      {this.document, this.name, this.color, this.createTime, this.lastUpdate});
}
