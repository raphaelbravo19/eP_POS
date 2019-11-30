import 'package:epaisa_pos/data/database.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'business_type_dao.g.dart';

@UseDao(tables: [BusinessType])
class BusinessTypeDao extends DatabaseAccessor<AppDatabase>
    with _$BusinessTypeDaoMixin {
  final AppDatabase db;

//   // Called by the AppDatabase class
  BusinessTypeDao(this.db) : super(db);

  Future<List<BusinessTypeData>> getAll() => select(businessType).get();

  Future<BusinessTypeData> getOne(String id) {
    return (select(businessType)..where((d) => d.id.equals(id))).getSingle();
  }

  Future<bool> exists(String id) async {
    return await getOne(id) != null;
  }

  Stream<List<BusinessTypeData>> watchAll() => select(businessType).watch();

  Future add(BusinessTypeData data) => into(businessType).insert(data);
  Future edit(BusinessTypeData data) => update(businessType).replace(data);
  Future remove(BusinessTypeData data) => delete(businessType).delete(data);

  static BusinessTypeData fromMap(Map<String, dynamic> map) {
    return BusinessTypeData(
      id: map['id'],
      name: map['name'],
      status: map['status'],
    );
  }
}
