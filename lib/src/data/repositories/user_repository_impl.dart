import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  Future<UserEntity> getUser(String uid) async {
    final DocumentSnapshot snapshot = await userDataSource.getUser(uid);
    log('UserRepo - getUser: ${snapshot.data()}');
    if (snapshot.data() != null) {
      final UserEntity user = UserModel.fromJson(snapshot.data());
      return user;
    }
    return null;
  }
}
