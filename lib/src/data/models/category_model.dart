import 'package:flutterwarehouseapp/src/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({
    String document,
    String name,
    int color,
    DateTime createAt,
    DateTime lastUpdate,
    bool isSync,
  }) : super(
          document: document,
          name: name,
          color: color,
          createTime: createAt,
          lastUpdate: lastUpdate,
          isSync: isSync,
        );

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        document: json['document'],
        name: json['name'],
        color: json['color'],
        createAt: json['create_at'] != null ? DateTime.fromMillisecondsSinceEpoch(json['create_at']) : null,
        lastUpdate: json['last_update'] != null ? DateTime.fromMillisecondsSinceEpoch(json['last_update']) : null,
        isSync: json['sync'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['document'] = document;
    json['name'] = name;
    json['color'] = color;
    json['create_at'] = this.createTime.millisecondsSinceEpoch;
    json['last_update'] = this.lastUpdate.millisecondsSinceEpoch;
    json['sync'] = isSync;
    return json;
  }
}
