import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/configs/local_db_setup.dart';
import 'package:flutterwarehouseapp/src/domain/entities/unit_entity.dart';

class UnitLocalDataSource {
  final LocalDbSetup database;

  UnitLocalDataSource({@required this.database});

  List<UnitEntity> getUnitList() {
    List<UnitEntity> units= database.unitBox.values.toList();
    log('>>>>>UnitLocalDataSource - getUnitList - result: ${units?.length}');
    return units;
  }

  Future<void> setUnit(UnitEntity unit) async {
    int result = await database.unitBox.add(unit);
    log('>>>>>UnitLocalDataSource - setUnit - result: $result');
  }
}