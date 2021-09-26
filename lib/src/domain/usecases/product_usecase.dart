import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/item_bill_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/product_entity.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/product_repository.dart';

class ProductUseCase {
  final ProductRepository productRepo;

  ProductUseCase({@required this.productRepo});

  Future<bool> createProduct(ProductEntity product) {
    return productRepo.addProduct(product);
  }

  List<ProductEntity> getProductListFormItemBill({
    List<ItemBillEntity> itemBillList,
    DistributorEntity distributor,
    String locale,
  }) {
    List<ProductEntity> productList = [];
    for (final ItemBillEntity itemBill in itemBillList) {
      final ProductEntity product = ProductEntity(
        name: itemBill.name,
        category: itemBill.category,
        qty: itemBill.qty,
        importPrice: itemBill.price,
        exportPrice: itemBill.price,
        locale: locale,
        createAt: DateTime.now().millisecondsSinceEpoch,
        lastUpdate: DateTime.now().millisecondsSinceEpoch,
        unit: itemBill.unit,
        distributor: distributor.name,
      );
      productList.add(product);
    }
    return productList;
  }

  Future setProduct(ProductEntity product) async {
    await createProduct(product);
  }

  Future setProductList(List<ProductEntity> productList) async {
    for (final ProductEntity product in productList) {
      await createProduct(product);
    }
  }

  Future<List<ProductEntity>> getProductList() async {
    List<ProductEntity> productList = await productRepo.getAllProductLocalList();
    if (ValidatorUtils.isNullEmptyList(productList)) {
      productList = await productRepo.getAllProductCloudList();
      productRepo.addProductLocalList(productList);
    }
    return productList;
  }

  int getProductIndex({List<ProductEntity> productList, ProductEntity currentProduct}) {
    for (int index = 0; index < productList.length; index++) {
      ProductEntity product = productList[index];
      if (product.name == currentProduct.name &&
          product.distributor == currentProduct.distributor &&
          product.category == currentProduct.category) {
        return index;
      }
    }
    return -1;
  }
}
