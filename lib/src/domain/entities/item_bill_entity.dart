import 'package:hive/hive.dart';

import 'package:flutterwarehouseapp/src/data/models/item_bill_model.dart';

part 'item_bill_entity.g.dart';

@HiveType(typeId: 4)
class ItemBillEntity {
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

  ItemBillEntity({
    this.name,
    this.qty,
    this.price,
    this.totalPrice,
    this.unit,
    this.category,
  });

  factory ItemBillEntity.fromJson(Map<String, dynamic> json) => ItemBillEntity(
        name: json['name'],
        qty: json['qty'],
        price: json['price'],
        totalPrice: json['total_price'],
        unit: json['unit'],
      category: json['category'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'qty': qty,
        'price': price,
        'total_price': totalPrice,
        'unit': unit,
    'category': category,
      };

  ItemBillModel toModel() => ItemBillModel(
        name: name,
        qty: qty,
        price: price,
        totalPrice: totalPrice,
        unit: unit,
      category: category,
      );
}
