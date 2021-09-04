import 'dart:convert';

import 'package:flutterwarehouseapp/src/data/models/product_model.dart';
import 'package:flutterwarehouseapp/src/domain/entities/hive_entity.dart';
import 'package:hive/hive.dart';

part 'product_entity.g.dart';

@HiveType(typeId: 5)
class ProductEntity {
  @HiveField(0)
  String hiveJson;
  @HiveField(1)
  String name;
  @HiveField(2)
  String category;
  @HiveField(3)
  String distributor;
  @HiveField(4)
  int qty;
  @HiveField(5)
  int importPrice;
  @HiveField(6)
  int exportPrice;
  @HiveField(7)
  String locale;
  @HiveField(8)
  int createAt;
  @HiveField(9)
  int lastUpdate;
  @HiveField(10)
  String unit;
  HiveEntity hive;

  ProductEntity({
    this.hive,
    this.name,
    this.category,
    this.distributor,
    this.qty,
    this.importPrice,
    this.exportPrice,
    this.locale,
    this.createAt,
    this.lastUpdate,
    this.unit,
  });

  ProductModel toModel() => ProductModel(
        name: name,
        category: category,
        distributor: distributor,
        qty: qty,
        importPrice: importPrice,
        exportPrice: exportPrice,
        locale: locale,
        createAt: createAt,
        lastUpdate: lastUpdate,
        unit: unit,
      );

  void setHiveJson() {
    this.hiveJson = jsonEncode(hive.toJson());
  }
}
