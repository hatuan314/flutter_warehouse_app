import 'package:flutter/foundation.dart';

import 'snackbar_type.dart';

abstract class SnackbarState {
  final String title;
  final SnackBarType type;
  final Key key;

  SnackbarState({
    this.title,
    this.type,
    this.key,
  });
}

class InitialSnackbarState extends SnackbarState {}

class ShowSnackBarState extends SnackbarState {
  ShowSnackBarState({
    @required title,
    @required type,
    Key key,
  }) : super(
          title: title,
          type: type,
          key: key,
        );
}
