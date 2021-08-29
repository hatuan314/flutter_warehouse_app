import 'package:hive/hive.dart';
import 'package:flutterwarehouseapp/src/domain/entities/item_bill_entity.dart';

part 'bill_entity.g.dart';

@HiveType(typeId: 3)
class BillEntity {
  @HiveField(0)
  String distributorName;
  @HiveField(1)
  String type;
  @HiveField(2)
  List<ItemBillEntity> products;
  @HiveField(3)
  int totalAmount;
  @HiveField(4)
  int locale;
  @HiveField(5)
  int createAt;
  @HiveField(6)
  int lastUpdate;
}