import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/src/distributor/data/distributor_repository_impl.dart';
import 'package:flutterwarehouseapp/src/distributor/data/models/models.dart';
import 'package:flutterwarehouseapp/src/distributor/domain/entities/distributor_entity.dart';

class DistributorUseCase {
  DistributorRepositoryImpl _repositoryImpl = DistributorRepositoryImpl();

  Future<List<DistributorEntity>> getAllDistributors() async {
    List<DistributorEntity> distributorEntities = <DistributorEntity>[];
    List<DistributorModel> distributorModels =
        await _repositoryImpl.getAllDistributors();
    if (distributorModels.isEmpty) return distributorEntities;

    distributorModels.forEach((distributorModel) => distributorEntities
        .add(DistributorEntity.fromJson(distributorModel.toJson())));
    debugPrint(
        'DistributorUseCase - getAllDistributors - distributorEntities: ${distributorEntities.length}');
    return distributorEntities;
  }

  Future addNewDistributor(DistributorEntity distributorEntity) async =>
      await _repositoryImpl.addNewDistributor(
          DistributorModel.fromJson(distributorEntity.toJson()));
}
