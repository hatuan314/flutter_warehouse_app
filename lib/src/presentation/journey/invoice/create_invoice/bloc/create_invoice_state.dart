import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/enums/bill_enum.dart';
import 'package:flutterwarehouseapp/src/domain/entities/item_bill_entity.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/loader_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';

abstract class CreateInvoiceState extends Equatable {}

class WaitingCreateInvoiceState extends CreateInvoiceState {
  final ViewState viewState;
  final int totalAmountBill;
  final String distributorName;
  final BillEnum selectBill;
  final List<ItemBillEntity> itemBillList;

  WaitingCreateInvoiceState(
      {@required this.viewState,
      @required this.totalAmountBill,
      @required this.distributorName,
      @required this.selectBill,
      @required this.itemBillList});

  WaitingCreateInvoiceState copyWith(
          {ViewState viewState,
          int totalAmountBill,
          String distributorName,
          BillEnum selectBill,
          List<ItemBillEntity> itemBillList}) =>
      WaitingCreateInvoiceState(
        distributorName: distributorName ?? this.distributorName,
        totalAmountBill: totalAmountBill ?? this.totalAmountBill,
        selectBill: selectBill ?? this.selectBill,
        itemBillList: itemBillList ?? this.itemBillList,
        viewState: viewState ?? this.viewState,
      );

  @override
  List<Object> get props =>
      [this.viewState, this.totalAmountBill, this.distributorName, this.selectBill, this.itemBillList];
}
