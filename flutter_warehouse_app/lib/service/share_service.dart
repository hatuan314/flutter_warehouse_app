

import 'package:flutterwarehouseapp/models/product/product_model.dart';

class ShareService {
  static final ShareService _singleton = ShareService._internal();

  ShareService._internal();

  factory ShareService() {
    return _singleton;
  }

  List<ProductModel> _allProducts = [];

  List<ProductModel> get allProducts => _allProducts;

  set allProducts(List<ProductModel> value) {
    _allProducts = value;
  }
}