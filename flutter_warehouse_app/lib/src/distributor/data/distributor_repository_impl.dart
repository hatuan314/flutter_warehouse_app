import 'package:flutterwarehouseapp/src/distributor/data/data.dart';
import 'package:flutterwarehouseapp/src/distributor/data/distributor_provider.dart';
import 'package:flutterwarehouseapp/src/distributor/domain/distributor_repository.dart';

class DistributorRepositoryImpl implements DistributorRepository {
  DistributorProvider _provider = DistributorProvider();

  @override
  Future addNewDistributor(DistributorModel distributorModel) =>
      _provider.insertDistributor(distributorModel);

  @override
  Future<List<DistributorModel>> getAllDistributors() =>
      _provider.selectAllDistributors();
}
