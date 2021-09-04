import 'package:flutter/material.dart';
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
    String locale,
  }) {
    List<ProductEntity> productList = [];
    for (final ItemBillEntity itemBill in itemBillList) {
      final ProductEntity product = ProductEntity(
        name: itemBill.name,
        qty: itemBill.qty,
        importPrice: itemBill.price,
        exportPrice: itemBill.price,
        locale: locale,
        createAt: DateTime.now().millisecondsSinceEpoch,
        lastUpdate: DateTime.now().millisecondsSinceEpoch,
        unit: itemBill.unit,
      );
      productList.add(product);
    }
    return productList;
  }

  Future setProductList(List<ProductEntity> productList) async {
    for (final ProductEntity product in productList) {
      await createProduct(product);
    }
  }
}
