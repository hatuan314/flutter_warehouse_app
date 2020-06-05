import 'package:flutterwarehouseapp/src/invoice/domain/entities/entities.dart';

class ProductOfInvoiceModel extends ProductOfInvoiceEntity {
  String id;
  String invoiceId;
  String productId;
  String productName;
  String enteredPrice;
  String amount;

  ProductOfInvoiceModel(
      {String id,
      String invoiceId,
      String productId,
      String productName,
      String enteredPrice,
      String amount})
      : super(
            id: id,
            invoiceId: invoiceId,
            productId: productId,
            productName: productName,
            enteredPrice: enteredPrice,
            amount: amount);

  factory ProductOfInvoiceModel.fromJson(Map<String, dynamic> json) =>
      ProductOfInvoiceModel(
          id: json['id'],
          invoiceId: json['invoice_id'],
          productId: json['product_id'],
          enteredPrice: json['entered_price'],
          amount: json['amount']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = int.parse(id);
    json['invoice_id'] = int.parse(invoiceId);
    json['product_id'] = int.parse(productId);
    json['entered_price'] = enteredPrice;
    json['amount'] = amount;
    return json;
  }
}
