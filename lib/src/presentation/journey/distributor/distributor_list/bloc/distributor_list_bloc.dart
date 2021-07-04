import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/src/domain/entities/distributor_entity.dart';
import 'package:flutterwarehouseapp/src/domain/usecases/distributor_usecase.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/loader_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_list/bloc/distributor_list_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/distributor/distributor_list/bloc/distributor_list_state.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';

class DistributorListBloc
    extends Bloc<DistributorListEvent, DistributorListState> {
  final DistributorUseCase distributorUc;
  final SnackbarBloc snackbarBloc;
  final LoaderBloc loaderBloc;

  DistributorListBloc({
    @required this.distributorUc,
    @required this.snackbarBloc,
    @required this.loaderBloc,
  });

  @override
  DistributorListState get initialState => DistributorListState(
        viewState: ViewState.loading,
        distributorList: [],
      );

  @override
  Stream<DistributorListState> mapEventToState(
      DistributorListEvent event) async* {
    if (event is InitialDistributorListEvent) {
      yield* _mapInitialDistributorListEventToState();
    }
    if (event is RemoveDistributorEvent) {
      yield* _mapDeleteDistributorEventToState(event);
    }
  }

  Stream<DistributorListState> _mapDeleteDistributorEventToState(
      RemoveDistributorEvent event) async* {
    loaderBloc.add(StartLoading());
    await distributorUc.removeDistributor(
        index: event.index, document: event.distributor.document);
    add(InitialDistributorListEvent());
    loaderBloc.add(FinishLoading());
  }

  Stream<DistributorListState> _mapInitialDistributorListEventToState() async* {
    yield state.copyWith(viewState: ViewState.loading);
    List<DistributorEntity> distributorList =
        await distributorUc.getDistributorList();
    yield state.copyWith(
        viewState: ViewState.initial, distributorList: distributorList);
  }
}
