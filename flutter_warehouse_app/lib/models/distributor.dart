class Distributor {
  String id;
  String name;
  String address;
  String phone1;
  String phone2;
  String representColor;

  Distributor(
      {this.id,
      this.name,
      this.address,
      this.phone1,
      this.phone2,
      this.representColor});

  Distributor.fromJson(Map<String, dynamic> json) {
    this.id = json['id'].toString();
    this.name = json['name'];
    this.address = json['address'];
    this.phone1 = json['phone_1'];
    this.phone2 = json['phone_2'];
    this.representColor = json['represent_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone_1'] = this.phone1;
    data['phone_2'] = this.phone2;
    data['represent_color'] = this.representColor;

    return data;
  }
}
