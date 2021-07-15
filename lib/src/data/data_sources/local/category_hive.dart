import 'package:flutterwarehouseapp/common/configs/local_db_setup.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/src/domain/entities/category_entity.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/snackbar_type.dart';
import 'package:hive/hive.dart';

class CategoryHive {
  final LocalDbSetup database;

  CategoryHive(this.database);

  Future<int> setCategory(CategoryEntity category) async {
    try {
      int key = await database.categoryBox.add(category);
      return key;
    } on HiveError catch (e) {
      locator<SnackbarBloc>().add(ShowSnackbar(
          title: StringConstants.createFailureTxt, type: SnackBarType.error));
      return null;
    }
  }
}