class Invoice {
  String id;
  String date;
  String productId;
  String count;
  String productName;
  String barcode;
  String distributorId;
  String distributorName;
  String wholesale;
  String wholesaleTotal;
  String paid;
  String representColor;

  Invoice(
      {this.id,
      this.date,
      this.productId,
      this.count,
      this.productName,
      this.barcode,
      this.distributorId,
      this.distributorName,
      this.wholesale,
        this.wholesaleTotal,
      this.representColor,
      this.paid});

  Invoice.fromJson(Map<String, dynamic> json) {
    this.id = json['id'].toString();
    this.date = json['date'].toString();
    this.productId = json['product_id'].toString();
    this.count = json['count'].toString();
    this.productName = json['product_name'];
    this.barcode = json['bar_code'].toString();
    this.distributorId = json['distributor_id'].toString();
    this.distributorName = json['distributor_name'].toString();
    this.wholesale = json['wholesale'].toString();
    this.paid = json['paid'].toString();
    this.wholesaleTotal = json['wholesale_total'].toString();
    this.representColor = json['represent_color'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['product_id'] = this.productId;
    data['count'] = this.count;
    data['product_name'] = this.productName;
    data['bar_code'] = this.barcode;
    data['distributor_id'] = this.distributorId;
    data['distributor_name'] = this.distributorName;
    data['wholesale'] = this.wholesale;
    data['paid'] = this.paid;
    data['wholesale_total'] = this.wholesaleTotal;
    data['represent_color'] = this.representColor;

    return data;
  }
}
