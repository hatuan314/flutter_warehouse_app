import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/src/domain/entities/unit_entity.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/unit_repository.dart';

class UnitUseCase {
  final UnitRepository unitRepo;

  UnitUseCase({@required this.unitRepo});

  Future<List<UnitEntity>> getUnitList() {
    return unitRepo.getUnitLocalList();
  }

  Future<List<UnitEntity>> setDefaultUnitList() {
    return unitRepo.setDefaultUnitList();
  }
}