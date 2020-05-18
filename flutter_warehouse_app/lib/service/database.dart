import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Database db;

class DatabaseCreator {
  static const distributorTable = 'distributor';
  static const phoneTable = 'phone';
  static const productTable = 'product';
  static const enteredPriceTable = 'entered_price';
  static const invoiceTable = 'invoice';
  static const invoiceItemTable = 'invoice_item';
  static const categoryTable = 'category';

  static void databaseLog(String functionName, String sql,
      [List<Map<String, dynamic>> selectQueryResult,
      int insertAndUpdateQueryResult,
      List<dynamic> params]) {
    debugPrint(functionName);
    print(sql);
    if (params != null) {
      debugPrint(params.toString());
    }
    if (selectQueryResult != null) {
      debugPrint(selectQueryResult.toString());
    } else if (insertAndUpdateQueryResult != null) {
      debugPrint(insertAndUpdateQueryResult.toString());
    }
  }

  Future createDistributorTable(Database db) async {
    final sql = '''CREATE TABLE $distributorTable
    (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      address TEXT,
      phone_1 TEXT,
      phone_2 TEXT,
      represent_color INTEGER
    )''';

    await db.execute(sql);
  }

  Future createPhoneTable(Database db) async {
    final sql = '''CREATE TABLE $phoneTable
    (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      distributor_id INTEGER,
      phone_number TEXT
    )''';

    await db.execute(sql);
  }

  Future createProductTable(Database db) async {
    final sql = '''CREATE TABLE $productTable
    (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      sale_price TEXT,
      category_id INTEGER
    )''';

    await db.execute(sql);
  }

  Future createEnteredPriceTable(Database db) async {
    final sql = '''CREATE TABLE $enteredPriceTable
    (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      entered_price TEXT,
      distributor_id INTEGER,
      product_id INTEGER,
      bar_code TEXT
    )''';

    await db.execute(sql);
  }

  Future createInvoiceTable(Database db) async {
    final sql = '''CREATE TABLE $invoiceTable
    (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date INTEGER,
      distributor_id INTEGER
    )''';

    await db.execute(sql);
  }

  Future createInvoiceItemTable(Database db) async {
    final sql = '''CREATE TABLE $invoiceItemTable
    (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      invoice_id INTEGER,
      product_id INTEGER,
      entered_price TEXT,
      amount INTEGER
    )''';

    await db.execute(sql);
  }

  Future createCategoryTable(Database db) async {
    final sql = '''CREATE TABLE $categoryTable
    (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT
    )''';

    await db.execute(sql);
  }

  Future<String> getDatabasePath(String dbName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    //make sure the folder exists
    if (await Directory(dirname(path)).exists()) {
      //await deleteDatabase(path);
    } else {
      await Directory(dirname(path)).create(recursive: true);
    }
    return path;
  }

  Future<void> initDatabase() async {
    final path = await getDatabasePath('warehouse_db');
    db = await openDatabase(path, version: 1, onCreate: onCreate);
    print(db);
  }

  Future<void> onCreate(Database db, int version) async {
    await createDistributorTable(db);
    await createPhoneTable(db);
    await createProductTable(db);
    await createEnteredPriceTable(db);
    await createInvoiceTable(db);
    await createInvoiceItemTable(db);
    await createCategoryTable(db);
  }
}
