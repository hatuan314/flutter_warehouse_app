import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterwarehouseapp/common/configs/default_env.dart';
import 'package:flutterwarehouseapp/common/configs/firebase_setup.dart';

import 'base_service.dart';

class UnitDataSource {
  final SetupFirebaseDatabase setup;
  final BaseService service;

  UnitDataSource({this.setup, this.service});

  Future<QuerySnapshot> getUnitList() async {
    return service.getDocumentSnapshotList(
        setup.documentRef.collection(DefaultConfig.unitsCollection));
  }
}
