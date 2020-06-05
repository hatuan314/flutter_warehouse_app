import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutterwarehouseapp/common/blocs/simple_bloc_delegate.dart';
import 'package:flutterwarehouseapp/common/injector/injector.dart';
import 'package:flutterwarehouseapp/data/database.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  setup();
  await DatabaseCreator().initDatabase();
  runApp(MyApp());
}


