import 'package:flutter/cupertino.dart';
import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/distributor_repository.dart';

class DistributorUseCase {
  final DistributorRepository distributorRepo;

  DistributorUseCase({@required this.distributorRepo});

  Future<bool> addDistributor(DistributorEntity distributor) async {
    return distributorRepo.setDistributor(distributor);
  }
}