import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class SetupFirebaseDatabase {
  FirebaseApp app;
  FirebaseDatabase database;
  FirebaseAuth auth;

  init() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    auth = FirebaseAuth.instance;
  }
}