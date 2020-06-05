import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/data/data.dart';
import 'package:flutterwarehouseapp/src/product/data/models/models.dart';

class ProductProvider {
  Future<List<ProductModel>> selectAllProducts() async {

    List<ProductModel> allProducts = <ProductModel>[];
    try {
      final List<Map<String, dynamic>> maps =
      await db.query('${DatabaseCreator.productTable}', orderBy: 'name ASC');

      allProducts = List.generate(maps.length, (index) {
        return ProductModel.fromJson(maps[index]);
      });
    } catch (e) {
      debugPrint(
          'DistributorProvider - selectAllDistributors - Error: {${e.toString()}}');
    }
    return allProducts;
  }
}