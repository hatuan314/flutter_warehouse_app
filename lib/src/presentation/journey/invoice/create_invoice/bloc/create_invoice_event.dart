import 'package:flutterwarehouseapp/common/constants/enum_constants.dart';
import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/item_bill_entity.dart';

abstract class CreateInvoiceEvent {}

class InitialCreateInvoiceEvent extends CreateInvoiceEvent {}

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

class OpenGalleryEvent extends CreateInvoiceEvent {}

class OpenCameraEvent extends CreateInvoiceEvent {}

class OnCreateEvent extends CreateInvoiceEvent {
  final String customer;

  OnCreateEvent({this.customer});
}
