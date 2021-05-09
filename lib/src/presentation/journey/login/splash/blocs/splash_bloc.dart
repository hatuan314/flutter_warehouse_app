import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/configs/default_env.dart';
import 'package:flutterwarehouseapp/common/configs/firebase_setup.dart';
import 'package:flutterwarehouseapp/common/constants/route_constants.dart';
import 'package:flutterwarehouseapp/src/data/data_sources/local/app_preference.dart';
import 'package:flutterwarehouseapp/src/domain/usecases/user_usecase.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/user_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';

import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SetupFirebaseDatabase setupFirebase;
  final AppPreference pref;
  final UserUseCase userUseCase;
  final UserBloc userBloc;

  SplashBloc({
    @required this.setupFirebase,
    @required this.pref,
    @required this.userUseCase,
    @required this.userBloc,
  });

  @override
  SplashState get initialState => SplashState(viewState: ViewState.initial);

  @override
  Stream<SplashState> mapEventToState(SplashEvent event) async* {
    if (event is InitialSplashEvent)
      yield* _mapInitialSplashEventToState(event);
  }

  Stream<SplashState> _mapInitialSplashEventToState(
      InitialSplashEvent event) async* {
    await Future.delayed(
        Duration(seconds: DefaultConfig.splashScreenSecondTimeOut));
    yield SplashState(viewState: ViewState.loading);
    final bool isSession = await pref.getIsSession();
    if (isSession == null || isSession == false) {
      yield SplashState(viewState: ViewState.success, route: RouteList.login);
    } else {
      final String uid = setupFirebase.auth.currentUser.uid;
      final user = await userUseCase.getUser(uid);
      if (user == null) {
        yield SplashState(viewState: ViewState.success, route: RouteList.login);
      } else {
        userBloc.user = user;
        yield SplashState(viewState: ViewState.success, route: RouteList.main);
      }
    }
  }
}
