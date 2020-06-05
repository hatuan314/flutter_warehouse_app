import 'package:flutterwarehouseapp/src/product/data/data.dart';
import 'package:flutterwarehouseapp/src/product/domain/entities/entities.dart';

class ProductUseCase {
  ProductRepositoryImpl _repositoryImpl = ProductRepositoryImpl();

  Future<List<ProductEntity>> getAllProducts() async {
    List<ProductEntity> productEntities = <ProductEntity>[];
    List<ProductModel> productModels = await _repositoryImpl.getAllProducts();
    productModels.forEach((productModel) =>
        productEntities.add(ProductEntity.fromJson(productModel.toJson())));
  }

  Future addNewProduct(ProductEntity productEntity) async =>
      await _repositoryImpl
          .addNewProduct(ProductModel.fromJson(productEntity.toJson()));
}
