import 'package:flutterwarehouseapp/src/distributor/domain/entities/distributor_entity.dart';

class DistributorModel extends DistributorEntity {

  DistributorModel({
    String name,
    String address,
    String phoneOne,
    String phoneTwo,
    String colorKey
}) : super(
    name: name,
    address: address,
    phoneOne: phoneOne,
    phoneTwo: phoneTwo,
    colorKey: colorKey
  );

  factory DistributorModel.fromJson(Map<String, dynamic> json) => DistributorModel(
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
