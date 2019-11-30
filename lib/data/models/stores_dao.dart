import 'package:epaisa_pos/data/database.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'stores_dao.g.dart';

@UseDao(tables: [Stores])
class StoresDao extends DatabaseAccessor<AppDatabase> with _$StoresDaoMixin {
  final AppDatabase db;

//   // Called by the AppDatabase class
  StoresDao(this.db) : super(db);

  Future<List<Store>> getAll() => select(stores).get();

  Future<Store> getOne(String id) {
    return (select(stores)..where((d) => d.id.equals(id))).getSingle();
  }

  Future<List<Store>> getByCompany(String companyId) {
    return (select(stores)..where((store) => store.companyId.equals(companyId)))
        .get();
  }

  Future<bool> exists(String id) async {
    return await getOne(id) != null;
  }

  Stream<List<Store>> watchAll() => select(stores).watch();

  Future add(Store data) => into(stores).insert(data);
  Future edit(Store data) => update(stores).replace(data);
  Future remove(Store data) => delete(stores).delete(data);

  static Store fromMap(Map<String, dynamic> map) {
    return Store(
      id: map['id'],
      name: map['name'],
      companyId: map['companyId'],
      merchantId: map['merchantId'],
      status: map['status'],
    );
  }
}
