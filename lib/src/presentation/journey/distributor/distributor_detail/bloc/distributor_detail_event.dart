import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';

abstract class DistributorDetailEvent {}

class InitialDistributorDetailEvent extends DistributorDetailEvent {
  final Map<String, dynamic> distributorJson;
  final int index;

  InitialDistributorDetailEvent({
    @required this.distributorJson,
    @required this.index,
  });
}

class ChangeEmailEvent extends DistributorDetailEvent {
  final String currentEmail;
  final String newEmail;

  ChangeEmailEvent({
    @required this.currentEmail,
    @required this.newEmail,
  });
}

class ChangePhoneEvent extends DistributorDetailEvent {
  final String currentPhone;
  final String newPhone;

  ChangePhoneEvent({
    @required this.currentPhone,
    @required this.newPhone,
  });
}

class DeleteDistributorEvent extends DistributorDetailEvent {}
