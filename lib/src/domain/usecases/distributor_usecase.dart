import 'package:flutter/cupertino.dart';

import 'package:flutterwarehouseapp/common/extensions/list_extensions.dart';
import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/distributor_repository.dart';

class DistributorUseCase {
  final DistributorRepository distributorRepo;

  DistributorUseCase({@required this.distributorRepo});

  Future<bool> addDistributor(DistributorEntity distributor) async {
    return distributorRepo.setDistributor(distributor);
  }

  Future<List<DistributorEntity>> getDistributorList() async {
    // Step 1: Get distributor list local;
    List<DistributorEntity> distributorList =
        await distributorRepo.getDistributorLocalList();
    if (distributorList.isNotSafe) {
      distributorList = await distributorRepo.getDistributorCloudList();
      distributorRepo.setDistributorLocalList(distributorList);
    }
    return distributorList;
  }
}
