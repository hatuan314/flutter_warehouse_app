import 'dart:convert';

import 'package:flutterwarehouseapp/src/data/models/category_model.dart';
import 'package:flutterwarehouseapp/src/domain/entities/hive_entity.dart';
import 'package:hive/hive.dart';

part 'category_entity.g.dart';

@HiveType(typeId: 2)
class CategoryEntity {
  @HiveField(0)
  String hiveJson;
  @HiveField(1)
  String name;
  @HiveField(2)
  int color;
  @HiveField(3)
  DateTime createTime;
  @HiveField(4)
  DateTime lastUpdate;
  HiveEntity hive;

  CategoryEntity(
      {this.name, this.color, this.createTime, this.lastUpdate});

  void setHiveJson() {
    this.hiveJson = jsonEncode(hive.toJson());
  }

  CategoryModel toModel() {

   return CategoryModel(
      name: name,
      color: color,
      createAt: createTime,
      lastUpdate: lastUpdate,
    );
  }
}
