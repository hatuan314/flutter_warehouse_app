import 'package:flutterwarehouseapp/src/invoice/data/data.dart';
import 'package:flutterwarehouseapp/src/invoice/domain/domain.dart';

class InvoiceRepositoryImpl implements InvoiceRepository {
  InvoiceProvider _invoiceProvider = InvoiceProvider();

  @override
  Future addNewInvoice(InvoiceModel invoiceModel) {
    // TODO: implement addNewInvoice
    throw UnimplementedError();
  }

  @override
  Future<List<InvoiceModel>> getAllInvoices() async =>
      await _invoiceProvider.selectAllInvoices();
}
