import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/enum_constants.dart';
import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/item_bill_entity.dart';

abstract class CreateInvoiceEvent {}

class InitialCreateInvoiceEvent extends CreateInvoiceEvent {
  final String billJson;
  final bool isEdit;
  final int index;

  InitialCreateInvoiceEvent({
    @required this.billJson,
    this.isEdit = false,
    this.index,
  });
}

class SelectDistributorEvent extends CreateInvoiceEvent {
  final DistributorEntity distributor;

  SelectDistributorEvent(this.distributor);
}

class SelectBillTypeEvent extends CreateInvoiceEvent {
  final BillEnum bill;

  SelectBillTypeEvent(this.bill);
}

class AddItemBillEvent extends CreateInvoiceEvent {
  final ItemBillEntity itemBill;

  AddItemBillEvent(this.itemBill);
}

class EditItemBillEvent extends CreateInvoiceEvent {
  final ItemBillEntity itemBill;
  final int index;

  EditItemBillEvent({this.itemBill, this.index});
}

class OpenGalleryEvent extends CreateInvoiceEvent {}

class OpenCameraEvent extends CreateInvoiceEvent {}

class OnCreateEvent extends CreateInvoiceEvent {
  final String customer;
  final String description;

  OnCreateEvent({this.customer, this.description});
}

class SelectBillDateEvent extends CreateInvoiceEvent {
  final DateTime billDate;

  SelectBillDateEvent({@required this.billDate});
}
