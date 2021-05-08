import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/remote/user_datasource.dart';
import 'package:flutterwarehouseapp/src/data/models/user_model.dart';
import 'package:flutterwarehouseapp/src/domain/entities/user_entity.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource userDataSource;

  UserRepositoryImpl({@required this.userDataSource});

  @override
  Future<bool> createUser(UserEntity user) =>
      userDataSource.createUser(user.toModel());

  @override
  Future<UserModel> getUser(String uid) => userDataSource.getUser(uid);
}
