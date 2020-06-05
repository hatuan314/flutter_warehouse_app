import 'package:flutterwarehouseapp/src/invoice/data/models/models.dart';

abstract class InvoiceRepository {
  Future<List<InvoiceModel>> getAllInvoices();
  Future addNewInvoice(InvoiceModel invoiceModel);
}