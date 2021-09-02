import 'package:flutterwarehouseapp/src/domain/entities/bill_entity.dart';

class BillModel extends BillEntity {
  BillModel({
    String distributorName,
    String type,
    List items,
    int totalAmount,
    String locale,
    int createAt,
    int lastUpdate,
  }) : super(
          distributorName: distributorName,
          type: type,
    items: items,
          totalAmount: totalAmount,
          locale: locale,
          createAt: createAt,
          lastUpdate: lastUpdate,
        );

  factory BillModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return BillModel(
      distributorName: json['distributor'],
      type: json['type'],
      items: json['items'],
      totalAmount: json['total_amount'],
      locale: json['locale'],
      createAt: json['create_at'],
      lastUpdate: json['last_update'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'distributor': distributorName,
      'type': type,
      'items': items,
      'total_amount': totalAmount,
      'locale': locale,
      'create_at': createAt,
      'last_update': lastUpdate,
    };
  }
}
