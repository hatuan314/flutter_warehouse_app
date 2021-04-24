import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/login/login_screen.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/splash/blocs/splash_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/splash/blocs/splash_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/splash/splash_screen.dart';

class LoginRoutes {
  static Map<String, WidgetBuilder> getAll() {
    return {
      RouteList.welcome: (context) => BlocProvider(
          create: (_) => locator<SplashBloc>()..add(InitialSplashEvent()),
          child: SplashScreen()),
      RouteList.login: (context) => LoginScreen(),
    };
  }
}
