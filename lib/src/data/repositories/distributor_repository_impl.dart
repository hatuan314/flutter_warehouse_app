import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutterwarehouseapp/common/extensions/list_extensions.dart';
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
  Future<void> remove({int index, String document}) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<bool> setDistributor(DistributorEntity distributor) async {
    // Step 1: Add distributor to cloud database
    DocumentReference ref =
        await distributorDs.setDistributor(distributor.toModel());
    if (ref == null) {
      return false;
    }
    if (ref != null) {
      // Step 2: Add distributor to local database
      distributor.document = ref.id;
      int key = await distributorHive.setDistributor(distributor);
      if (key != null) {
        log('>>>>DistributorRepo - addDistributor - local: $key');
        return true;
      }
      return false;
    }
    return false;
  }

  @override
  Future<void> update({int index, DistributorEntity distributor}) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<bool> setDistributorLocalList(List<DistributorEntity> distributorList) {
    return distributorHive.setDistributorList(distributorList);
  }
}
