import 'package:flutterwarehouseapp/src/data/models/user_model.dart';

class UserEntity {
  String id;
  String name;
  String phone;
  String email;
  String avatar;
  String isoCode;
  int createAt;
  int lastUpdate;

  UserEntity({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.avatar,
    this.isoCode,
    this.createAt,
    this.lastUpdate,
  });

  UserModel toModel() => UserModel(
        id: id,
        name: name,
        phone: phone,
        email: email,
    avatar: this.avatar,
        isoCode: isoCode,
        createAt: createAt,
        lastUpdate: lastUpdate,
      );
}
