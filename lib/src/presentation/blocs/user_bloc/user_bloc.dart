import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwarehouseapp/src/domain/entities/user_entity.dart';
import 'package:flutterwarehouseapp/src/domain/usecases/user_usecase.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/user_bloc/user_event.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/user_bloc/user_state.dart';
import 'package:flutterwarehouseapp/src/presentation/view_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserUseCase useCase;
  UserEntity user;

  UserBloc({@required this.useCase});

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

  }
}
