import 'package:flutterwarehouseapp/src/product/data/models/models.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> getAllProducts();
  Future addNewProduct(ProductModel productModel);
}