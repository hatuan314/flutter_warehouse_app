import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/configs/local_db_setup.dart';
import 'package:flutterwarehouseapp/src/domain/entities/unit_entity.dart';

class UnitLocalDataSource {
  final LocalDbSetup database;

  UnitLocalDataSource({@required this.database});

  UnitEntity getFirstUnit() {
    if (database.unitBox.isNotEmpty) {
      return database.unitBox.getAt(0);
    }
    return null;
  }

  Future<List<UnitEntity>> getUnitList() async {
    List<UnitEntity> units = [];
    if (database.unitBox.length != null) {
      units.addAll(database.unitBox.values.toList());
    }
    return units;
  }

  Future<void> setUnit(UnitEntity unit) async {
    await database.unitBox.add(unit);
  }

  Future<void> setUnitList(List<UnitEntity> units) async {
    await database.unitBox.addAll(units);
  }

  Future<void> removeAll() async {
    await database.unitBox.clear();
  }
}
