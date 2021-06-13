import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/configs/firebase_setup.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/remote/base_service.dart';
import 'package:flutterwarehouseapp/src/data/models/user_model.dart';

class UserDataSource {
  final SetupFirebaseDatabase setup;
  final BaseService service;

  UserDataSource({@required this.setup, @required this.service});

  Future<bool> createUser(UserModel user) async {
    return service.setDocumentSnapshot(
        ref: setup.documentRef, request: user.toJson());
  }

  Future<DocumentSnapshot> getUser(String uid) async {
    return service.getDocumentSnapshot(setup.documentRef);
  }
}
