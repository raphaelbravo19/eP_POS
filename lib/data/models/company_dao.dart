import 'package:epaisa_pos/data/database.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'company_dao.g.dart';

@UseDao(tables: [Company])
class CompanyDao extends DatabaseAccessor<AppDatabase> with _$CompanyDaoMixin {
  final AppDatabase db;

//   // Called by the AppDatabase class
  CompanyDao(this.db) : super(db);

  Future<List<CompanyData>> getAll() => select(company).get();

  Future<CompanyData> getOne(String id) {
    return (select(company)..where((d) => d.id.equals(id))).getSingle();
  }

  Future<bool> exists(String id) async {
    return await getOne(id) != null;
  }

  Stream<List<CompanyData>> watchAll() => select(company).watch();

  Future add(CompanyData data) => into(company).insert(data);
  Future edit(CompanyData data) => update(company).replace(data);
  Future remove(CompanyData data) => delete(company).delete(data);

  static CompanyData fromMap(Map<String, dynamic> map) {
    return CompanyData(
      id: map['id'],
      name: map['name'],
      industryId: map['industry'],
      businessTypeId: map['type'],
      merchantId: map['merchantId'],
      status: map['status'],
    );
  }
}
