import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_isolate/flutter_isolate.dart';

import 'package:flutterwarehouseapp/common/extensions/list_extensions.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/local/unit_local_datasource.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/remote/unit_data_source.dart';
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
    List<UnitEntity> units = [];
    for (final String name in defaultUnits) {
      final UnitEntity unit = UnitEntity(
        name: name,
        createAt: DateTime.now(),
        lastUpdate: DateTime.now(),
      );
      await unitLds.setUnit(unit);
      units.add(unit);
    }
    FlutterIsolate.spawn(synchronizedUnitCloudList, units);
  }

  @override
  Future<List<UnitEntity>> getUnitCloudList() async {
    QuerySnapshot querySnapshot = await unitDs.getUnitList();
    if (querySnapshot.docs.isSafe) {}
  }

  @override
  Future<List<UnitEntity>> getUnitLocalList() async {

    return unitLds.getUnitList();
  }

  @override
  Future<void> synchronizedUnitLocalList() {
    // TODO: implement synchronizedUnitLocalList
    throw UnimplementedError();
  }

  @override
  void synchronizedUnitCloudList(List<UnitEntity> units) {

    Timer.periodic(
        Duration(seconds: 1), (timer) => print("Timer Running From Isolate 2"));
    Timer.periodic(
        Duration(seconds: 1), (timer) => print("Timer Running From Isolate 2"));
  }
}
