import 'package:hive/hive.dart';

import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/data/models/bill_model.dart';
import 'package:flutterwarehouseapp/src/data/models/item_bill_model.dart';
import 'package:flutterwarehouseapp/src/domain/entities/item_bill_entity.dart';

part 'bill_entity.g.dart';

@HiveType(typeId: 3)
class BillEntity {
  @HiveField(0)
  String distributorName;
  @HiveField(1)
  String type;
  @HiveField(2)
  // List<ItemBillEntity> products;
  List items;
  @HiveField(3)
  int totalAmount;
  @HiveField(4)
  String locale;
  @HiveField(5)
  int createAt;
  @HiveField(6)
  int lastUpdate;
  @HiveField(7)
  String document;
  @HiveField(8)
  bool isSync;

  BillEntity({
    this.distributorName,
    this.type,
    this.items,
    this.totalAmount,
    this.locale,
    this.document,
    this.createAt,
    this.lastUpdate,
    this.isSync,
  });

  BillModel toModel() {
    return BillModel(
      distributorName: distributorName,
      type: type,
      items: items,
      totalAmount: totalAmount,
      locale: locale,
      createAt: createAt,
      lastUpdate: lastUpdate,
    );
  }
}
