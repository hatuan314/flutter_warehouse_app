import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';

import 'package:flutterwarehouseapp/common/extensions/string_extensions.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/loader_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/snackbar_type.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/add_distributor/bloc/add_distributor_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/add_distributor/bloc/add_distributor_state.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';

class AddDistributorBloc
    extends Bloc<AddDistributorEvent, AddDistributorState> {
  final SnackbarBloc snackbarBloc;
  final LoaderBloc loaderBloc;

  AddDistributorBloc({@required this.snackbarBloc, @required this.loaderBloc});

  @override
  AddDistributorState get initialState =>
      InitialAddDistributorState(viewState: ViewState.initial);

  @override
  Stream<AddDistributorState> mapEventToState(
      AddDistributorEvent event) async* {
    switch (event.runtimeType) {
      case PopAddDistributorEvent:
        yield* _mapPopAddDistributorEventToState(event);
        break;
      case CancelPopAddDistributorEvent:
        yield InitialAddDistributorState(viewState: ViewState.initial);
        break;
    }
  }

  Stream<AddDistributorState> _mapPopAddDistributorEventToState(
      PopAddDistributorEvent event) async* {
    final bool flag = isShowPopDialog(
      name: event.name,
      firstPhone: event.firstPhone,
      secondPhone: event.secondPhone,
      firstEmail: event.firstEmail,
      secondEmail: event.secondEmail,
    );
    yield PopAddDistributorState(isShowDialog: flag);
  }

  bool isShowPopDialog({
    String name,
    String firstPhone,
    String secondPhone,
    String firstEmail,
    String secondEmail,
  }) {
    if (name.isSafe ||
        firstPhone.isSafe ||
        secondPhone.isSafe ||
        firstEmail.isSafe ||
        secondEmail.isSafe) {
      return true;
    }
    if (name.isNotSafe &&
        firstPhone.isNotSafe &&
        secondPhone.isNotSafe &&
        firstEmail.isNotSafe &&
        secondEmail.isNotSafe) {
      return false;
    }
    return false;
  }
}
