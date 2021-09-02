import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/constants/argument_constants.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/common/enums/bill_enum.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/data/models/distributor_model.dart';
import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/create_invoice/bloc/create_invoice_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/create_invoice/bloc/create_invoice_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/create_invoice/bloc/create_invoice_state.dart';
import 'package:flutterwarehouseapp/src/widgets/button/button_widget.dart';

import 'create_invoice_form_widget.dart';

class CreateInvoiceBodyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateInvoiceBloc, CreateInvoiceState>(
        listener: (context, state) {
          if (state is CreateInvoiceSuccessState) {
            Navigator.of(context).pop(true);
          }
        },
        builder: (context, state) {
          if (state is WaitingCreateInvoiceState) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                vertical: LayoutConstants.paddingVerticalApp,
                horizontal: LayoutConstants.paddingHorizontalApp,
              ),
              child: Column(
                children: [
                  CreateInvoiceFormWidget(
                    imageQty: state?.imageQty ?? 0,
                    totalAmountBill: state?.totalAmountBill,
                    distributorName: state?.distributorName ?? '',
                    selectBill: state?.selectBill ?? BillEnum.Export,
                    itemBillList: ValidatorUtils.isNullEmptyList(state?.itemBillList) ? [] : state?.itemBillList,
                    imageFiles: state?.imageFiles ?? [],
                    onSelectDistributor: () => _onSelectDistributor(context),
                    onSelectBillType: (value) => _onSelectBillType(context, value),
                    onPressedGallery: () => _onOpenGallery(context),
                    onPressedCamera: () => _onOpenCamera(context),
                  ),
                  SizedBox(
                    height: LayoutConstants.paddingVertical20,
                  ),
                  ButtonWidget(
                      title: StringConstants.createTxt,
                      onPressed: () {
                        BlocProvider.of<CreateInvoiceBloc>(context).add(OnCreateEvent());
                      })
                ],
              ),
            );
          }
          return SizedBox();
        });
  }

  void _onSelectDistributor(BuildContext context) {
    Navigator.pushNamed(context, RouteList.distributorList,
        arguments: {ArgumentConstants.currentRouteArg: RouteList.createInvoice}).then((distributorJson) {
          DistributorEntity distributor = DistributorModel.fromJson(jsonDecode(distributorJson));
          BlocProvider.of<CreateInvoiceBloc>(context).add(SelectDistributorEvent(distributor));
    });
  }

  void _onSelectBillType(BuildContext context, BillEnum bill) {
    BlocProvider.of<CreateInvoiceBloc>(context).add(SelectBillTypeEvent(bill));
  }

  void _onOpenGallery(BuildContext context) {
    BlocProvider.of<CreateInvoiceBloc>(context).add(OpenGalleryEvent());
  }

  void _onOpenCamera(BuildContext context) {
    BlocProvider.of<CreateInvoiceBloc>(context).add(OpenCameraEvent());
  }
}
