import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/models/models.dart';
import 'package:flutterwarehouseapp/service/service.dart';

part 'distributor_state.dart';

part 'distributor_event.dart';

class DistributorBloc extends Bloc<DistributorEvent, DistributorState> {
  DistributorRepository repository = DistributorRepository();
  List<DistributorModel> allDistributors = <DistributorModel>[];
  bool isOpenSearchDistributor = false;

  int currentIndex = 0;

  @override
  // TODO: implement initialState
  DistributorState get initialState => DistributorInitialState();

  @override
  Stream<DistributorState> mapEventToState(DistributorEvent event) async* {
    // TODO: implement mapEventToState
    if (event is BtnAddDistributorOnPressEvent)
      yield* _mapAddDistributorEventToState(event);
    if (event is ShowAllDistributorsEvent)
      yield* _mapShowAllDistributorsEventToState();
    if (event is BtnFilterDistributorsOptionOnPressEvent)
      yield* _mapFilterDistributorsEventToState(event.actionIndex);
    if (event is BtnOpenSearchDistributorOnPressEvent)
      yield* _mapOpenSearchDistributorEventToState(event.isOpenSearchForm);
  }

  Stream<DistributorState> _mapAddDistributorEventToState(
      BtnAddDistributorOnPressEvent event) async* {
    yield DistributorLoadingState();
    try {
      var rand = Random();
      String colorKey = rand.nextInt(20).toString();

      DistributorModel distributorModel = DistributorModel(
          name: event.name,
          address: event.address,
          phoneOne: event.phoneOne,
          phoneTwo: event.phoneTwo);

      await repository.createNewDistributorReposotpry(
          distributorModel, colorKey);
      yield* _mapShowAllDistributorsEventToState();
    } catch (e) {
      yield DistributorFailureState(e.toString());
    }
  }

  Stream<DistributorState> _mapShowAllDistributorsEventToState() async* {
    yield DistributorLoadingState();
    try {
      allDistributors = await repository.getAllDistributors();
      if (allDistributors.length == 0)
        yield DistributorNoDataState();
      else
        yield DistributorSuccessState(allDistributors, isOpenSearchDistributor);
    } catch (e) {
      yield DistributorFailureState(e.toString());
    }
  }

  Stream<DistributorState> _mapFilterDistributorsEventToState(
      int actionIndex) async* {
    yield DistributorLoadingState();
    if (allDistributors.length == 0)
      yield DistributorNoDataState();
    else {
      if (currentIndex != actionIndex)
        currentIndex = actionIndex;
        allDistributors = List.from(allDistributors.reversed);
      yield DistributorSuccessState(allDistributors, isOpenSearchDistributor);
    }
  }

  Stream<DistributorState> _mapOpenSearchDistributorEventToState(bool isOpen) async* {
    yield DistributorLoadingState();
    isOpenSearchDistributor = isOpen;
    yield DistributorSuccessState(allDistributors, isOpenSearchDistributor);
  }
}
