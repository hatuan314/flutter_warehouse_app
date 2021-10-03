import 'package:flutterwarehouseapp/common/configs/local_db_setup.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/src/domain/entities/product_entity.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/snackbar_type.dart';
import 'package:hive/hive.dart';

class ProductHive {
  final LocalDbSetup database;

  ProductHive(this.database);

  Future<int> setProduct(ProductEntity product) async {
    try {
      int key = await database.productBox.add(product);
      return key;
    } on HiveError catch (e) {
      locator<SnackbarBloc>().add(ShowSnackbar(
          title: StringConstants.createFailureTxt, type: SnackBarType.error));
      return null;
    }
  }

  Future setProductList(List<ProductEntity> products) async {
    database.productBox.addAll(products);
  }

  Future<List<ProductEntity>> getAllProductList() async {
    List<ProductEntity> productList = [];
    if (database.productBox.isNotEmpty) {
      productList.addAll(database.productBox.values.toList());
    }
    return productList;
  }

  Future<void> updateProduct(
      {int index, ProductEntity product}) async {
    await database.productBox.putAt(index, product);
  }

}