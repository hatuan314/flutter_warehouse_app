import 'package:bloc/bloc.dart';

import 'bloc.dart';

class SnackbarBloc extends Bloc<SnackbarEvent, SnackbarState> {
  @override
  SnackbarState get initialState => InitialSnackbarState();

  @override
  Stream<SnackbarState> mapEventToState(SnackbarEvent event) async* {
    if (event is ShowSnackbar) {
      yield ShowSnackBarState(
        title: event.title,
        type: event.type,
        key: event.key,
      );
    }
  }
}
