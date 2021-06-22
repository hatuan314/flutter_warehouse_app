import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/src/domain/entities/unit_entity.dart';
import 'package:flutterwarehouseapp/src/domain/usecases/unit_usecase.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/unit/unit_list/bloc/unit_list_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/unit/unit_list/bloc/unit_list_state.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';

class UnitListBloc extends Bloc<UnitListEvent, UnitListState> {
  final UnitUseCase unitUc;

  UnitListBloc({@required this.unitUc});

  @override
  UnitListState get initialState => UnitListState(
        viewState: ViewState.initial,
        units: [],
      );

  @override
  Stream<UnitListState> mapEventToState(UnitListEvent event) async* {
    if (event is InitialUnitListEvent) {
      yield* _mapInitialUnitListEventToState(event);
    }
    if (event is RemoveAllUnitsEvent) {
      yield* _mapRemoveAllUnitsEventToState();
    }
  }

  Stream<UnitListState> _mapInitialUnitListEventToState(
      InitialUnitListEvent event) async* {
    yield state.copyWith(viewState: ViewState.loading);
    List<UnitEntity> units = await unitUc.getUnitList();
    log('>>>>>>>>UnitListBloc - getUnitList - length: ${units.length}');
    yield state.copyWith(viewState: ViewState.initial, units: units);
  }

  Stream<UnitListState> _mapRemoveAllUnitsEventToState() async* {
    yield state.copyWith(viewState: ViewState.loading);
    await unitUc.removeAllUnits();
    yield state.copyWith(viewState: ViewState.initial, units: []);
  }
}
