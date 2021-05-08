import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';

class UserState extends Equatable {
  final ViewState viewState;

  UserState({@required this.viewState});

  @override
  List<Object> get props => [this.viewState];
}
