import 'package:flutter_bloc/flutter_bloc.dart';

import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  @override
  SplashState get initialState => InitialSplashState();

  @override
  Stream<SplashState> mapEventToState(SplashEvent event) async* {
    if (event is InitialSplashEvent)
      yield* _mapInitialSplashEventToState(event);
  }

  Stream<SplashState> _mapInitialSplashEventToState(InitialSplashEvent event) async* {
    await Future.delayed(Duration(seconds: 3));
    yield SplashCompleteState();
  }

}