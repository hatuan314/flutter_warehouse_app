import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/common/utils/connectivity_utils.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/snackbar_type.dart';

import 'internet_event.dart';
import 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  final SnackbarBloc snackbarBloc;

  InternetBloc({@required this.snackbarBloc});

  @override
  InternetState get initialState => ConnectState();

  @override
  Stream<InternetState> mapEventToState(InternetEvent event) async* {
    if (event is CheckInternetEvent) {
      final bool flag = await ConnectivityUtils.checkConnectInternet();
      if (flag) {
        yield ConnectState();
      } else {
        snackbarBloc.add(ShowSnackbar(
            title: StringConstants.noInternetTxt,
            type: SnackBarType.disconnect));
        yield DisconnectState();
      }
    }
  }
}
