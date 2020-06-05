import 'package:flutterwarehouseapp/src/product/domain/entities/entities.dart';

class ProductModel extends ProductEntity {
  ProductModel({String id, String name, String salePrice, String categoryId})
      : super(id: id, name: name, salePrice: salePrice, categoryId: categoryId);

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        name: json['name'],
        salePrice: json['sale_price'],
        categoryId: json['category_id']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = int.parse(id);
    json['name'] = name;
    json['sale_price'] = salePrice;
    json['category_id'] = categoryId;
    return toJson();
  }
}
