import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/constants/argument_constants.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/add_distributor/add_distributor_screen.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/add_distributor/bloc/add_distributor_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_detail/bloc/distributor_detail_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_detail/bloc/distributor_detail_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_detail/distributor_detail_screen.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_list/bloc/distributor_list_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_list/bloc/distributor_list_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_list/distributor_list_screen.dart';

class DistributorRoute {
  static Map<String, WidgetBuilder> getAll() {
    return {
      RouteList.distributorList: (context) => BlocProvider(
          create: (_) => locator<DistributorListBloc>()
            ..add(InitialDistributorListEvent()),
          child: DistributorListScreen()),
      RouteList.addDistributor: (context) => BlocProvider(
          create: (_) => locator<AddDistributorBloc>(),
          child: AddDistributorScreen()),
    };
  }

  static Map<String, WidgetBuilder> getRoutesWithSettings(
      RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>;
    return {
      RouteList.distributorDetail: (context) {
        var distributorJson = args[ArgumentConstants.distributorDetailArg];
        var index = args[ArgumentConstants.distributorIndexArg];
        return BlocProvider<DistributorDetailBloc>(
          create: (_) => locator<DistributorDetailBloc>()
            ..add(
              InitialDistributorDetailEvent(distributorJson: distributorJson, index: index),
            ),
          child: DistributorDetailScreen(
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
