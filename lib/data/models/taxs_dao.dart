import 'package:epaisa_pos/data/database.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'taxs_dao.g.dart';

@UseDao(tables: [Taxs])
class TaxsDao extends DatabaseAccessor<AppDatabase> with _$TaxsDaoMixin {
  final AppDatabase db;

//   // Called by the AppDatabase class
  TaxsDao(this.db) : super(db);

  Future<List<Tax>> getAll() => select(taxs).get();

  Future<Tax> getOne(String id) {
    return (select(taxs)..where((d) => d.id.equals(id))).getSingle();
  }

  Future<bool> exists(String id) async {
    return await getOne(id) != null;
  }

  Stream<List<Tax>> watchAll() => select(taxs).watch();

  Future add(Tax data) => into(taxs).insert(data);
  Future edit(Tax data) => update(taxs).replace(data);
  Future remove(Tax data) => delete(taxs).delete(data);

  static Tax fromMap(Map<String, dynamic> map) {
    return Tax(
      id: map['id'],
      name: map['name'],
      countryId: map['country'],
      slab: map['slab'],
      taxValue: map['taxValue'],
      taxType: map['taxType'],
      displayName1: map['displayName1'],
      displayName2: map['displayName2'],
      displayName3: map['displayName3'],
      cgstValue: map['CGSTValue'],
      sgstValue: map['SGSTValue'],
      igstValue: map['IGSTValue'],
      taxMode: map['taxMode'],
    );
  }
}
