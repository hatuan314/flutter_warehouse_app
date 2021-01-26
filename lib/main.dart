import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';

import 'package:flutterwarehouseapp/src/blocs/simple_bloc_delegate.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  setup();
  runApp(MyApp());
}


