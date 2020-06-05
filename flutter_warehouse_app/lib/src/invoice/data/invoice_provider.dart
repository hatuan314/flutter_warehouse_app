import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/data/database.dart';
import 'package:flutterwarehouseapp/src/invoice/data/models/models.dart';

class InvoiceProvider {
  Future<List<InvoiceModel>> selectAllInvoices() async {
    List<InvoiceModel> allInvoices = <InvoiceModel>[];
    try {
      final List<Map<String, dynamic>> maps = await db
          .query('${DatabaseCreator.invoiceTable}', orderBy: 'date ASC');

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
