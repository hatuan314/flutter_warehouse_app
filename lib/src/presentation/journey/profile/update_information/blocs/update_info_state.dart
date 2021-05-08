import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';

class UpdateInfoState extends Equatable {
  final ViewState viewState;

  UpdateInfoState({@required this.viewState});

  @override
  List<Object> get props => [this.viewState];
}
