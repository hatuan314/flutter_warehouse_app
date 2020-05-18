import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutterwarehouseapp/blocs/simple_bloc_delegate.dart';
import 'package:flutterwarehouseapp/service/database.dart';

import 'app.dart';
import 'service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  setupLocator();
  await DatabaseCreator().initDatabase();
  runApp(MyApp());
}


