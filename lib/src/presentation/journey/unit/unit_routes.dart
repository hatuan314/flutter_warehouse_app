import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/splash/blocs/splash_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/splash/blocs/splash_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/unit/unit_list/bloc/unit_list_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/unit/unit_list/bloc/unit_list_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/unit/unit_list/unit_list_screen.dart';

class UnitRoutes {
  static Map<String, WidgetBuilder> getAll() {
    return {
      RouteList.unitList: (context) => BlocProvider<UnitListBloc>(
          // create: (_) => locator<UnitListBloc>()..add(InitialUnitListEvent()),
          create: (_) => locator<UnitListBloc>(),
          child: UnitListScreen()),
      // RouteList.login: (context) => BlocProvider(
      //     create: (_) => locator<LoginBloc>(), child: LoginScreen()),
    };
  }

  // static Map<String, WidgetBuilder> getRoutesWithSettings(
  //     RouteSettings settings) {
  //   final args = settings.arguments as Map<String, dynamic>;
  //   return {
  //     RouteList.confirmOtp: (context) {
  //       var phone = args[ArgumentConstants.phoneArgument];
  //       var verificationId = args[ArgumentConstants.verificationIdArgument];
  //       return BlocProvider(
  //         create: (_) => locator<ConfirmOtpBloc>()..add(ConfirmOtpInitialEvent()),
  //         child: ConfirmOtpScreen(
  //           phone: phone,
  //           verificationId: verificationId,
  //         ),
  //       );
  //     }
  //   };
  // }
}
