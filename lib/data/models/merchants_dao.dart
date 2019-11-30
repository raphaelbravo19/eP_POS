import 'package:epaisa_pos/data/database.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'merchants_dao.g.dart';

@UseDao(tables: [Merchants])
class MarchantsDao extends DatabaseAccessor<AppDatabase>
    with _$MarchantsDaoMixin {
  final AppDatabase db;

//   // Called by the AppDatabase class
  MarchantsDao(this.db) : super(db);

  Future<List<Merchant>> getAll() => select(merchants).get();

  Future<Merchant> getOne(String id) {
    return (select(merchants)..where((d) => d.id.equals(id))).getSingle();
  }

  Future<bool> exists(String id) async {
    return await getOne(id) != null;
  }

  Stream<List<Merchant>> watchAll() => select(merchants).watch();

  Future add(Merchant data) => into(merchants).insert(data);
  Future edit(Merchant data) => update(merchants).replace(data);
  Future remove(Merchant data) => delete(merchants).delete(data);

  static Merchant fromMap(Map<String, dynamic> map) {
    return Merchant(
      id: map['id'],
      planId: map['plan'],
      status: map['status'],
    );
  }
}
