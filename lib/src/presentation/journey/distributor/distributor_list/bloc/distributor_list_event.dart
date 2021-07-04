import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';

abstract class DistributorListEvent {}

class InitialDistributorListEvent extends DistributorListEvent {}

class RemoveDistributorEvent extends DistributorListEvent {
  final int index;
  final DistributorEntity distributor;

  RemoveDistributorEvent({@required this.index, @required this.distributor});
}
