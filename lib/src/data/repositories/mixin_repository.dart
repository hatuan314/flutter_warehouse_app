import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/data/models/bill_model.dart';
import 'package:flutterwarehouseapp/src/data/models/category_model.dart';
import 'package:flutterwarehouseapp/src/data/models/distributor_model.dart';
import 'package:flutterwarehouseapp/src/domain/entities/hive_entity.dart';

mixin MixinRepository {
  List<T> getCloudDataList<T>(QuerySnapshot snapshot) {
    List<T> values = [];
    if (!ValidatorUtils.isNullEmpty(snapshot.docs)) {
      if (T == DistributorModel) {
        for (final QueryDocumentSnapshot doc in snapshot.docs) {
          DistributorModel distributor = DistributorModel.fromJson(doc.data());
          distributor.hive = HiveEntity(document: doc.id, isSync: true);
          values.add(distributor as T);
        }
      } else if (T == CategoryModel) {
        for (final QueryDocumentSnapshot doc in snapshot.docs) {
          CategoryModel category = CategoryModel.fromJson(doc.data());
          category.hive = HiveEntity(document: doc.id, isSync: true);
          category.setHiveJson();
          values.add(category as T);
        }
      } else if (T == BillModel) {
        for (final QueryDocumentSnapshot doc in snapshot.docs) {
          BillModel bill = BillModel.fromJson(doc.data());
          bill.hive = HiveEntity(document: doc.id, isSync: true);
          values.add(bill as T);
        }
      }
    }
    return values;
  }
}