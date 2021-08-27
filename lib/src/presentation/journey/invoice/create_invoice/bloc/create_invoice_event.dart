import 'package:flutterwarehouseapp/common/enums/bill_enum.dart';
import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/item_bill_entity.dart';

abstract class CreateInvoiceEvent {}

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