import 'package:flutter/cupertino.dart';

import 'package:flutterwarehouseapp/common/extensions/string_extensions.dart';
import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/distributor_repository.dart';

class DistributorUseCase {
  final DistributorRepository distributorRepo;

  DistributorUseCase({@required this.distributorRepo});

  Future<bool> addDistributor(DistributorEntity distributor) async {
    return distributorRepo.setDistributor(distributor);
  }

  Future<List<DistributorEntity>> getDistributorList() async {
    return distributorRepo.getDistributorList();
  }

  Future<DistributorEntity> getDistributorDetail(String name) async {
    return distributorRepo.getDistributorDetail(name);
  }

  Future<void> updateDistributor(
      {int index, DistributorEntity distributor}) async {
    // Step 1: Check document property is Safe
    if (distributor.hive.document.isNotSafe) {
      // Step 1.1: If document property is not safe.
      // Add distributor to cloud DB and get document
      String document = await distributorRepo.setDistributorCloud(distributor);
      distributor.hive.document = document;
    }
    // Step 2: Update distributor inside local DB
    await distributorRepo.update(index: index, distributor: distributor);
  }

  Future<void> removeDistributor({int index, String document}) async {
    await distributorRepo.remove(index: index, document: document);
  }
}
