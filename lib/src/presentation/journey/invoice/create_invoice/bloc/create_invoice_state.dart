import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/enums/bill_enum.dart';
import 'package:flutterwarehouseapp/src/domain/entities/item_bill_entity.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';
import 'package:image_picker/image_picker.dart';

abstract class CreateInvoiceState extends Equatable {}

class WaitingCreateInvoiceState extends CreateInvoiceState {
  final ViewState viewState;
  final int totalAmountBill;
  final int imageQty;
  final String distributorName;
  final BillEnum selectBill;
  final List<ItemBillEntity> itemBillList;
  final List<PickedFile> imageFiles;

  WaitingCreateInvoiceState({
    @required this.viewState,
    @required this.totalAmountBill,
    @required this.distributorName,
    @required this.selectBill,
    @required this.itemBillList,
    @required this.imageFiles,
    @required this.imageQty,
  });

  WaitingCreateInvoiceState copyWith({
    ViewState viewState,
    int totalAmountBill,
    int imageQty,
    String distributorName,
    BillEnum selectBill,
    List<ItemBillEntity> itemBillList,
    List<PickedFile> imageFiles,
  }) =>
      WaitingCreateInvoiceState(
        distributorName: distributorName ?? this.distributorName,
        totalAmountBill: totalAmountBill ?? this.totalAmountBill,
        selectBill: selectBill ?? this.selectBill,
        itemBillList: itemBillList ?? this.itemBillList,
        viewState: viewState ?? this.viewState,
        imageFiles: imageFiles ?? this.imageFiles,
        imageQty: imageQty ?? this.imageQty,
      );

  @override
  List<Object> get props => [
        this.viewState,
        this.totalAmountBill,
        this.distributorName,
        this.selectBill,
        this.itemBillList,
        this.imageFiles,
        this.imageQty,
      ];
}

class CreateInvoiceSuccessState extends CreateInvoiceState {
  @override
  List<Object> get props => [];
}
