import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/profile/create_information/create_information_screen.dart';

class ProfileRoute {
  static Map<String, WidgetBuilder> getAll() {
    return {
      RouteList.updateProfile: (context) => CreateInformationScreen(),
    };
  }

  static Map<String, WidgetBuilder> getRoutesWithSettings(
      RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>;
    return {
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
