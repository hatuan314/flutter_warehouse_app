import 'package:flutterwarehouseapp/models/distributor/represent_color_model.dart';
import 'package:flutterwarehouseapp/utils.dart';

class DistributorModel {
  String name;
  String address;
  String phoneOne;
  String phoneTwo;
  RepresentColorModel representColorModel;

  DistributorModel({this.name, this.address, this.phoneOne, this.phoneTwo, this.representColorModel});

  DistributorModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    phoneOne = json['phone_1'];
    phoneTwo = json['phone_2'];

    String colorKey = json['represent_color'].toString();
    representColorModel = Utils.distributorColors[colorKey];
  }

  Map<String, dynamic> toMap({String colorKey}) {
    Map<String, dynamic> json = <String, dynamic>{};
    json['name'] = name;
    json['address'] = address;
    json['phone_1'] = phoneOne;
    json['phone_2'] = phoneTwo;
    if (colorKey.isEmpty)
      json['represent_color'] = Utils.distributorColors[representColorModel];
    else
      json['represent_color'] = colorKey;
    return json;
  }
}
