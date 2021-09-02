import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CommonRepository {
  List<T> getCloudDataList<T>(QuerySnapshot snapshot);
}