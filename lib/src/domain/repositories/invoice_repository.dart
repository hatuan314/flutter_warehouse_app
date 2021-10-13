import 'package:flutterwarehouseapp/src/domain/entities/bill_entity.dart';

abstract class InvoiceRepository {
  Future<List<BillEntity>> getBillListCloud();

  Future<List<BillEntity>> getBillListLocal();

  Future<List<BillEntity>> getExportBillList();

  Future<List<BillEntity>> getImportBillList();

  Future<bool> setBill(BillEntity bill);

  Future<String> setBillCloud(BillEntity distributor);

  Future<bool> setBillLocalList(List<BillEntity> billList);

  Future<void> remove({int index, String document});

  Future<void> update({int index, BillEntity distributor});
}