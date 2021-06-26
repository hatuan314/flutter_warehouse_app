import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';

import 'package:flutterwarehouseapp/common/extensions/string_extensions.dart';
import 'package:flutterwarehouseapp/common/utils/color_utils.dart';
import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';
import 'package:flutterwarehouseapp/src/domain/usecases/distributor_usecase.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/loader_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/snackbar_type.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/add_distributor/bloc/add_distributor_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/add_distributor/bloc/add_distributor_state.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';

class AddDistributorBloc
    extends Bloc<AddDistributorEvent, AddDistributorState> {
  final DistributorUseCase distributorUc;
  final SnackbarBloc snackbarBloc;
  final LoaderBloc loaderBloc;

  AddDistributorBloc({
    @required this.distributorUc,
    @required this.snackbarBloc,
    @required this.loaderBloc,
  });

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
      case CreateDistributorEvent:
        yield* _mapCreateDistributorEventToState(event);
        break;
    }
  }

  Stream<AddDistributorState> _mapCreateDistributorEventToState(
      CreateDistributorEvent event) async* {
    loaderBloc.add(StartLoading());
    yield InitialAddDistributorState(viewState: ViewState.loading);
    final currentState = state;
    final Color color = ColorUtils.randColor();
    if (currentState is InitialAddDistributorState) {
      DistributorEntity distributor = DistributorEntity(
        name: event.name,
        phones: [
          event.firstPhone,
          event.secondPhone,
        ],
        emails: [
          event.firstEmail,
          event.secondEmail,
        ],
        color: ColorUtils.parseInt(color),
        createAt: DateTime.now(),
        lastUpdate: DateTime.now(),
      );
      bool flag = await distributorUc.addDistributor(distributor);
      if (flag) {
        snackbarBloc.add(ShowSnackbar(
            title: StringConstants.createSuccessTxt,
            type: SnackBarType.success));
        yield CreateDistributorSuccessState();
      } else {
        snackbarBloc.add(ShowSnackbar(
            title: StringConstants.createFailureTxt, type: SnackBarType.error));
        yield currentState.copyWith(viewState: ViewState.initial);
      }
    }
    loaderBloc.add(FinishLoading());
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
