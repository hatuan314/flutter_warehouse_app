import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/dev_mode_screen.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/login_routes.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/main/bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/main/main_screen.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/profile/profile_routes.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/unit/unit_routes.dart';

class Routes {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  factory Routes() => _instance;

  Routes._internal();

  static final Routes _instance = Routes._internal();

  static Routes get instance => _instance;

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) async {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateAndRemove(String routeName,
      {dynamic arguments}) async {
    return navigatorKey.currentState.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  Future<dynamic> navigateAndReplace(String routeName,
      {dynamic arguments}) async {
    return navigatorKey.currentState
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  dynamic pop({dynamic result}) {
    return navigatorKey.currentState.pop(result);
  }

  static Map<String, WidgetBuilder> _getCombinedRoutes() => {
        ...LoginRoutes.getAll(),
        ...ProfileRoute.getAll(),
        ...UnitRoutes.getAll()
      };

  static Map<String, WidgetBuilder> getAll() => _getCombinedRoutes();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteList.confirmOtp:
        return MaterialPageRoute(
            builder: LoginRoutes.getRoutesWithSettings(settings)[settings.name],
            settings: settings);
      case RouteList.updateProfile:
        return MaterialPageRoute(
            builder:
                ProfileRoute.getRoutesWithSettings(settings)[settings.name],
            settings: settings);
      case RouteList.main:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (_) => locator<MainBloc>(), child: MainScreen()));
      case RouteList.devMode:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (_) => locator<MainBloc>(), child: DevModeScreen()));
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
