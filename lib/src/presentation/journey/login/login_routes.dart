import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/constants/argument_constants.dart';

import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/confirm_otp/bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/confirm_otp/confirm_otp_screen.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/confirm_phone/confirm_phone_screen.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/splash/blocs/splash_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/splash/blocs/splash_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/login/splash/splash_screen.dart';

import 'confirm_phone/blocs/blocs.dart';

class LoginRoutes {
  static Map<String, WidgetBuilder> getAll() {
    return {
      RouteList.welcome: (context) => BlocProvider(
          create: (_) => locator<SplashBloc>()..add(InitialSplashEvent()),
          child: SplashScreen()),
      RouteList.login: (context) => BlocProvider(
          create: (_) => locator<LoginBloc>(), child: LoginScreen()),
    };
  }

  static Map<String, WidgetBuilder> getRoutesWithSettings(
      RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>;
    return {
      RouteList.confirmOtp: (context) {
        var phone = args[ArgumentConstants.phoneArgument];
        var verificationId = args[ArgumentConstants.verificationIdArgument];
        return BlocProvider(
          create: (_) => locator<ConfirmOtpBloc>()..add(ConfirmOtpInitialEvent()),
          child: ConfirmOtpScreen(
            phone: phone,
            verificationId: verificationId,
          ),
        );
      }
    };
  }
}
