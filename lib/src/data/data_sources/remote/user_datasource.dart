import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/configs/default_env.dart';
import 'package:flutterwarehouseapp/common/configs/firebase_setup.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/remote/base_service.dart';
import 'package:flutterwarehouseapp/src/data/models/user_model.dart';

class UserDataSource {
  final SetupFirebaseDatabase setup;
  final BaseService service;

  UserDataSource({@required this.setup, @required this.service});

  Future<bool> createUser(UserModel user) async {
    DocumentReference docRef = await service.setDocumentRef(
        ref: setup.mainDoc.collection(DefaultConfig.profileCollection),
        request: user.toJson());
    if (docRef != null) {
      return true;
    }
    return false;
  }

  Future<QuerySnapshot> getUser(String uid) async {
    return service.getQuerySnapshotList(
        setup.mainDoc.collection(DefaultConfig.profileCollection));
  }
}
