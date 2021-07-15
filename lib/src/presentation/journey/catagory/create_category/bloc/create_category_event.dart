import 'package:flutter/material.dart';

abstract class CreateCategoryEvent {}

class OnPressCreateEvent extends CreateCategoryEvent {
  final String categoryName;

  OnPressCreateEvent({@required this.categoryName});
}
