import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/models/models.dart';
import 'package:flutterwarehouseapp/service/database.dart';

class InvoiceProvider {
  Future<List<InvoiceModel>> selectAllDistributors() async {

    List<InvoiceModel> allInvoices = <InvoiceModel>[];
    try {
      final List<Map<String, dynamic>> maps =
      await db.query('${DatabaseCreator.invoiceTable}', orderBy: 'date ASC');

      allInvoices = List.generate(maps.length, (index) {
        return InvoiceModel.fromJson(maps[index]);
      });
    } catch (e) {
      debugPrint(
          'InvoiceProvider - selectAllDistributors - Error: {${e.toString()}}');
    }
    return allInvoices;
  }
}