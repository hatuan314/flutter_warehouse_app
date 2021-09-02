import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/utils/connectivity_utils.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/local/product_hive.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/remote/product_datasource.dart';
import 'package:flutterwarehouseapp/src/domain/entities/product_entity.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/common_repository.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource productDs;
  final ProductHive productHive;
  final CommonRepository commonRepo;

  ProductRepositoryImpl({@required this.productDs, @required this.productHive, @required this.commonRepo});

  @override
  Future<bool> addProduct(ProductEntity productEntity) async {
    bool isConnect = await ConnectivityUtils.checkConnectInternet();
    if (isConnect) {
      String document = await addProductCloud(productEntity);
      if (!ValidatorUtils.isNullEmpty(document)) {
        productEntity.document = document;
        productEntity.isSync = true;
      } else {
        productEntity.isSync = false;
      }
      int key = await productHive.setProduct(productEntity);
      if (!ValidatorUtils.isNullEmpty(key)) {
        return true;
      }
      return false;
    } else {
      return false;
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
