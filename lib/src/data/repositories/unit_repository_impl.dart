import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutterwarehouseapp/common/extensions/list_extensions.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/local/unit_hive.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/remote/unit_datasource.dart';
import 'package:flutterwarehouseapp/src/data/models/unit_model.dart';
import 'package:flutterwarehouseapp/src/data/units.dart';
import 'package:flutterwarehouseapp/src/domain/entities/unit_entity.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/unit_repository.dart';

class UnitRepositoryImpl implements UnitRepository {
  final UnitDataSource unitDs;
  final UnitLocalDataSource unitLds;

  UnitRepositoryImpl({@required this.unitDs, @required this.unitLds});

  @override
  Future<void> setDefaultUnitList() async {
    for (final String name in defaultUnits) {
      final UnitEntity unit = UnitEntity(
        name: name,
        createAt: DateTime.now(),
        lastUpdate: DateTime.now(),
      );
      DocumentReference docRef = await unitDs.setUnit(unit.toModel());
      unit.id = docRef.id;
      await setUnitLocal(unit);
    }
  }

  @override
  Future<List<UnitEntity>> getUnitCloudList() async {
    QuerySnapshot querySnapshot = await unitDs.getUnitList();
    List<UnitEntity> units = [];
    if (querySnapshot.docs.isSafe) {
      for (final QueryDocumentSnapshot doc in querySnapshot.docs) {
        final UnitModel unit = UnitModel.fromJson(doc.data(), id: doc.id);
        units.add(unit);
      }
    }
    return units;
  }

  @override
  Future<List<UnitEntity>> getUnitLocalList() async {
    return unitLds.getUnitList();
  }

  @override
  Future<void> setUnitLocal(UnitEntity unit) async {
    await unitLds.setUnit(unit);
  }

  @override
  Future<void> setUnitListLocal(List<UnitEntity> units) async {
    await unitLds.setUnitList(units);
  }

  @override
  Future<void> removeAll() async {
    await unitLds.removeAll();
  }
}
