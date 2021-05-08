import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/src/domain/entities/user_entity.dart';
import 'package:flutterwarehouseapp/src/domain/repositories/user_repository.dart';

class UserUseCase {
  final UserRepository userRepository;

  UserUseCase({@required this.userRepository});

  Future<bool> createUser(UserEntity user) => userRepository.createUser(user);

  Future<UserEntity> getUser(String uid) => userRepository.getUser(uid);
}
