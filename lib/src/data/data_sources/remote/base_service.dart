import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/snackbar_type.dart';

class BaseService {
  Future<DocumentSnapshot> getDocumentSnapshot(
      DocumentReference ref) async {
    DocumentSnapshot snapshot;
    try {
      snapshot = await ref.get();
      return snapshot;
    } on FirebaseException catch (e) {
      locator<SnackbarBloc>()
          .add(ShowSnackbar(title: e.toString(), type: SnackBarType.error));
      return null;
    }
  }

  Future<bool> setDocumentSnapshot(
      {DocumentReference ref, Map<String, dynamic> request}) async {
    try {
      await ref.set(request);
      return true;
    } on FirebaseException catch (e) {
      locator<SnackbarBloc>()
          .add(ShowSnackbar(title: e.toString(), type: SnackBarType.error));
      return false;
    }
  }

  Future<QuerySnapshot> getDocumentSnapshotList(CollectionReference ref) async {
    QuerySnapshot snapshot;
    try {
      return await ref.get();
    } on FirebaseException catch (e) {
      locator<SnackbarBloc>()
          .add(ShowSnackbar(title: e.toString(), type: SnackBarType.error));
      return null;
    }
  }
}
