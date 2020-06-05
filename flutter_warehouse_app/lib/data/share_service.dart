import 'package:flutterwarehouseapp/src/product/data/models/product_model.dart';
import 'package:flutterwarehouseapp/src/distributor/distributor.dart';
import 'package:flutterwarehouseapp/src/product/product.dart';

class ShareService {
  static final ShareService _singleton = ShareService._internal();

  ShareService._internal();

  factory ShareService() {
    return _singleton;
  }

  List<ProductEntity> allProducts = <ProductEntity>[];
  List<DistributorEntity> allDistributors = <DistributorEntity>[];
}