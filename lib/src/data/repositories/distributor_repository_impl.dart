import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutterwarehouseapp/common/extensions/list_extensions.dart';
import 'package:flutterwarehouseapp/common/extensions/string_extensions.dart';
import 'package:flutterwarehouseapp/common/utils/connectivity_utils.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/local/distributor_hive.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/remote/distributor_datasource.dart';
import 'package:flutterwarehouseapp/src/data/models/distributor_model.dart';
import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/distributor_repository.dart';

class DistributorRepositoryImpl implements DistributorRepository {
  final DistributorDataSource distributorDs;
  final DistributorHive distributorHive;

  DistributorRepositoryImpl({
    @required this.distributorDs,
    @required this.distributorHive,
  });

  @override
  Future<List<DistributorEntity>> getDistributorCloudList() async {
    final QuerySnapshot snapshot = await distributorDs.getDistributorList();
    List<DistributorModel> distributorList = [];
    if (snapshot.docs.isSafe) {
      snapshot.docs.forEach((doc) {
        DistributorModel distributor = DistributorModel.fromJson(doc.data());
        distributor.document = doc.id;
        distributorList.add(distributor);
      });
    }
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
        distributor.document = document;
        distributor.isSync = true;
      }
    } else {
      distributor.isSync = false;
    }
    int key = await distributorHive.setDistributor(distributor);
    if (key != null) {
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
}
