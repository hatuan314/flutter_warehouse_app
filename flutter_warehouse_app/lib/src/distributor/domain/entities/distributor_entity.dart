class DistributorEntity {
  String name;
  String address;
  String phoneOne;
  String phoneTwo;
  String colorKey;

  DistributorEntity(
      {this.name, this.address, this.phoneOne, this.phoneTwo, this.colorKey});

  factory DistributorEntity.fromJson(Map<String, dynamic> json) => DistributorEntity(
    name: json['name'],
    address: json['address'],
    phoneOne: json['phone_1'],
    phoneTwo: json['phone_2'],
    colorKey: json['represent_color'].toString()
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['name'] = name;
    json['address'] = address;
    json['phone_1'] = phoneOne;
    json['phone_2'] = phoneTwo;
    json['represent_color'] = colorKey;
    return json;
  }
}