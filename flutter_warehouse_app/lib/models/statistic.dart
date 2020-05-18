class Statistic {
  String id;
  String date;
  String productName;
  String amount;

  Statistic({this.id, this.date, this.productName, this.amount});

  Statistic.fromJson(Map<String, dynamic> json) {
    this.id = json['id'].toString();
    this.date = json['date'].toString();
    this.productName = json['product_name'].toString();
    this.amount = json['amount'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['product_name'] = this.productName;
    data['amount'] = this.amount;
    return data;
  }
}