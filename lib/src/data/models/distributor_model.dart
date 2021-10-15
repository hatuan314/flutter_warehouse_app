import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/data/models/model_field_constants.dart';
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
    name = json[ModelFieldConstants.distributor_name] as String;
    phones = ValidatorUtils.isNullEmpty(json['phones']) ? [] : json['phones'].cast<String>();
    emails = ValidatorUtils.isNullEmpty(json['emails']) ? [] : json['emails'].cast<String>();
    color = json['color'];
    createAt =
        json[ModelFieldConstants.create_at] != null ? DateTime.fromMillisecondsSinceEpoch(json[ModelFieldConstants.create_at]) : null;
    lastUpdate =
        json[ModelFieldConstants.last_update] != null ? DateTime.fromMillisecondsSinceEpoch(json[ModelFieldConstants.last_update]) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[ModelFieldConstants.distributor_name] = this.name;
    data['phones'] = this.phones;
    data['emails'] = this.emails;
    data['color'] = this.color;
    data[ModelFieldConstants.create_at] = this.createAt.millisecondsSinceEpoch;
    data[ModelFieldConstants.last_update] = this.lastUpdate.millisecondsSinceEpoch;
    return data;
  }
}
