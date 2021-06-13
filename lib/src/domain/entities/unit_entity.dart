import 'package:flutterwarehouseapp/src/data/models/unit_model.dart';
import 'package:hive/hive.dart';

part 'unit_entity.g.dart';

@HiveType(typeId: 0)
class UnitEntity {
  String id;
  String name;
  DateTime createAt;
  DateTime lastUpdate;

  UnitEntity({this.name, this.createAt, this.lastUpdate, this.id});

  UnitModel toModel() => UnitModel(
        name: name,
        createAt: createAt,
        lastUpdate: lastUpdate,
      );
}
