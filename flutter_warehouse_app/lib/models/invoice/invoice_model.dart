import 'package:flutterwarehouseapp/models/invoice/product_of_invoice_model.dart';

class InvoiceModel {
  String id;
  String date;
  String distributorId;
  String totalPrice;

  InvoiceModel({this.id, this.date, this.distributorId, this.totalPrice});

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
        id: json['id'],
        date: json['date'],
        distributorId: json['distributor_id'],
        totalPrice: json['total_pricec']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = this.id;
    json['date'] = this.date;
    json['distributor_id'] = this.distributorId;
    json['total_pricec'] = this.totalPrice;
  }
}
