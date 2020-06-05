class InvoiceEntity {
  String id;
  String date;
  String distributorId;
  String totalPrice;

  InvoiceEntity({this.id, this.date, this.distributorId, this.totalPrice});

  factory InvoiceEntity.fromJson(Map<String, dynamic> json) {
    return InvoiceEntity(
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