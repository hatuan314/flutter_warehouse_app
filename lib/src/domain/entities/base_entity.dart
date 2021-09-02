import 'package:hive/hive.dart';

part 'base_entity.g.dart';

@HiveType(typeId: 5)
class BaseEntity {
  @HiveField(0)
  String document;
  @HiveField(1)
  bool isSync;

  BaseEntity({this.document, this.isSync});

}