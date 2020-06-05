import 'package:flutter/material.dart';

import 'package:flutterwarehouseapp/data/database.dart';
import 'package:flutterwarehouseapp/src/distributor/data/data.dart';

class DistributorProvider {
  Future<void> insertDistributor(DistributorModel distributorModel) async {
    try {
      await db.insert(
          DatabaseCreator.distributorTable, distributorModel.toJson());
    } catch (e) {
      debugPrint('DistributorProvider - Error: {${e.toString()}');
    }
  }

  Future<List<DistributorModel>> selectAllDistributors() async {

    List<DistributorModel> allDistributors = <DistributorModel>[];
    try {
      final List<Map<String, dynamic>> maps =
          await db.query('${DatabaseCreator.distributorTable}', orderBy: 'name ASC');

      allDistributors = List.generate(maps.length, (index) {
        return DistributorModel.fromJson(maps[index]);
      });
    } catch (e) {
      debugPrint(
          'DistributorProvider - selectAllDistributors - Error: {${e.toString()}}');
    }
    return allDistributors;
  }
}
