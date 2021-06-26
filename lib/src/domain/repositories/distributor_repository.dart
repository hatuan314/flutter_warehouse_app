import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';

abstract class DistributorRepository {
  Future<List<DistributorEntity>> getDistributorCloudList();

  Future<List<DistributorEntity>> getDistributorLocalList();

  Future<bool> setDistributor(DistributorEntity distributor);
  Future<bool> setDistributorLocalList(List<DistributorEntity> distributorList);

  Future<void> remove({int index, String document});

  Future<void> update({int index, DistributorEntity distributor});
}
