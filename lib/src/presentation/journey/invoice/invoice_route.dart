import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/constants/argument_constants.dart';
import 'package:flutterwarehouseapp/common/constants/enum_constants.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/domain/entities/item_bill_entity.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/add_item_of_invoice/add_ioi_screen.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/add_item_of_invoice/bloc/add_ioi_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/add_item_of_invoice/bloc/add_ioi_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/create_invoice/bloc/create_invoice_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/create_invoice/create_invoice_screen.dart';

class InvoiceRoutes {
  static Map<String, WidgetBuilder> getAll() {
    return {
      RouteList.createInvoice: (context) =>
          BlocProvider(create: (_) => locator<CreateInvoiceBloc>(), child: CreateInvoiceScreen()),
      // RouteList.distributorList: (context) => BlocProvider(
      //     create: (_) => locator<DistributorListBloc>()
      //       ..add(InitialDistributorListEvent()),
      //     child: DistributorListScreen()),
      // RouteList.addDistributor: (context) => BlocProvider(
      //     create: (_) => locator<AddDistributorBloc>(),
      //     child: AddDistributorScreen()),
    };
  }

  static Map<String, WidgetBuilder> getRoutesWithSettings(RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>;
    return {
      RouteList.addItemOfInvoice: (context) {
        var distributor;
        var billType;
        var itemBill;
        if (ValidatorUtils.isNullEmpty(args)) {
          distributor = '';
          billType = BillEnum.Export;
          itemBill = null;
        } else {
          distributor = args[ArgumentConstants.distributorArg] ?? '';
          billType = args[ArgumentConstants.invoiceTypeArg] ?? BillEnum.Export;
          if (!ValidatorUtils.isNullEmpty(args[ArgumentConstants.itemBillArg])) {
            var json = jsonDecode(args[ArgumentConstants.itemBillArg]);
            itemBill = ItemBillEntity.fromJson(json);
          }
        }
        return BlocProvider(
            create: (_) => locator<AddIoiBloc>()
              ..add(InitialAddIoiEvent(
                distributor: distributor,
                itemBill: itemBill,
              )),
            child: AddIoiScreen(
              billType: billType,
              itemBill: itemBill,
            ));
      },
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
