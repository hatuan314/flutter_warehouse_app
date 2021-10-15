import 'package:flutterwarehouseapp/common/constants/enum_constants.dart';

abstract class InvoicePageEvent {}

class InitialInvoiceEvent extends InvoicePageEvent {}

class RefreshInvoiceListEvent extends InvoicePageEvent {
  final BillEnum billType;

  RefreshInvoiceListEvent(this.billType);
}