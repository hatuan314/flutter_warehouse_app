class DistributorModel {
  String name;
  String address;
  String phoneOne;
  String phoneTwo;

  DistributorModel({this.name, this.address, this.phoneOne, this.phoneTwo});

  DistributorModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    phoneOne = json['phone_1'];
    phoneTwo = json['phone_2'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> json = <String, dynamic>{};
    json['name'] = name;
    json['address'] = address;
    json['phone_1'] = phoneOne;
    json['phone_2'] = phoneTwo;
    return json;
  }
}
