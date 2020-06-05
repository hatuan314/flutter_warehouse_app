import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

import 'package:flutterwarehouseapp/src/distributor/domain/domain.dart';
import 'package:flutterwarehouseapp/src/distributor/domain/entities/entities.dart';
import 'package:flutterwarehouseapp/data/data.dart';

part 'distributor_state.dart';

part 'distributor_event.dart';

class DistributorBloc extends Bloc<DistributorEvent, DistributorState> {
  List<DistributorEntity> _allDistributors = <DistributorEntity>[];
  bool _isOpenSearchDistributor = false;
  int _currentIndex = 0;
  var container = kiwi.Container();

  DistributorBloc() {
    _allDistributors =
        container.resolve<ShareService>('share_service').allDistributors;
  }

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
    if (event is TypeKeyboardSearchDistributorEvent)
      yield* _mapSearchDistributorTypeKeyboardEventToState(event.keyword);
  }

  Stream<DistributorState> _mapAddDistributorEventToState(
      BtnAddDistributorOnPressEvent event) async* {
    yield DistributorLoadingState();
    try {
      var rand = Random();
      String colorKey = rand.nextInt(20).toString();

      DistributorEntity distributorEntity = DistributorEntity(
          name: event.name,
          address: event.address,
          phoneOne: event.phoneOne,
          phoneTwo: event.phoneTwo,
          colorKey: colorKey);

      await container
          .resolve<DistributorUseCase>()
          .addNewDistributor(distributorEntity);
      yield* _mapShowAllDistributorsEventToState(isUpdate: true);
    } catch (e) {
      yield DistributorFailureState(e.toString());
    }
  }

  Stream<DistributorState> _mapShowAllDistributorsEventToState({bool isUpdate = false}) async* {
    yield DistributorLoadingState();
    try {
      if (_allDistributors.isEmpty || isUpdate == true) {
        _allDistributors =
            await container.resolve<DistributorUseCase>().getAllDistributors();
        container.resolve<ShareService>('share_service').allDistributors =
            _allDistributors;
      }
      if (_allDistributors.isEmpty)
        yield DistributorNoDataState();
      else
        yield DistributorSuccessState(
            _allDistributors, _isOpenSearchDistributor);
    } catch (e) {
      yield DistributorFailureState(e.toString());
    }
  }

  Stream<DistributorState> _mapFilterDistributorsEventToState(
      int actionIndex) async* {
    yield DistributorLoadingState();
    if (_allDistributors.length == 0)
      yield DistributorNoDataState();
    else {
      if (_currentIndex != actionIndex) _currentIndex = actionIndex;
      _allDistributors = List.from(_allDistributors.reversed);
      yield DistributorSuccessState(_allDistributors, _isOpenSearchDistributor);
    }
  }

  Stream<DistributorState> _mapOpenSearchDistributorEventToState(
      bool isOpen) async* {
    yield DistributorLoadingState();
    _isOpenSearchDistributor = isOpen;
    yield DistributorSuccessState(_allDistributors, _isOpenSearchDistributor);
  }

  Stream<DistributorState> _mapSearchDistributorTypeKeyboardEventToState(
      String keyword) async* {
    yield DistributorLoadingState();
    List<DistributorEntity> searchDistributorsList = <DistributorEntity>[];
    if (keyword.isEmpty)
      searchDistributorsList = _allDistributors;
    else {
      for (int index = 0; index < _allDistributors.length; index++) {
        String phoneTwo = '0';
        if (_allDistributors[index].phoneTwo.isNotEmpty)
          phoneTwo = _allDistributors[index].phoneTwo;
        String searchItem =
            '${_allDistributors[index].name} ${_allDistributors[index].phoneOne} $phoneTwo';
        if (searchItem.toLowerCase().contains(keyword.toLowerCase()))
          searchDistributorsList.add(_allDistributors[index]);
      }
    }
    yield DistributorSuccessState(
        searchDistributorsList, _isOpenSearchDistributor);
  }
}
