import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/enums/bill_enum.dart';

abstract class CreateInvoiceState extends Equatable {}

class WaitingCreateInvoiceState extends CreateInvoiceState {
  final String distributorName;
  final BillEnum selectBill;

  WaitingCreateInvoiceState({@required this.distributorName, @required this.selectBill});

  WaitingCreateInvoiceState copyWith({String distributorName, BillEnum selectBill}) => WaitingCreateInvoiceState(
        distributorName: distributorName ?? this.distributorName,
        selectBill: selectBill ?? this.selectBill,
      );

  @override
  List<Object> get props => [this.distributorName, this.selectBill];
}
