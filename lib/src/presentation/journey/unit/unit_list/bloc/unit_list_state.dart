import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/src/domain/entities/unit_entity.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';

class UnitListState extends Equatable {
  final ViewState viewState;
  final List<UnitEntity> units;

  UnitListState({@required this.viewState, @required this.units});

  UnitListState copyWith({
    ViewState viewState,
    List<UnitEntity> units,
  }) =>
      UnitListState(
        units: units ?? this.units,
        viewState: viewState ?? this.viewState,
      );

  @override
  List<Object> get props => [this.viewState, this.units];
}
