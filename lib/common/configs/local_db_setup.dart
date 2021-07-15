import 'package:flutterwarehouseapp/src/domain/entities/category_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/unit_entity.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'default_env.dart';

class LocalDbSetup {
  Box<UnitEntity> unitBox;
  Box<DistributorEntity> distributorBox;
  Box<CategoryEntity> categoryBox;

  Future<void> init() async {
    final appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    Hive.registerAdapter(UnitEntityAdapter());
    Hive.registerAdapter(DistributorEntityAdapter());
    Hive.registerAdapter(CategoryEntityAdapter());
    unitBox = await Hive.openBox(DefaultConfig.unitsCollection);
    distributorBox = await Hive.openBox(DefaultConfig.distributorsCollection);
    categoryBox = await Hive.openBox(DefaultConfig.categoriesCollection);
  }

  void dispose() {
    unitBox.compact();
    distributorBox.compact();
    categoryBox.compact();
    Hive.close();
  }
}
