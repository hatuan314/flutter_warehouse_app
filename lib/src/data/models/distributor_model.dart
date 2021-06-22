import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';

class DistributorModel extends DistributorEntity {
  DistributorModel({
    String name,
    List<String> phones,
    List<String> emails,
    int color,
    DateTime createAt,
    DateTime lastUpdate,
  }) : super(
          name: name,
          phones: phones,
          emails: emails,
          color: color,
          createAt: createAt,
          lastUpdate: lastUpdate,
        );

  DistributorModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phones = json['phones'].cast<String>();
    emails = json['emails'].cast<String>();
    color = json['color'];
    createAt =
        json['create_at'] != null ? DateTime.parse(json['create_at']) : null;
    lastUpdate = json['last_update'] != null
        ? DateTime.parse(json['last_update'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phones'] = this.phones;
    data['emails'] = this.emails;
    data['color'] = this.color;
    data['create_at'] = this.createAt.millisecondsSinceEpoch;
    data['last_update'] = this.lastUpdate.millisecondsSinceEpoch;
    return data;
  }
}
