import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/configs/firebase_setup.dart';
import 'package:flutterwarehouseapp/common/configs/local_db_setup.dart';

import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/simple_bloc_delegate.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  setup();
  final setupFirebaseDB = locator<SetupFirebaseDatabase>();
  final localDbSetup = locator<LocalDbSetup>();
  await setupFirebaseDB.init();
  await localDbSetup.init();
  runApp(MyApp());
}


