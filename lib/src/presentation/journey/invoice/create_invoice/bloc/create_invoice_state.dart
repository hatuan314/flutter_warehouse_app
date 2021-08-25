import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/enums/bill_enum.dart';
import 'package:flutterwarehouseapp/src/domain/entities/item_bill_entity.dart';

abstract class CreateInvoiceState extends Equatable {}

class WaitingCreateInvoiceState extends CreateInvoiceState {
  final String distributorName;
  final BillEnum selectBill;
  final List<ItemBillEntity> itemBillList;

  WaitingCreateInvoiceState({@required this.distributorName, @required this.selectBill, @required this.itemBillList});

  WaitingCreateInvoiceState copyWith({String distributorName, BillEnum selectBill, List<ItemBillEntity> itemBillList}) => WaitingCreateInvoiceState(
        distributorName: distributorName ?? this.distributorName,
        selectBill: selectBill ?? this.selectBill,
        itemBillList: itemBillList ?? this.itemBillList,
      );

  @override
  List<Object> get props => [this.distributorName, this.selectBill, this.itemBillList];
}
