import 'package:flutterwarehouseapp/src/domain/entities/hive_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    String name,
    String category,
    String distributor,
    int qty,
    int importPrice,
    int exportPrice,
    String locale,
    int createAt,
    int lastUpdate,
    String unit,
    HiveEntity hive,
  }) : super(
          name: name,
          category: category,
          distributor: distributor,
          qty: qty,
          importPrice: importPrice,
          exportPrice: exportPrice,
          locale: locale,
          createAt: createAt,
          lastUpdate: lastUpdate,
          unit: unit,
          hive: hive,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        name: json['name'],
        category: json['category'],
        distributor: json['distributor'],
        qty: json['qty'],
        importPrice: json['import_price'],
        exportPrice: json['export_price'],
        createAt: json['create_at'],
        lastUpdate: json['last_update'],
        unit: json['unit'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'category': category,
        'distributor': distributor,
        'qty': qty,
        'import_price': importPrice,
        'export_price': exportPrice,
        'locale': locale,
        'create_at': createAt,
        'last_update': lastUpdate,
        'unit': unit,
      };
}
