import 'package:flutterwarehouseapp/src/domain/entities/unit_entity.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'default_env.dart';

class LocalDbSetup {
  Box<UnitEntity> unitBox;

  Future<void> init() async {
    final appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    Hive.registerAdapter(UnitEntityAdapter());
  }


  void dispose() {
    unitBox.compact();
    Hive.close();
  }
}
