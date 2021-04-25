import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';

import 'blocs.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => LoginState(ViewState.initial);

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {

  }
}
