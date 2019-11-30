import 'dart:async';
import 'package:epaisa_pos/src/models/BaseContract.dart';
import 'package:epaisa_pos/src/models/DatabaseProvider.dart';
import 'package:epaisa_pos/src/models/Repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sprintf/sprintf.dart';

abstract class DatabaseRepository<T> implements Repository {
  @override
  DatabaseProvider databaseProvider = DatabaseProvider.get;
  String getTableName();

  T fromJson(Map json);

  List<T> fromList(List<Map<String, dynamic>> query);

  Future<T> fromListOne(List<Map<String, dynamic>> query);

  Map<String, dynamic> toMap(T object);

  T fromMap(Map<String, dynamic> query);

  @override
  Future<int> delete(dynamic t) async {
    final db = await databaseProvider.db();
    String where = sprintf(" %s == %s ", [BaseContract.id, t.id]);
    int res = await db.delete(getTableName(), where: where);
    return res;
  }

  deleteAll() async {
    final db = await databaseProvider.db();
    String sql = "delete from " + getTableName();
    await db.execute(sql);
  }

  @override
  Future<int> insert(dynamic t) async {
    final db = await databaseProvider.db();
    int res = await db.insert(getTableName(), toMap(t),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

  @override
  Future<int> update(dynamic t) async {
    final db = await databaseProvider.db();
    int res = await db.update(getTableName(), toMap(t),
        where: BaseContract.id + " = ?", whereArgs: [t.id]);
    return res;
  }

  Future<int> updateStore(dynamic t) async {
    final db = await databaseProvider.db();
    int res = await db.update(getTableName(), toMap(t),
        where: BaseContract.id + " = ?", whereArgs: [t.storeLocationId]);
    return res;
  }

  Future<int> updateEmployee(dynamic t) async {
    final db = await databaseProvider.db();
    int res = await db.update(getTableName(), toMap(t),
        where: BaseContract.id + " = ?", whereArgs: [t.employeeId]);
    return res;
  }

  @override
  Future<List<dynamic>> getAll() async {
    final db = await databaseProvider.db();
    List<Map> maps = await db.query(getTableName());
    return fromList(maps);
  }

  Future<int> insertList(List<dynamic> t) async {
    final db = await databaseProvider.db();
    int res = 0;
    t.forEach((f) async {
      res = await db.insert(getTableName(), toMap(f),
          conflictAlgorithm: ConflictAlgorithm.replace);
    });
    return res;
  }
}
