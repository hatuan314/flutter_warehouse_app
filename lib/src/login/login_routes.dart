import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/src/login/splash/splash_screen.dart';

class LoginRoutes {
  static Map<String, WidgetBuilder> getAll() {
    return {
      RouteList.welcome: (context) {
        return SplashScreen();
      },
    };
  }
}