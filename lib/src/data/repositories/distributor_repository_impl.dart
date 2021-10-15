import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutterwarehouseapp/common/extensions/string_extensions.dart';
import 'package:flutterwarehouseapp/common/utils/connectivity_utils.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/local/distributor_hive.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/remote/distributor_datasource.dart';
import 'package:flutterwarehouseapp/src/data/models/distributor_model.dart';
import 'package:flutterwarehouseapp/src/data/repositories/mixin_repository.dart';
import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/hive_entity.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/distributor_repository.dart';

class DistributorRepositoryImpl extends DistributorRepository with MixinRepository {
  final DistributorDataSource distributorDs;
  final DistributorHive distributorHive;

  DistributorRepositoryImpl({
    @required this.distributorDs,
    @required this.distributorHive,
  });

  @override
  Future<List<DistributorEntity>> getDistributorCloudList() async {
    final QuerySnapshot snapshot = await distributorDs.getDistributorList();
    List<DistributorModel> distributorList = getCloudDataList<DistributorModel>(snapshot);
    return distributorList;
  }

  @override
  Future<List<DistributorEntity>> getDistributorLocalList() {
    return distributorHive.getAllDistributors();
  }

  @override
  Future<void> remove({int index, String document}) async {
    if (document.isNotSafe) {
      await distributorHive.removeDistributor(index);
      return;
    }
    await distributorDs.removeDistributor(document).then((value) async {
      await distributorHive.removeDistributor(index);
    });
  }

  @override
  Future<bool> setDistributor(DistributorEntity distributor) async {
    bool isConnect = await ConnectivityUtils.checkConnectInternet();
    if (isConnect) {
      String document = await setDistributorCloud(distributor);
      if (document.isSafe) {
        distributor.hive = HiveEntity(document: document, isSync: true);
      } else {
        distributor.hive = HiveEntity.normal();
      }
    } else {
      distributor.hive = HiveEntity.normal();
    }
    int key = await distributorHive.setDistributor(distributor);
    if (ValidatorUtils.isNullEmpty(key)) {
      return true;
    }
    return false;
  }

  @override
  Future<void> update({int index, DistributorEntity distributor}) async {
    await distributorDs.updateDistributor(distributor).then((value) async {
      await distributorHive.updateDistributor(
        index: index,
        distributor: distributor,
      );
    });
  }

  @override
  Future<bool> setDistributorLocalList(List<DistributorEntity> distributorList) {
    return distributorHive.setDistributorList(distributorList);
  }

  @override
  Future<String> setDistributorCloud(DistributorEntity distributor) async {
    DocumentReference ref = await distributorDs.setDistributor(distributor.toModel());
    if (ref != null) {
      return ref.id;
    }
    return '';
  }

  @override
  Future<DistributorEntity> getDistributorDetail(String distributorName) async {
    DistributorEntity distributor = await distributorHive.getDistributorDetail(distributorName);
    if (ValidatorUtils.isNullEmpty(distributor)) {
      final QuerySnapshot snapshot = await distributorDs.getDistributorDetail(distributorName);
      List<DistributorModel> distributorList = getCloudDataList<DistributorModel>(snapshot);
      if (!ValidatorUtils.isNullEmptyList(distributorList)) {
        distributor = distributorList.first;
        distributorHive.setDistributor(distributor);
      }
    }
    return distributor;
  }
}
