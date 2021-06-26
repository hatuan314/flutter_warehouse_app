import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';

class DistributorListState extends Equatable {
  final ViewState viewState;
  final List<DistributorEntity> distributorList;

  DistributorListState({
    @required this.viewState,
    @required this.distributorList,
  });

  DistributorListState copyWith(
          {ViewState viewState, List<DistributorEntity> distributorList}) =>
      DistributorListState(
        viewState: viewState ?? this.viewState,
        distributorList: distributorList ?? this.distributorList,
      );

  @override
  List<Object> get props => [
        this.viewState,
        this.distributorList,
      ];
}
