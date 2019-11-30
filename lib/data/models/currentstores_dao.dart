import 'package:epaisa_pos/data/database.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'currentstores_dao.g.dart';

@UseDao(tables: [CurrentStores])
class CurrentStoresDao extends DatabaseAccessor<AppDatabase>
    with _$CurrentStoresDaoMixin {
  final AppDatabase db;

//   // Called by the AppDatabase class
  CurrentStoresDao(this.db) : super(db);

  Future<List<CurrentStore>> getAll() => select(currentStores).get();

  Future<CurrentStore> getOne(String id) {
    return (select(currentStores)..where((d) => d.id.equals(id))).getSingle();
  }

  Future<bool> exists(String id) async {
    return await getOne(id) != null;
  }

  Stream<List<CurrentStore>> watchAll() => select(currentStores).watch();
  Future<List<CurrentStore>> getByCompany(String companyId) {
    return (select(currentStores)
          ..where((store) => store.companyId.equals(companyId)))
        .get();
  }

  Future add(CurrentStore data) => into(currentStores).insert(data);
  Future edit(CurrentStore data) => update(currentStores).replace(data);
  Future remove(CurrentStore data) => delete(currentStores).delete(data);

  static CurrentStore fromMap(Map<String, dynamic> map) {
    return CurrentStore(
      id: map['id'],
      name: map['name'],
      companyId: map['companyId'],
      merchantId: map['merchantId'],
      status: map['status'],
      pinCode: map['pinCode'],
      district: map['district'],
      currency: map['currency'],
      language: map['language'],
      area: map['area'],
      cityId: map['cityId'],
      stateId: map['stateId'],
      countryId: map['countryId'],
      cityName: map['cityName'],
      stateName: map['stateName'],
      countryName: map['countryName'],
      address1: map['address1'],
      address2: map['address2'],
      invoice: map['invoice'],
      invoicePrefix: map['invoicePrefix'],
      invoiceStart: map['invoiceStart'],
    );
  }
}
