import 'package:epaisa_pos/data/database.dart';
import 'package:moor_flutter/moor_flutter.dart';
part 'industry_dao.g.dart';

@UseDao(tables: [Industry])
class IndustryDao extends DatabaseAccessor<AppDatabase>
    with _$IndustryDaoMixin {
  final AppDatabase db;

  // Called by the AppDatabase class
  IndustryDao(this.db) : super(db);

  Future<List<IndustryData>> getAll() => select(industry).get();
  Future<IndustryData> getOne(String id) =>
      (select(industry)..where((d) => d.id.equals(id))).getSingle();

  Future<List<IndustryData>> getChildren(String id) =>
      (select(industry)..where((d) => d.parentId.equals(id))).get();
  Future<List<IndustryData>> getParent() =>
      (select(industry)..where((d) => (isNull(d.parentId)))).get();
  Future<bool> exists(String id) async => await getOne(id) != null;
  Stream<List<IndustryData>> watchAll() => select(industry).watch();

  Future add(IndustryData data) => into(industry).insert(data);
  Future edit(IndustryData data) => update(industry).replace(data);
  Future remove(IndustryData data) => delete(industry).delete(data);

  static IndustryData fromMap(Map<String, dynamic> map) {
    return IndustryData(
      id: map['id'],
      name: map['name'],
      level: map['level'],
      status: map['status'],
      industryParentId: map['industryParentId'],
      parentId: map['parentId'],
    );
  }
}
