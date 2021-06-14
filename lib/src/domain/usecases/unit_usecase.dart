import 'package:flutter/material.dart';

import 'package:flutterwarehouseapp/common/extensions/list_extensions.dart';
import 'package:flutterwarehouseapp/src/domain/entities/unit_entity.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/unit_repository.dart';

class UnitUseCase {
  final UnitRepository unitRepo;

  UnitUseCase({@required this.unitRepo});

  Future<List<UnitEntity>> getUnitList() async {
    List<UnitEntity> units = await unitRepo.getUnitCloudList();
    if (units.isSafe) {
      // synchronized local
      for (final UnitEntity unit in units) {
        await unitRepo.setUnitLocal(unit);
      }
      return units;
    }
    if (units.isNotSafe) {
      // Set and get default units
      await setDefaultUnitList();
      units = await unitRepo.getUnitLocalList();
      return units;
    }
    return units;
  }

  Future<void> setDefaultUnitList() {
    return unitRepo.setDefaultUnitList();
  }
}
