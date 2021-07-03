import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';

class DistributorDetailState extends Equatable {
  final ViewState viewState;
  final DistributorEntity distributor;
  final bool isUpdate;

  DistributorDetailState copyWith(
          {DistributorEntity distributor,
          ViewState viewState,
          bool isUpdate}) =>
      DistributorDetailState(
        distributor: distributor ?? this.distributor,
        viewState: viewState ?? this.viewState,
        isUpdate: isUpdate ?? this.isUpdate,
      );

  DistributorDetailState({
    @required this.distributor,
    @required this.viewState,
    @required this.isUpdate,
  });

  @override
  List<Object> get props => [this.distributor, this.viewState, this.isUpdate];
}

class DeleteDistributorSuccessState extends DistributorDetailState {}
