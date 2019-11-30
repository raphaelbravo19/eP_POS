import 'package:epaisa_pos/data/database.dart';
import 'package:moor_flutter/moor_flutter.dart';
part 'fingerprintuser_dao.g.dart';

@UseDao(tables: [FingerprintUser])
class FingerprintUserDao extends DatabaseAccessor<AppDatabase>
    with _$FingerprintUserDaoMixin {
  final AppDatabase db;

  // Called by the AppDatabase class
  FingerprintUserDao(this.db) : super(db);

  Future<List<FingerprintUserData>> getAll() => select(fingerprintUser).get();
  Future<FingerprintUserData> getOne(String id) =>
      (select(fingerprintUser)..where((d) => d.id.equals(id))).getSingle();

  Future<bool> exists(String id) async => await getOne(id) != null;
  Stream<List<FingerprintUserData>> watchAll() =>
      select(fingerprintUser).watch();

  Future add(FingerprintUserData data) => into(fingerprintUser).insert(data);
  Future edit(FingerprintUserData data) =>
      update(fingerprintUser).replace(data);
  Future remove(FingerprintUserData data) =>
      delete(fingerprintUser).delete(data);

  static FingerprintUserData fromMap(Map<String, dynamic> map) {
    return FingerprintUserData(id: map['id'], name: map['name']);
  }
}
