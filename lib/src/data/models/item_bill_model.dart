import 'package:flutterwarehouseapp/src/domain/entities/item_bill_entity.dart';

class ItemBillModel extends ItemBillEntity {
  ItemBillModel({
    String name,
    int qty,
    int price,
    int totalPrice,
    String unit,
    String category,
  }) : super(
          name: name,
          qty: qty,
          price: price,
          totalPrice: totalPrice,
          unit: unit,
          category: category,
        );

  factory ItemBillModel.fromJson(Map<String, dynamic> json) => ItemBillModel(
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
}
