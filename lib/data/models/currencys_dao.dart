import 'package:epaisa_pos/data/database.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'currencys_dao.g.dart';

@UseDao(tables: [Currencys])
class CurrencysDao extends DatabaseAccessor<AppDatabase>
    with _$CurrencysDaoMixin {
  final AppDatabase db;

//   // Called by the AppDatabase class
  CurrencysDao(this.db) : super(db);

  Future<List<Currency>> getAll() => select(currencys).get();
  Future<Currency> getOne(String id) {
    return (select(currencys)..where((d) => d.id.equals(id))).getSingle();
  }

  Future<bool> exists(String id) async {
    return await getOne(id) != null;
  }

  Stream<List<Currency>> watchAll() => select(currencys).watch();

  Future add(Currency data) => into(currencys).insert(data);
  Future edit(Currency data) => update(currencys).replace(data);
  Future remove(Currency data) => delete(currencys).delete(data);

  static Currency fromMap(Map<String, dynamic> map) {
    return Currency(
        id: map['id'],
        name: map['name'],
        code: map['code'],
        status: map["status"]);
  }
}
