import 'package:flutterwarehouseapp/src/invoice/domain/entities/entities.dart';

class InvoiceModel extends InvoiceEntity {
  InvoiceModel(
      {String id, String date, String distributorId, String totalPrice})
      : super(
            id: id,
            date: date,
            distributorId: distributorId,
            totalPrice: totalPrice);

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
        id: json['id'],
        date: json['date'],
        distributorId: json['distributor_id'],
        totalPrice: json['total_price']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = this.id;
    json['date'] = this.date;
    json['distributor_id'] = this.distributorId;
    json['total_price'] = this.totalPrice;
  }
}
