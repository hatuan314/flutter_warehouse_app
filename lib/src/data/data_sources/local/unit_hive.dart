import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/configs/default_env.dart';
import 'package:flutterwarehouseapp/common/configs/local_db_setup.dart';
import 'package:flutterwarehouseapp/src/domain/entities/unit_entity.dart';
import 'package:hive/hive.dart';

class UnitLocalDataSource {
  final LocalDbSetup database;

  UnitLocalDataSource({@required this.database});

  Future<List<UnitEntity>> getUnitList() async {
    Box unitBox = await Hive.openBox<UnitEntity>(DefaultConfig.unitsCollection);
    log('>>>>>UnitHive - getUnitList - unit: ${unitBox?.length}');
    int length = unitBox.length;
    List<UnitEntity> units = [];
    for(int index = 0; index < length; index++) {
      final UnitEntity unit = unitBox.getAt(index) as UnitEntity;
      units.add(unit);
    }
    return units;
  }

  Future<void> setUnit(UnitEntity unit) async {
    log('>>>>>UnitHive - setUnit - unit: ${unit.toModel().toJson()}');
    Box box = Hive.box<UnitEntity>(DefaultConfig.unitsCollection);
    await box.add(unit);
  }
}