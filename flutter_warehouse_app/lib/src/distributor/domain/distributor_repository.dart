import 'package:flutterwarehouseapp/src/distributor/data/models/models.dart';

abstract class DistributorRepository {
  Future<List<DistributorModel>> getAllDistributors();
  Future addNewDistributor(DistributorModel distributorModel);
}