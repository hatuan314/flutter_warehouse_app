class HiveEntity {
  String document;
  bool isSync;

  HiveEntity({this.document, this.isSync});

  factory HiveEntity.normal() => HiveEntity(document: '', isSync: false);

  factory HiveEntity.fromJson(Map<String, dynamic> json) => HiveEntity(
    document: json['document'],
    isSync: json['is_sync']
  );

  Map<String, dynamic> toJson() => {
    'document': document,
    'is_sync': isSync,
  };
}