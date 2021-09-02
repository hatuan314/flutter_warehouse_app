import 'package:flutterwarehouseapp/src/domain/entities/bill_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/category_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/product_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/unit_entity.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'default_env.dart';

class LocalDbSetup {
  Box<UnitEntity> unitBox;
  Box<DistributorEntity> distributorBox;
  Box<CategoryEntity> categoryBox;
  Box<BillEntity> billBox;
  Box<ProductEntity> productBox;

  Future<void> init() async {
    final appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    Hive.registerAdapter(UnitEntityAdapter());
    Hive.registerAdapter(DistributorEntityAdapter());
    Hive.registerAdapter(CategoryEntityAdapter());
    Hive.registerAdapter(BillEntityAdapter());
    Hive.registerAdapter(ProductEntityAdapter());
    unitBox = await Hive.openBox(DefaultConfig.unitsCollection);
    distributorBox = await Hive.openBox(DefaultConfig.distributorsCollection);
    categoryBox = await Hive.openBox(DefaultConfig.categoriesCollection);
    billBox = await Hive.openBox(DefaultConfig.billCollection);
    productBox = await Hive.openBox(DefaultConfig.productCollection);
  }

  void dispose() {
    unitBox.compact();
    distributorBox.compact();
    categoryBox.compact();
    billBox.compact();
    productBox.compact();
    Hive.close();
  }
}
