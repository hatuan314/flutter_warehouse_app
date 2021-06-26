import 'package:flutterwarehouseapp/common/configs/local_db_setup.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/snackbar_type.dart';
import 'package:hive/hive.dart';

class DistributorHive {
  final LocalDbSetup database;

  DistributorHive(this.database);

  Future<int> setDistributor(DistributorEntity distributor) async {
    try {
      int key = await database.distributorBox.add(distributor);
      return key;
    } on HiveError catch (e) {
      locator<SnackbarBloc>().add(ShowSnackbar(
          title: StringConstants.createFailureTxt, type: SnackBarType.error));
      return null;
    }
  }

  Future<List<DistributorEntity>> getAllDistributors() async {
    List<DistributorEntity> distributors = [];
    if (database.distributorBox.isNotEmpty) {
      distributors = database.distributorBox.values;
    }
    return distributors;
  }

  Future<void> removeDistributor(int index) async {
    await database.distributorBox.deleteAt(index);
  }

  Future<void> updateDistributor(
      {int index, DistributorEntity distributor}) async {
    await database.distributorBox.putAt(index, distributor);
  }
}
