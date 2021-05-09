import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/main/bloc/main_event.dart';
import 'package:flutterwarehouseapp/src/presentation/journey/main/bloc/main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  @override
  MainState get initialState => MainState(0);

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    yield MainState(event.selectedIndex);
  }

}