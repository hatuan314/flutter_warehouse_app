import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/common/utils/screen_utils.dart';
import 'package:flutterwarehouseapp/route.dart';
import 'package:flutterwarehouseapp/src/themes/theme_data.dart';

class MyApp extends StatelessWidget {
  String get initialRoute {
    return RouteList.welcome;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Warehouse',
      builder: (context, widget) {
        ScreenUtil.init(context);
        return widget;
      },
      theme: appTheme(context),
      initialRoute: initialRoute,
      routes: Routes.getAll(),
      // onGenerateRoute: router(),
    );
  }
}
