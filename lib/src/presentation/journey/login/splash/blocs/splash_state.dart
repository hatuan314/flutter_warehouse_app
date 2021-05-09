import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';

class SplashState extends Equatable {
  final ViewState viewState;
  final String route;

  SplashState({@required this.viewState, this.route});

  @override
  List<Object> get props => [this.viewState, this.route];
}