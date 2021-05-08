import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/constants/argument_constants.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/profile/update_information/blocs/update_info_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/profile/update_information/update_information_screen.dart';

class ProfileRoute {
  static Map<String, WidgetBuilder> getAll() {
    return {
      // RouteList.updateProfile: (context) => UpdateInformationScreen(),
    };
  }

  static Map<String, WidgetBuilder> getRoutesWithSettings(
      RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>;
    return {
      RouteList.updateProfile: (context) {
        var fireUser = args[ArgumentConstants.fireUserArgument];
        return BlocProvider(
          create: (_) => locator<UpdateInfoBloc>(),
          child: UpdateInformationScreen(
            fireUser: fireUser,
          ),
        );
      }
      // RouteList.confirmOtp: (context) {
      //   var phone = args[ArgumentConstants.phoneArgument];
      //   var verificationId = args[ArgumentConstants.verificationIdArgument];
      //   return BlocProvider(
      //     create: (_) => locator<ConfirmOtpBloc>()..add(ConfirmOtpInitialEvent()),
      //     child: ConfirmOtpScreen(
      //       phone: phone,
      //       verificationId: verificationId,
      //     ),
      //   );
      // }
    };
  }
}
