class Product {
  String id;
  String name;
  String categoryId;
  String wholesale;
  String retail;
  String count;
  String barcode;
  String distributorId;
  String distributorName;
  String representColor;

  Product(
      {this.id,
      this.name,
      this.categoryId,
      this.wholesale,
      this.retail,
        this.count,
        this.barcode,
      this.distributorId,
      this.distributorName,
        this.representColor,
      });

  Product.fromJson(Map<String, dynamic> json) {
    this.id = json['id'].toString();
    this.name = json['name'];
    this.categoryId = json['category_id'].toString();
    this.wholesale = json['wholesale'].toString();
    this.retail = json['retail'].toString();
    this.count = json['count'].toString();
    this.barcode = json['bar_code'].toString();
    this.distributorId = json['distributor_id'].toString();
    this.distributorName = json['distributor_name'].toString();
    this.representColor = json['represent_color'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category_id'] = this.categoryId;
    data['wholesale'] = this.wholesale;
    data['retail'] = this.retail;
    data['count'] = this.count;
    data['bar_code'] = this.barcode;
    data['distributor_id'] = this.distributorId;
    data['distributor_name'] = this.distributorName;
    data['represent_color'] = this.representColor;
    return data;
  }
}
