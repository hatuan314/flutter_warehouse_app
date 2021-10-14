import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/constants/argument_constants.dart';
import 'package:flutterwarehouseapp/common/constants/enum_constants.dart';
import 'package:flutterwarehouseapp/common/constants/layout_constants.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/data/models/distributor_model.dart';
import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/item_bill_entity.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/snackbar_type.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/create_invoice/bloc/create_invoice_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/create_invoice/bloc/create_invoice_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/create_invoice/bloc/create_invoice_state.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/invoice/create_invoice/create_invoice_constants.dart';
import 'package:flutterwarehouseapp/src/widgets/button/button_widget.dart';

import 'create_invoice_form_widget.dart';

class CreateInvoiceBodyWidget extends StatelessWidget {
  final TextEditingController _customerController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateInvoiceBloc, CreateInvoiceState>(listener: (context, state) {
      if (state is CreateInvoiceSuccessState) {
        Navigator.of(context).pop(true);
      }
    }, builder: (context, state) {
      if (state is WaitingCreateInvoiceState) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: LayoutConstants.paddingVerticalApp,
            horizontal: LayoutConstants.paddingHorizontalApp,
          ),
          child: Column(
            children: [
              CreateInvoiceFormWidget(
                customerController: _customerController,
                noteController: _descriptionController,
                enableSelectDistributor: state?.enableSelectDistributor ?? false,
                imageQty: state?.imageQty ?? 0,
                totalAmountBill: state?.totalAmountBill,
                distributorName: state?.distributorName ?? '',
                selectBill: state?.selectBill ?? BillEnum.Export,
                selectBillDate: state?.selectBillDate ?? DateTime.now(),
                itemBillList: ValidatorUtils.isNullEmptyList(state?.itemBillList) ? [] : state?.itemBillList,
                imageFiles: state?.imageFiles ?? [],
                onSelectDistributor: () => _onSelectDistributor(context),
                onSelectBillType: (value) => _onSelectBillType(context, value),
                onPressedGallery: () => _onOpenGallery(context),
                onPressedCamera: () => _onOpenCamera(context),
                onPressedAddItemBtn: () => _onPressedAddItemBtn(context,
                    selectBill: state?.selectBill ?? BillEnum.Export, distributor: state?.distributorName),
                onPressedItemBill: (itemBill, index) => _onPressedItemBill(
                  context,
                  index: index,
                  itemBill: itemBill,
                  selectBill: state?.selectBill ?? BillEnum.Export,
                  distributor: state?.distributorName,
                ),
                onSelectedBillDate: (date) => _onSelectBillDate(context, date),
              ),
              SizedBox(
                height: LayoutConstants.paddingVertical20,
              ),
              ButtonWidget(
                  title: StringConstants.createTxt,
                  onPressed: () {
                    BlocProvider.of<CreateInvoiceBloc>(context).add(OnCreateEvent(
                      customer: _customerController.text.trim(),
                      description: _descriptionController.text.trim(),
                    ));
                  }),
              (Platform.isIOS) ? SizedBox(
                height: LayoutConstants.paddingVerticalAppBottom,
              ) : SizedBox.shrink(),
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

  void _onPressedAddItemBtn(
    BuildContext context, {
    BillEnum selectBill,
    String distributor,
  }) {
    if (selectBill == BillEnum.Export) {
      Navigator.pushNamed(context, RouteList.addItemOfInvoice, arguments: {
        ArgumentConstants.invoiceTypeArg: selectBill,
      }).then((value) {
        if (!ValidatorUtils.isNullEmpty(value)) {
          final ItemBillEntity itemBill = ItemBillEntity.fromJson(jsonDecode(value));
          BlocProvider.of<CreateInvoiceBloc>(context).add(AddItemBillEvent(itemBill));
        }
      });
    } else if (selectBill == BillEnum.Import) {
      if (ValidatorUtils.isNullEmpty(distributor)) {
        locator<SnackbarBloc>()
            .add(ShowSnackbar(title: CreateInvoiceConstants.unselectDistributor, type: SnackBarType.error));
      } else {
        Navigator.pushNamed(context, RouteList.addItemOfInvoice, arguments: {
          ArgumentConstants.distributorArg: distributor,
          ArgumentConstants.invoiceTypeArg: selectBill,
        }).then((value) {
          if (!ValidatorUtils.isNullEmpty(value)) {
            final ItemBillEntity itemBill = ItemBillEntity.fromJson(jsonDecode(value));
            BlocProvider.of<CreateInvoiceBloc>(context).add(AddItemBillEvent(itemBill));
          }
        });
      }
    }
  }

  void _onPressedItemBill(
    BuildContext context, {
    int index,
    BillEnum selectBill,
    String distributor,
    ItemBillEntity itemBill,
  }) {
    if (selectBill == BillEnum.Export) {
      Navigator.pushNamed(context, RouteList.addItemOfInvoice, arguments: {
        ArgumentConstants.invoiceTypeArg: selectBill,
        ArgumentConstants.itemBillArg: jsonEncode(itemBill.toJson()),
      }).then((value) {
        if (!ValidatorUtils.isNullEmpty(value)) {
          final ItemBillEntity itemBill = ItemBillEntity.fromJson(jsonDecode(value));
          BlocProvider.of<CreateInvoiceBloc>(context).add(EditItemBillEvent(
            itemBill: itemBill,
            index: index,
          ));
        }
      });
    } else if (selectBill == BillEnum.Import) {
      if (ValidatorUtils.isNullEmpty(distributor)) {
        locator<SnackbarBloc>()
            .add(ShowSnackbar(title: CreateInvoiceConstants.unselectDistributor, type: SnackBarType.error));
      } else {
        Navigator.pushNamed(context, RouteList.addItemOfInvoice, arguments: {
          ArgumentConstants.distributorArg: distributor,
          ArgumentConstants.invoiceTypeArg: selectBill,
          ArgumentConstants.itemBillArg: jsonEncode(itemBill.toJson()),
        }).then((value) {
          if (!ValidatorUtils.isNullEmpty(value)) {
            final ItemBillEntity itemBill = ItemBillEntity.fromJson(jsonDecode(value));
            BlocProvider.of<CreateInvoiceBloc>(context).add(EditItemBillEvent(
              itemBill: itemBill,
              index: index,
            ));
          }
        });
      }
    }
  }

  void _onSelectBillDate(BuildContext context, DateTime date) {
    BlocProvider.of<CreateInvoiceBloc>(context).add(SelectBillDateEvent(billDate: date));
  }
}
