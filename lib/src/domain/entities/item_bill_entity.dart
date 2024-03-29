import 'package:hive/hive.dart';

import 'package:flutterwarehouseapp/src/data/models/item_bill_model.dart';

part 'item_bill_entity.g.dart';

@HiveType(typeId: 4)
class ItemBillEntity {
  int index;
  @HiveField(0)
  String name;
  @HiveField(1)
  int qty;
  @HiveField(2)
  int price;
  @HiveField(3)
  int totalPrice;
  @HiveField(4)
  String unit;
  @HiveField(5)
  String category;
  @HiveField(6)
  String distributor;

  ItemBillEntity({
    this.name,
    this.qty,
    this.price,
    this.totalPrice,
    this.unit,
    this.category,
    this.index,
    this.distributor,
  });

  factory ItemBillEntity.fromJson(Map<String, dynamic> json) => ItemBillEntity(
        name: json['name'],
        qty: json['qty'],
        price: json['price'],
        totalPrice: json['total_price'],
        unit: json['unit'],
        category: json['category'],
    index: json['index'],
    distributor: json['distributor'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'qty': qty,
        'price': price,
        'total_price': totalPrice,
        'unit': unit,
        'category': category,
        'index': index,
    'distributor': distributor,
      };

  ItemBillModel toModel() => ItemBillModel(
        name: name,
        qty: qty,
        price: price,
        totalPrice: totalPrice,
        unit: unit,
        category: category,
      distributor: distributor,
      );
}
