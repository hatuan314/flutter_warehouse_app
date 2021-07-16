import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/src/domain/entities/category_entity.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';

class CategoryListState extends Equatable {
  final ViewState viewState;
  final List<CategoryEntity> categories;

  CategoryListState({
    @required this.viewState,
    @required this.categories,
  });

  @override
  List<Object> get props => [this.viewState, this.categories,];

  CategoryListState copyWith({ViewState viewState, List<CategoryEntity> categories}) => CategoryListState(
        viewState: viewState ?? this.viewState,
        categories: categories ?? this.categories,
      );
}
