import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';

class InvoiceRoutes {
  static Map<String, WidgetBuilder> getAll() {
    return {
      // RouteList.distributorList: (context) => BlocProvider(
      //     create: (_) => locator<DistributorListBloc>()
      //       ..add(InitialDistributorListEvent()),
      //     child: DistributorListScreen()),
      // RouteList.addDistributor: (context) => BlocProvider(
      //     create: (_) => locator<AddDistributorBloc>(),
      //     child: AddDistributorScreen()),
    };
  }

  static Map<String, WidgetBuilder> getRoutesWithSettings(
      RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>;
    return {
      // RouteList.distributorDetail: (context) {
      //   var distributorJson = args[ArgumentConstants.distributorDetailArg];
      //   var index = args[ArgumentConstants.distributorIndexArg];
      //   return BlocProvider<DistributorDetailBloc>(
      //     create: (_) => locator<DistributorDetailBloc>()
      //       ..add(
      //         InitialDistributorDetailEvent(distributorJson: distributorJson, index: index),
      //       ),
      //     child: DistributorDetailScreen(
      //     ),
      //   );
      // }
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