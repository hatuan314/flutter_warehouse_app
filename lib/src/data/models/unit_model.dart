import 'package:flutterwarehouseapp/common/utils/date_utils.dart';
import 'package:flutterwarehouseapp/src/domain/entities/unit_entity.dart';

class UnitModel extends UnitEntity {
  UnitModel({
    String id,
    String name,
    DateTime createAt,
    DateTime lastUpdate,
  }) : super(
          id: id,
          name: name,
          createAt: createAt,
          lastUpdate: lastUpdate,
        );

  UnitModel.fromJson(Map<String, dynamic> json, {String id}) {
    this.id = id;
    name = json['name'];
    createAt =
        json['create_at'] != null ? DateTime.parse(json['create_at']) : null;
    lastUpdate = json['last_update'] != null
        ? DateTime.parse(json['last_update'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['create_at'] = DateUtils.formatYyyyMMdd(this.createAt);
    data['last_update'] = DateUtils.formatYyyyMMdd(this.lastUpdate);
    return data;
  }
}
