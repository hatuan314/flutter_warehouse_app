import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/login_routes.dart';

class Routes {
  static Map<String, WidgetBuilder> _getCombinedRoutes() => {
    ...LoginRoutes.getAll(),
  };

  static Map<String, WidgetBuilder> getAll() => _getCombinedRoutes();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteList.confirmOtp:
        return MaterialPageRoute(
            builder: LoginRoutes.getRoutesWithSettings(settings)[settings.name],
            settings: settings);
      // case RouteList.loginVerifyCode:
      // case RouteList.createDevicePIN:
      // case RouteList.createProfile:
      //   return MaterialPageRoute(
      //       builder: LoginRoutes.getRoutesWithSettings(settings)[settings.name],
      //       settings: settings);
      // case RouteList.enterPIN:
      //   if (settings.arguments != null) {
      //     return MaterialPageRoute(
      //         builder:
      //         LoginRoutes.getRoutesWithSettings(settings)[settings.name],
      //         settings: settings);
      //   }
      //   return PageRouteBuilder(
      //       pageBuilder: (context, animation, secondaryAnimation) =>
      //           BlocProvider(
      //               create: (_) => Injector.resolve<EnterPinBloc>()
      //                 ..add(EnterPinInitialEvent()),
      //               child: EnterPINScreen()));
      // case RouteList.categoriesList:
      //   return MaterialPageRoute(
      //       builder:
      //       PersonalRoutes.getRoutesWithSettings(settings)[settings.name],
      //       settings: settings);
      // case RouteList.addGoal:
      //   return MaterialPageRoute<GoalDetailEntity>(
      //       builder: GoalRoutes.getRoutesWithSettings(settings)[settings.name],
      //       settings: settings);
      // case RouteList.personalExpense:
      // case RouteList.whoPaid:
      // case RouteList.forWho:
      // case RouteList.showImage:
      // case RouteList.showItemImage:
      // case RouteList.debt:
      //   return MaterialPageRoute(
      //       builder: TransactionRoutes.getRoutesWithSettings(
      //           settings)[settings.name],
      //       settings: settings);
    }
  }
}
