import 'package:flutterwarehouseapp/src/domain/entities/unit_entity.dart';

abstract class UnitRepository {
  Future<List<UnitEntity>> getUnitCloudList();

  Future<List<UnitEntity>> getUnitLocalList();

  Future<void> setDefaultUnitList();

  Future<void> synchronizedUnitLocalList();

  void synchronizedUnitCloudList(List<UnitEntity> units);
}
