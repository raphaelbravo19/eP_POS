import 'package:epaisa_pos/data/database.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'currentmerchants_dao.g.dart';

@UseDao(tables: [CurrentMerchants])
class CurrentMerchantsDao extends DatabaseAccessor<AppDatabase>
    with _$CurrentMerchantsDaoMixin {
  final AppDatabase db;

//   // Called by the AppDatabase class
  CurrentMerchantsDao(this.db) : super(db);

  Future<List<CurrentMerchant>> getAll() => select(currentMerchants).get();

  Future<CurrentMerchant> getOne(String id) {
    return (select(currentMerchants)..where((d) => d.id.equals(id)))
        .getSingle();
  }

  Future<bool> exists(String id) async {
    return await getOne(id) != null;
  }

  Stream<List<CurrentMerchant>> watchAll() => select(currentMerchants).watch();

  Future add(CurrentMerchant data) => into(currentMerchants).insert(data);
  Future edit(CurrentMerchant data) => update(currentMerchants).replace(data);
  Future remove(CurrentMerchant data) => delete(currentMerchants).delete(data);

  static CurrentMerchant fromMap(Map<String, dynamic> map) {
    return CurrentMerchant(
      id: map['id'],
      plan: map['plan'],
      status: map['status'],
    );
  }
}
