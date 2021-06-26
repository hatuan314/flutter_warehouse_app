import 'package:flutterwarehouseapp/common/configs/local_db_setup.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/common/extensions/list_extensions.dart';
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

  Future<bool> setDistributorList(
      List<DistributorEntity> distributorList) async {
    try {
      List<int> keys =
          List<int>.from(await database.distributorBox.addAll(distributorList));
      return keys.isSafe;
    } on HiveError catch (e) {
      locator<SnackbarBloc>().add(ShowSnackbar(
          title: StringConstants.createFailureTxt, type: SnackBarType.error));
      return false;
    }
  }

  Future<List<DistributorEntity>> getAllDistributors() async {
    List<DistributorEntity> distributors = [];
    if (database.distributorBox.isNotEmpty) {
      distributors.addAll(database.distributorBox.values.toList());
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
