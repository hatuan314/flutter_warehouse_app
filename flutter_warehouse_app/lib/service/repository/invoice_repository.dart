import 'package:flutterwarehouseapp/models/invoice/invoice_model.dart';
import 'package:flutterwarehouseapp/service/provider/invoice_provider.dart';

class InvoiceRepository {
  InvoiceProvider _invoiceProvider = InvoiceProvider();

  Future<List<InvoiceModel>> getAllInvoicesRepository() =>
      _invoiceProvider.selectAllDistributors();
}
