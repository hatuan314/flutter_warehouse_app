import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/enum_constants.dart';
import 'package:flutterwarehouseapp/src/domain/entities/image_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/item_bill_entity.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';
import 'package:image_picker/image_picker.dart';

abstract class CreateInvoiceState extends Equatable {}

class WaitingCreateInvoiceState extends CreateInvoiceState {
  final ViewState viewState;
  final bool enableSelectDistributor;
  final int totalAmountBill;
  final int imageQty;
  final String distributorName;
  final BillEnum selectBill;
  final DateTime selectBillDate;
  final List<ItemBillEntity> itemBillList;
  final List<PickedFile> imageFiles;
  final List<ImageEntity> imageNetworkList;

  WaitingCreateInvoiceState({
    @required this.viewState,
    @required this.enableSelectDistributor,
    @required this.totalAmountBill,
    @required this.distributorName,
    @required this.selectBill,
    @required this.selectBillDate,
    @required this.itemBillList,
    @required this.imageFiles,
    @required this.imageQty,
    @required this.imageNetworkList,
  });

  WaitingCreateInvoiceState copyWith({
    ViewState viewState,
    bool enableSelectDistributor,
    int totalAmountBill,
    int imageQty,
    String distributorName,
    BillEnum selectBill,
    DateTime selectBillDate,
    List<ItemBillEntity> itemBillList,
    List<PickedFile> imageFiles,
    List<ImageEntity> imageNetworkList,
  }) =>
      WaitingCreateInvoiceState(
        enableSelectDistributor: enableSelectDistributor ?? this.enableSelectDistributor,
        distributorName: distributorName ?? this.distributorName,
        totalAmountBill: totalAmountBill ?? this.totalAmountBill,
        selectBill: selectBill ?? this.selectBill,
        selectBillDate: selectBillDate ?? this.selectBillDate,
        itemBillList: itemBillList ?? this.itemBillList,
        viewState: viewState ?? this.viewState,
        imageFiles: imageFiles ?? this.imageFiles,
        imageQty: imageQty ?? this.imageQty,
        imageNetworkList: imageNetworkList ?? this.imageNetworkList,
      );

  @override
  List<Object> get props => [
        this.viewState,
        this.enableSelectDistributor,
        this.totalAmountBill,
        this.distributorName,
        this.selectBill,
        this.itemBillList,
        this.imageFiles,
        this.imageQty,
        this.selectBillDate,
      ];
}

class CreateInvoiceSuccessState extends CreateInvoiceState {
  final BillEnum billType;

  CreateInvoiceSuccessState({@required this.billType});

  @override
  List<Object> get props => [this.billType];
}
