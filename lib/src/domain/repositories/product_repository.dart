import 'package:flutterwarehouseapp/src/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<bool> addProduct(ProductEntity productEntity);

  Future<String> addProductCloud(ProductEntity productEntity);

  Future addProductLocalList(List<ProductEntity> productList);

  Future<ProductEntity> getProduct(int index);

  Future<List<ProductEntity>> getAllProductCloudList();

  Future<List<ProductEntity>> getAllProductLocalList();

  Future updateProduct({ProductEntity product, int index});
}