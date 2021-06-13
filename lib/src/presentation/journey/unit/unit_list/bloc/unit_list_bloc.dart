import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/src/domain/usecases/unit_usecase.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/unit/unit_list/bloc/unit_list_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/unit/unit_list/bloc/unit_list_state.dart';

class UnitListBloc extends Bloc<UnitListEvent, UnitListState> {
  final UnitUseCase unitUc;

  UnitListBloc({@required this.unitUc});
  @override
  UnitListState get initialState => UnitListState(units: []);

  @override
  Stream<UnitListState> mapEventToState(UnitListEvent event) async* {
    if (event is InitialUnitListEvent) {
      yield* _mapInitialUnitListEventToState(event);
    }
  }

  Stream<UnitListState> _mapInitialUnitListEventToState(
      InitialUnitListEvent event) async* {
    await unitUc.getUnitList();
  }
}
