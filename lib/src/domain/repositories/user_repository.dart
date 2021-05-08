import 'package:flutterwarehouseapp/src/data/models/user_model.dart';
import 'package:flutterwarehouseapp/src/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<bool> createUser(UserEntity userEntity);

  Future<UserModel> getUser(String uid);
}