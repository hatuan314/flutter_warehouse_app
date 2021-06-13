import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutterwarehouseapp/common/configs/default_env.dart';

class SetupFirebaseDatabase {
  FirebaseApp app;
  FirebaseDatabase database;
  FirebaseAuth auth;
  DocumentReference mainDoc;

  Future<void> init() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    auth = FirebaseAuth.instance;
  }

  void setMainDocumentRef(String uid) {
    mainDoc = FirebaseFirestore.instance
        .collection(DefaultConfig.appName)
        .doc(DefaultConfig.environment)
        .collection(DefaultConfig.mainCollection)
        .doc(uid);
  }
}
