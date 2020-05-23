import 'package:flutter/material.dart';

import 'package:flutterwarehouseapp/models/models.dart';
import 'package:flutterwarehouseapp/service/service.dart';

class ProductProvider {
  Future<List<ProductModel>> selectAllProducts() async {
    List<ProductModel> allProducts = <ProductModel>[];
    try {
      final List<Map<String, dynamic>> maps =
          await db.query('${DatabaseCreator.productTable}');

      allProducts = List.generate(maps.length, (index) {
        return ProductModel.fromJson(maps[index]);
      });
    } catch (e) {
      debugPrint('ProductProvider - Error: {${e.toString()}}');
    }
    return allProducts;
  }
}
