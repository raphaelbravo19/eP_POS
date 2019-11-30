import 'package:epaisa_pos/src/models/DatabaseProvider.dart';

abstract class Repository {
  DatabaseProvider databaseProvider;
  Future<dynamic> insert(dynamic t);
  Future<int> insertList(List<dynamic> t);

  Future<dynamic> update(dynamic t);
  Future<dynamic> delete(dynamic t);
  deleteAll();
  Future<List<dynamic>> getAll();
}
