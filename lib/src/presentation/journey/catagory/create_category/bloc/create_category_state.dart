import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';

class CreateCategoryState extends Equatable {
  final ViewState viewState;

  CreateCategoryState({@required this.viewState});

  CreateCategoryState copyWith({ViewState viewState}) => CreateCategoryState(viewState: viewState ?? this.viewState);
  @override
  List<Object> get props => [this.viewState];
}
