class ProductOfInvoiceEntity {
  String id;
  String invoiceId;
  String productId;
  String productName;
  String enteredPrice;
  String amount;

  ProductOfInvoiceEntity(
      {this.id,
      this.invoiceId,
      this.productId,
      this.productName,
      this.enteredPrice,
      this.amount});

  factory ProductOfInvoiceEntity.fromJson(Map<String, dynamic> json) =>
      ProductOfInvoiceEntity(
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
