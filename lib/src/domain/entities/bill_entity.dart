import 'dart:convert';

import 'package:flutterwarehouseapp/src/domain/entities/hive_entity.dart';
import 'package:hive/hive.dart';

import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/data/models/bill_model.dart';
import 'package:flutterwarehouseapp/src/data/models/item_bill_model.dart';
import 'package:flutterwarehouseapp/src/domain/entities/item_bill_entity.dart';

part 'bill_entity.g.dart';

@HiveType(typeId: 3)
class BillEntity {
  @HiveField(0)
  String distributor;
  @HiveField(1)
  String type;
  @HiveField(2)
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
  String hiveJson;
  @HiveField(8)
  String customer;
  HiveEntity hive;

  BillEntity({
    this.distributor,
    this.type,
    this.items,
    this.totalAmount,
    this.locale,
    this.hiveJson,
    this.createAt,
    this.lastUpdate,
    this.customer,
    this.hive,
  });

  BillModel toModel() {
    return BillModel(
      distributor: distributor,
      type: type,
      items: items,
      totalAmount: totalAmount,
      locale: locale,
      createAt: createAt,
      lastUpdate: lastUpdate,
      customer: customer,
    );
  }

  void setHiveJson() {
    this.hiveJson = jsonEncode(hive.toJson());
  }
}
