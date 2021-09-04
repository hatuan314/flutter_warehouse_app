import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/utils/connectivity_utils.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/local/product_hive.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/remote/product_datasource.dart';
import 'package:flutterwarehouseapp/src/domain/entities/hive_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/product_entity.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource productDs;
  final ProductHive productHive;

  ProductRepositoryImpl({@required this.productDs, @required this.productHive});

  @override
  Future<bool> addProduct(ProductEntity productEntity) async {
    bool isConnect = await ConnectivityUtils.checkConnectInternet();
    if (isConnect) {
      String document = await addProductCloud(productEntity);
      if (!ValidatorUtils.isNullEmpty(document)) {
        productEntity.hive = HiveEntity(document: document, isSync: true);
      } else {
        productEntity.hive = HiveEntity.normal();
      }
    } else {
      productEntity.hive = HiveEntity.normal();
    }
    int key = await productHive.setProduct(productEntity);
    if (!ValidatorUtils.isNullEmpty(key)) {
      return true;
    }
  }

  @override
  Future<String> addProductCloud(ProductEntity productEntity) async {
    DocumentReference ref = await productDs.setProduct(productEntity.toModel());
    if (!ValidatorUtils.isNullEmpty(ref)) {
      return ref.id;
    }
    return '';
  }
}
