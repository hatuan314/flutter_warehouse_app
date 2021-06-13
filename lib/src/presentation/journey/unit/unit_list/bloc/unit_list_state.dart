import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/src/domain/entities/unit_entity.dart';

class UnitListState extends Equatable {
  final List<UnitEntity> units;

  UnitListState({@required this.units});
  @override
  List<Object> get props => [this.units];

}