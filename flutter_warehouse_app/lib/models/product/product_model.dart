import 'package:flutter/cupertino.dart';

class ProductModel {
  String id;
  String name;
  String salePrice;
  String categoryId;

  ProductModel({this.id, this.name, this.salePrice, this.categoryId});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    try {
      return ProductModel(
          id: json['id'],
          name: json['name'],
          salePrice: json['sale_price'],
          categoryId: json['category_id']);
    } catch (e) {
      debugPrint('ProductModel.fromJson: {${e.toString()}}');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic> {};
    json['id'] = int.parse(id);
    json['name'] = name;
    json['sale_price'] = salePrice;
    json['category_id'] = categoryId;
  }
}
