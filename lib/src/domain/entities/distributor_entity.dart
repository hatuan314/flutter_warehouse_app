import 'package:flutterwarehouseapp/src/data/models/distributor_model.dart';
import 'package:hive/hive.dart';

part 'distributor_entity.g.dart';

@HiveType(typeId: 1)
class DistributorEntity {
  @HiveField(0)
  String name;
  @HiveField(1)
  List<String> phones;
  @HiveField(2)
  List<String> emails;
  @HiveField(3)
  int color;
  @HiveField(4)
  DateTime createAt;
  @HiveField(5)
  DateTime lastUpdate;
  @HiveField(6)
  String document;

  DistributorEntity({
    this.name,
    this.phones,
    this.emails,
    this.color,
    this.createAt,
    this.lastUpdate,
    this.document,
  });

  DistributorModel toModel() {
    return DistributorModel(
      name: name,
      phones: phones,
      emails: emails,
      color: color,
      createAt: createAt,
      lastUpdate: lastUpdate,
    );
  }
}
