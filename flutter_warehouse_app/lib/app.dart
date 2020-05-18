import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/route.dart';


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Warehouse',
      theme: ThemeData(
        fontFamily: 'QS',
        primaryColor: Colors.indigo[800],
      ),
      onGenerateRoute: router(),
    );
  }
}