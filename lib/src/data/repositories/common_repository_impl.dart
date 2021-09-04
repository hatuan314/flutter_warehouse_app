import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/data/models/bill_model.dart';
import 'package:flutterwarehouseapp/src/data/models/category_model.dart';
import 'package:flutterwarehouseapp/src/data/models/distributor_model.dart';
import 'package:flutterwarehouseapp/src/domain/entities/hive_entity.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/common_repository.dart';

class CommonRepositoryImpl extends CommonRepository {

  @override
  Future<List<T>> getDataCloudList<T>() {
    // TODO: implement getDataCloudList
    throw UnimplementedError();
  }

  @override
  Future<List<T>> getDataLocalList<T>() {
    // TODO: implement getDataLocalList
    throw UnimplementedError();
  }

  @override
  Future setAllDataLocal<T>() {
    // TODO: implement setAllDataLocal
    throw UnimplementedError();
  }

  @override
  Future<bool> setData<T>(T entity) {
    // TODO: implement setData
    throw UnimplementedError();
  }

  @override
  Future<String> setDataCloud<T>(T entity) {
    // TODO: implement setDataCloud
    throw UnimplementedError();
  }

  @override
  Future<int> setDataLocal<T>(T entity) {
    // TODO: implement setDataLocal
    throw UnimplementedError();
  }

  @override
  Future updateByIndex<T>(T entity, int index) {
    // TODO: implement updateByIndex
    throw UnimplementedError();
  }

  @override
  Future updateByKey<T>(T entity, int key) {
    // TODO: implement updateByKey
    throw UnimplementedError();
  }

  @override
  Future updateDataCloud<T>(T entity) {
    // TODO: implement updateDataCloud
    throw UnimplementedError();
  }
}
