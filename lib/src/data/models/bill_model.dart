import 'package:flutterwarehouseapp/src/domain/entities/bill_entity.dart';

class BillModel extends BillEntity {
  BillModel({
    String distributor,
    String type,
    List items,
    int totalAmount,
    String locale,
    int createAt,
    int lastUpdate,
    String customer,
  }) : super(
          distributor: distributor,
          type: type,
          items: items,
          totalAmount: totalAmount,
          locale: locale,
          createAt: createAt,
          lastUpdate: lastUpdate,
          customer: customer,
        );

  factory BillModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return BillModel(
      distributor: json['distributor'],
      type: json['type'],
      items: json['items'],
      totalAmount: json['total_amount'],
      locale: json['locale'],
      createAt: json['create_at'],
      lastUpdate: json['last_update'],
      customer: json['customer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'distributor': distributor,
      'type': type,
      'items': items,
      'total_amount': totalAmount,
      'locale': locale,
      'create_at': createAt,
      'last_update': lastUpdate,
      'customer': customer,
    };
  }
}
