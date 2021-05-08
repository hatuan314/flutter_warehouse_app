import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/configs/firebase_setup.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/src/data/models/user_model.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/snackbar_type.dart';

class UserDataSource {
  final SetupFirebaseDatabase setupFirebase;

  UserDataSource({@required this.setupFirebase});

  Future<bool> createUser(UserModel user) async {
    bool flag = false;
    await setupFirebase.userCollection.doc(user.id).set(user.toJson()).then((value) {
      flag = true;
    }, onError: (e) {
      locator<SnackbarBloc>()
          .add(ShowSnackbar(title: e.toString(), type: SnackBarType.error));
      flag = false;
    });
    return flag;
  }

  Future<UserModel> getUser(String uid) async {
    UserModel user;
    await setupFirebase.userCollection.doc(uid).get().then((documentSnapshot) {
      user = UserModel.fromJson(documentSnapshot.data());
    }, onError: (e) {
      locator<SnackbarBloc>()
          .add(ShowSnackbar(title: e.toString(), type: SnackBarType.error));
    });
    return user;
  }
}
