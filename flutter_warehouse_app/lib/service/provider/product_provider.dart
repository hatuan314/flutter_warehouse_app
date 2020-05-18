

import 'package:flutterwarehouseapp/models/product/product_model.dart';
import 'package:flutterwarehouseapp/service/service.dart';

class ProductProvider {
  Future<List<ProductModel>> selectAllProducts() async {
    try {

    } catch (e) {

    }
    final List<Map<String, dynamic>> maps = await db.query('${DatabaseCreator.productTable}');

    return List.generate(maps.length, (index) {
      return ProductModel.fromJson(maps[index]);
    });
  }
}