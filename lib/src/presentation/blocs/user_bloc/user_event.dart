import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/src/domain/entities/user_entity.dart';

abstract class UserEvent {}

class GetUserEvent extends UserEvent {}
