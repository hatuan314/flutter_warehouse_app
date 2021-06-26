import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';

abstract class AddDistributorState extends Equatable {}

class InitialAddDistributorState extends AddDistributorState {
  final ViewState viewState;

  InitialAddDistributorState({@required this.viewState});

  InitialAddDistributorState copyWith({ViewState viewState}) =>
      InitialAddDistributorState(viewState: viewState ?? this.viewState);

  @override
  List<Object> get props => [this.viewState];
}

class PopAddDistributorState extends AddDistributorState {
  final bool isShowDialog;

  PopAddDistributorState({@required this.isShowDialog});

  @override
  List<Object> get props => [this.isShowDialog];
}

class CreateDistributorSuccessState extends AddDistributorState {
  @override
  List<Object> get props => [];
}
