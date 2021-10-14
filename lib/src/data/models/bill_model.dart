import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
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
    int billDate,
    List<String> images,
    String description,
  }) : super(
          distributor: distributor,
          type: type,
          items: items,
          totalAmount: totalAmount,
          locale: locale,
          createAt: createAt,
          lastUpdate: lastUpdate,
          customer: customer,
          billDate: billDate,
          images: images,
          description: description,
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
        billDate: ValidatorUtils.isNullEmpty(json['bill_date']) ? json['create_at'] : json['bill_date'],
        images: ValidatorUtils.isNullEmpty(json['images']) ? [] : json['images'].cast<String>(),
        description: ValidatorUtils.isNullEmpty(json['description']) ? '' : json['description']);
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
      'bill_date': billDate,
      'images': images,
      'description': description,
    };
  }
}
