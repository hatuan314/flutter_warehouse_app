import 'package:flutterwarehouseapp/src/product/data/models/product_model.dart';

import 'package:flutterwarehouseapp/src/product/domain/domain.dart';
import 'product_provider.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductProvider _provider = ProductProvider();
  @override
  Future addNewProduct(ProductModel productModel) {
    // TODO: implement addNewProduct
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> getAllProducts() async => await _provider.selectAllProducts();
  
}