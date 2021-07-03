import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/src/data/models/distributor_model.dart';
import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';
import 'package:flutterwarehouseapp/src/domain/usecases/distributor_usecase.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/loader_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/snackbar_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/snackbar_type.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';

import 'distributor_detail_state.dart';
import 'distributor_detail_event.dart';

class DistributorDetailBloc
    extends Bloc<DistributorDetailEvent, DistributorDetailState> {
  final DistributorUseCase distributorUc;
  final LoaderBloc loaderBloc;
  final SnackbarBloc snackbarBloc;

  bool isUpdate = false;
  int distributorIndex;
  DistributorEntity distributor;

  DistributorDetailBloc({
    @required this.distributorUc,
    @required this.loaderBloc,
    @required this.snackbarBloc,
  });

  @override
  DistributorDetailState get initialState => DistributorDetailState(
        distributor: DistributorEntity(),
        viewState: ViewState.loading,
        isUpdate: false,
      );

  @override
  Stream<DistributorDetailState> mapEventToState(
      DistributorDetailEvent event) async* {
    switch (event.runtimeType) {
      case InitialDistributorDetailEvent:
        yield* _mapInitialDistributorDetailEventToState(event);
        break;
      case ChangePhoneEvent:
        yield* _mapChangePhoneEventToState(event);
        break;
      case ChangeEmailEvent:
        yield* _mapChangeEmailEventToState(event);
        break;
      case DeleteDistributorEvent:
        yield* _mapDeleteDistributorEventToState(event);
        break;
    }
  }

  Stream<DistributorDetailState> _mapDeleteDistributorEventToState(
      DeleteDistributorEvent event) async* {
    yield state.copyWith(viewState: ViewState.loading);
    loaderBloc.add(StartLoading());
    await distributorUc.removeDistributor(
        index: distributorIndex, document: this.distributor.document);
    yield DeleteDistributorSuccessState();
    loaderBloc.add(FinishLoading());
  }

  Stream<DistributorDetailState> _mapInitialDistributorDetailEventToState(
      InitialDistributorDetailEvent event) async* {
    yield state.copyWith(viewState: ViewState.loading);
    loaderBloc.add(StartLoading());
    distributor = DistributorModel.fromJson(event.distributorJson);
    distributorIndex = event.index;
    yield state.copyWith(
      distributor: distributor,
      viewState: ViewState.initial,
    );
    loaderBloc.add(FinishLoading());
  }

  Stream<DistributorDetailState> _mapChangePhoneEventToState(
      ChangePhoneEvent event) async* {
    loaderBloc.add(StartLoading());
    yield state.copyWith(viewState: ViewState.loading);
    final DistributorEntity distributor = this.distributor;
    distributor.setPhones(
      currentPhone: event.currentPhone,
      newPhone: event.newPhone,
    );
    await distributorUc
        .updateDistributor(index: distributorIndex, distributor: distributor)
        .then((value) {
      this.distributor = distributor;
      this.isUpdate = true;
      snackbarBloc.add(ShowSnackbar(
        title: StringConstants.updateSuccessMsg,
        type: SnackBarType.success,
      ));
    });
    yield state.copyWith(
      distributor: distributor,
      viewState: ViewState.initial,
      isUpdate: this.isUpdate,
    );
    loaderBloc.add(FinishLoading());
  }

  Stream<DistributorDetailState> _mapChangeEmailEventToState(
      ChangeEmailEvent event) async* {
    loaderBloc.add(StartLoading());
    yield state.copyWith(viewState: ViewState.loading);
    final DistributorEntity distributor = this.distributor;
    distributor.setEmails(
      currentEmail: event.currentEmail,
      newEmail: event.newEmail,
    );
    await distributorUc
        .updateDistributor(index: distributorIndex, distributor: distributor)
        .then((value) {
      this.distributor = distributor;
      this.isUpdate = true;
      snackbarBloc.add(ShowSnackbar(
        title: StringConstants.updateSuccessMsg,
        type: SnackBarType.success,
      ));
    });
    yield state.copyWith(
      distributor: distributor,
      viewState: ViewState.initial,
      isUpdate: this.isUpdate,
    );
    loaderBloc.add(FinishLoading());
  }
}
