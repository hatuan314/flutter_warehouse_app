import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterwarehouseapp/common/configs/default_env.dart';
import 'package:flutterwarehouseapp/common/configs/firebase_setup.dart';
import 'package:flutterwarehouseapp/src/data/models/unit_model.dart';

import 'base_service.dart';

class UnitDataSource {
  final SetupFirebaseDatabase setup;
  final BaseService service;

  UnitDataSource({this.setup, this.service});

  Future<QuerySnapshot> getUnitList() async {
    return service.getQuerySnapshotList(
        setup.mainDoc.collection(DefaultConfig.unitsCollection));
  }

  Future<DocumentReference> setUnit(UnitModel unit) async {
    return service.setDocumentRef(
      ref: setup.mainDoc.collection(DefaultConfig.unitsCollection),
      request: unit.toJson(),
    );
  }
}
