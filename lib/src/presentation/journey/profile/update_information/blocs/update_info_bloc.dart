import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/local/app_preference.dart';
import 'package:flutterwarehouseapp/src/domain/entities/user_entity.dart';
import 'package:flutterwarehouseapp/src/domain/usecases/user_usecase.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/loader_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/user_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';

import 'update_info_state.dart';
import 'update_info_event.dart';

class UpdateInfoBloc extends Bloc<UpdateInfoEvent, UpdateInfoState> {
  final AppPreference pref;
  final UserUseCase userUseCase;
  final LoaderBloc loaderBloc;
  final UserBloc userBloc;

  UpdateInfoBloc(
      {@required this.pref,
      @required this.userUseCase,
      @required this.userBloc,
      @required this.loaderBloc});

  @override
  UpdateInfoState get initialState =>
      UpdateInfoState(viewState: ViewState.initial);

  @override
  Stream<UpdateInfoState> mapEventToState(UpdateInfoEvent event) async* {
    switch (event.runtimeType) {
      case CreateInfoEvent:
        yield* _mapCreateInfoToState(event);
        break;
    }
  }

  Stream<UpdateInfoState> _mapCreateInfoToState(CreateInfoEvent event) async* {
    loaderBloc.add(StartLoading());
    final UserEntity user = UserEntity(
      id: event.uid,
      email: event.email,
      phone: event.phone,
      name: event.fullName,
      isoCode: 'VND',
      createAt: DateTime.now().millisecondsSinceEpoch,
      lastUpdate: DateTime.now().millisecondsSinceEpoch,
    );
    final flag = await userUseCase.createUser(user);
    if (flag) {
      await pref.saveSession();
      userBloc.add(GetUserEvent());
      yield UpdateInfoState(viewState: ViewState.success);
    } else {
      yield UpdateInfoState(viewState: ViewState.error);
    }
    loaderBloc.add(FinishLoading());
  }
}
