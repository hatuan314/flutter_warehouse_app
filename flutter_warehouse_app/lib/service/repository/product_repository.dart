

import 'package:flutterwarehouseapp/models/product/product_model.dart';
import 'package:flutterwarehouseapp/service/service.dart';

class ProductRepository {
  var _productProvider = ProductProvider();

  Future<List<ProductModel>> fetchProductRepository() => _productProvider.selectAllProducts();
}