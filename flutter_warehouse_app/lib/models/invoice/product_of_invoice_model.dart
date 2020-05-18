import 'package:flutter/cupertino.dart';

class ProductOfInvoiceModel {
  String id;
  String invoiceId;
  String productId;
  String enteredPrice;
  String amount;

  ProductOfInvoiceModel(
      {this.id, this.invoiceId, this.productId, this.enteredPrice, this.amount});
  factory ProductOfInvoiceModel.fromJson(Map<String, dynamic> json) {
    try {
      return ProductOfInvoiceModel(
        id: json['id'],
        invoiceId: json['invoice_id'],
        productId: json['product_id'],
        enteredPrice: json['entered_price'],
        amount: json['amount']
      );
    } catch (e) {
      debugPrint('ProductOfInvoiceModel.fromJson: {${e.toString()}}');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic> {};
    json['id'] = int.parse(id);
    json['invoice_id'] = int.parse(invoiceId);
    json['product_id'] = int.parse(productId);
    json['entered_price'] = enteredPrice;
    json['amount'] = amount;

  }
}