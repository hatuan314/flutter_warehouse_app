import 'package:flutterwarehouseapp/models/models.dart';
import 'package:flutterwarehouseapp/service/provider/distributor_provider.dart';

class DistributorRepository {
  DistributorProvider provider = DistributorProvider();

  Future<void> createNewDistributorReposotpry(
          DistributorModel distributorModel) =>
      provider.insertDistributor(distributorModel);

  Future<List<DistributorModel>> getAllDistributors() =>
      provider.selectAllDistributors();
}
