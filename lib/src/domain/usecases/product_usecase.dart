import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/src/domain/entities/product_entity.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/product_repository.dart';

class ProductUseCase {
  final ProductRepository productRepo;

  ProductUseCase({@required this.productRepo});

  Future<bool> createProduct(ProductEntity product) {
    return productRepo.addProduct(product);
  }
}