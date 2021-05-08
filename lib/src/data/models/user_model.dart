import 'package:flutterwarehouseapp/src/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    String id,
    String name,
    String phone,
    String email,
    String avatar,
    String isoCode,
    int createAt,
    int lastUpdate,
  }) : super(
          id: id,
          name: name,
          phone: phone,
          email: email,
          avatar: avatar,
          isoCode: isoCode,
          createAt: createAt,
          lastUpdate: lastUpdate,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'],
        phone: json['phone'],
        email: json['email'],
        avatar: json['avatar'],
        isoCode: json['iso_code'],
        createAt: json['create_at'],
        lastUpdate: json['last_update'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'email': email,
        'iso_code': isoCode,
        'create_at': createAt,
        'last_update': lastUpdate,
        'avatar': avatar,
      };
}
