

import 'package:flutterwarehouseapp/models/distributor/distributor_model.dart';
import 'package:flutterwarehouseapp/models/product/product_model.dart';

class ShareService {
  static final ShareService _singleton = ShareService._internal();

  ShareService._internal();

  factory ShareService() {
    return _singleton;
  }

  List<ProductModel> _allProducts = <ProductModel>[];
  List<DistributorModel> _allDistributors = <DistributorModel>[];

  List<ProductModel> get allProducts => _allProducts;

  set allProducts(List<ProductModel> value) {
    _allProducts = value;
  }

  List<DistributorModel> get allDistributors => _allDistributors;

  set allDistributors(List<DistributorModel> value) {
    _allDistributors = value;
  }
}