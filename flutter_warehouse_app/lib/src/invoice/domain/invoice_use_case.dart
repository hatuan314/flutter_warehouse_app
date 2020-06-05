import 'package:flutterwarehouseapp/src/invoice/data/invoice_repository_impl.dart';
import 'package:flutterwarehouseapp/src/invoice/data/models/models.dart';
import 'package:flutterwarehouseapp/src/invoice/domain/entities/entities.dart';

class InvoicesUserCase {
  InvoiceRepositoryImpl _repositoryImpl = InvoiceRepositoryImpl();

  Future<List<InvoiceEntity>> getAllInvoiceUserCase() async {
    List<InvoiceEntity> invoiceEntities = <InvoiceEntity>[];
    List<InvoiceModel> invoiceModels =
        await _repositoryImpl.getAllInvoices();
    invoiceModels.forEach((invoiceModel) =>
        invoiceEntities.add(InvoiceEntity.fromJson(invoiceModel.toJson())));
    return invoiceEntities;
  }
}
