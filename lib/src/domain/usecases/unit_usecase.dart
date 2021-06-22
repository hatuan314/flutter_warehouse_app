import 'package:flutter/material.dart';

import 'package:flutterwarehouseapp/common/extensions/list_extensions.dart';
import 'package:flutterwarehouseapp/src/domain/entities/unit_entity.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/unit_repository.dart';

class UnitUseCase {
  final UnitRepository unitRepo;

  UnitUseCase({@required this.unitRepo});

  Future<List<UnitEntity>> getUnitList() async {
    List<UnitEntity> units = await unitRepo.getUnitLocalList();
    if (units.isSafe) {
      return units;
    }
    if (units.isNotSafe) {
      units = await getUnitListCloud();
      return units;
    }
    return [];
  }

  Future<List<UnitEntity>> getUnitListCloud() async {
    List<UnitEntity> units = await unitRepo.getUnitCloudList();
    if (units.isNotSafe) {
      await setDefaultUnitList();
      units = await unitRepo.getUnitLocalList();
      return units;
    }
    if (units.isSafe) {
      await unitRepo.setUnitListLocal(units);
      return units;
    }
    return [];
  }

  Future<void> setDefaultUnitList() {
    return unitRepo.setDefaultUnitList();
  }

  Future<void> removeAllUnits() {
    return unitRepo.removeAll();
  }
}
