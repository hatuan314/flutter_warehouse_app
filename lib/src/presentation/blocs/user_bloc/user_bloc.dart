import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/common/configs/firebase_setup.dart';
import 'package:flutterwarehouseapp/src/domain/entities/user_entity.dart';
import 'package:flutterwarehouseapp/src/domain/usecases/user_usecase.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/loader_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/snackbar_type.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/user_bloc/user_event.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/user_bloc/user_state.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final SetupFirebaseDatabase setupFirebase;
  final UserUseCase userUseCase;
  final LoaderBloc loaderBloc;
  final SnackbarBloc snackbarBloc;
  UserEntity user;
  String locale = 'vi';

  UserBloc({
    @required this.setupFirebase,
    @required this.userUseCase,
    @required this.loaderBloc,
    @required this.snackbarBloc,
  });

  @override
  UserState get initialState => UserState(viewState: ViewState.initial);

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    switch (event.runtimeType) {
      case GetUserEvent:
        yield* _mapGetUserEventToState(event);
        break;
    }
  }

  Stream<UserState> _mapGetUserEventToState(GetUserEvent event) async* {
    final String uid = setupFirebase.auth.currentUser.uid;
    try {
      yield UserState(viewState: ViewState.loading);
      user = await userUseCase.getUser(uid);
      yield UserState(viewState: ViewState.initial);
    } catch (e) {
      snackbarBloc.add(ShowSnackbar(
        title: e.toString(),
        type: SnackBarType.error,
      ));
    }
  }
}
