import 'base_model.dart';
import 'base_builder.dart';
import 'base_database_helper.dart';
import 'base_columns.dart';
import 'package:sqflite/sqflite.dart';

abstract class Dao<T extends Model> {
  BaseDbHelper db;
  Builder<T> builder;

  Dao(BaseDbHelper db, Builder<T> builder) {
    this.db = db;
    this.builder = builder;
  }

  String getTableName();

  String _createFetchQuery(String where, String orderBy) {
    String query;
    if (where == null || where.length == 0) {
      query = "SELECT * FROM " + getTableName();
    } else {
      query = "SELECT * FROM " + getTableName() + " WHERE " + where;
    }
    if (orderBy != null && orderBy.length != 0) {
      query += " ORDER BY " + orderBy;
    }
    return query;
  }

  Future<List<T>> _fetch(String where, String orderBy) async {
    List<T> result = new List();
    var dbClient = await db.db;
    List<Map> list = await dbClient.rawQuery(_createFetchQuery(where, orderBy));
    for (int index = 0; index < list.length; index++) {
      result.add(builder.fromMap(list[index]).build());
    }
    return result;
  }

  Future<T> _fetchOne(String where) async {
    T model;
    var dbClient = await db.db;
    List<Map> list =
        await dbClient.rawQuery(_createFetchQuery(where + " LIMIT 1", null));
    if (list != null || list.length != 0) {
      model = (builder.fromMap(list[0]).build());
    } else
      model = null;
    return model;
  }

  Future<List<T>> getAll() async {
    return _fetch(null, null);
  }

  Future<List<T>> getUnSyncedModel() async {
    String predicate = IS_SYNCED + "= 0";
    return _fetch(predicate, null);
  }

  Future<List<T>> getAllOrderBy(String orderBy) async {
    return _fetch(null, orderBy);
  }

  Future<List<T>> getWhere(String where) async {
    return _fetch(where, null);
  }

  Future<T> getById(String id) async {
    String predicate = ID + " = '" + id + "'";
    return _fetchOne(predicate);
  }

  Future<T> getByLocalId(String localId) async {
    String predicate = LOCAL_ID + " = '" + localId + "'";
    return _fetchOne(predicate);
  }

  Future<T> getByName(String name) async {
    String predicate = NAME + " = '" + name + "'";
    return _fetchOne(predicate);
  }

  Future<int> delete(T model) async {
    var dbClient = await db.db;
    String where = LOCAL_ID + " = '" + model.localId + "'";
    return dbClient.delete(getTableName(), where: where);
  }

  Future<int> deleteWhere(String where) async {
    var dbClient = await db.db;
    return dbClient.delete(getTableName(), where: where);
  }

  Future<int> deleteAll() async {
    var dbClient = await db.db;
    return dbClient.delete(getTableName());
  }

  Future<int> save(T model) async {
    var dbClient = await db.db;
    return dbClient.insert(getTableName(), builder.setModel(model).buildMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> saveJson(Map<String, dynamic> json) async {
    var dbClient = await db.db;
    return dbClient.insert(getTableName(), builder.buildMapFromJson(json),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  void saveList(List<T> list) async {
    var dbClient = await db.db;
    await dbClient.transaction((txn) async {
      for (int index = 0; index < list.length; index++) {
        txn.insert(getTableName(), builder.setModel(list[index]).buildMap(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    });
  }
}
