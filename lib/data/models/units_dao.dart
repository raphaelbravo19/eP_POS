import 'package:epaisa_pos/data/database.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'units_dao.g.dart';

@UseDao(tables: [Units])
class UnitsDao extends DatabaseAccessor<AppDatabase> with _$UnitsDaoMixin {
  final AppDatabase db;

//   // Called by the AppDatabase class
  UnitsDao(this.db) : super(db);

  Future<List<Unit>> getAll() => select(units).get();
  Future<Unit> getOne(String id) {
    return (select(units)..where((d) => d.id.equals(id))).getSingle();
  }

  Future<bool> exists(String id) async {
    return await getOne(id) != null;
  }

  Stream<List<Unit>> watchAll() => select(units).watch();

  Future add(Unit data) => into(units).insert(data);
  Future edit(Unit data) => update(units).replace(data);
  Future remove(Unit data) => delete(units).delete(data);

  static Unit fromMap(Map<String, dynamic> map) {
    return Unit(
      id: map['id'],
      name: map['name'],
    );
  }
}
