import 'package:epaisa_pos/data/database.dart';
import 'package:moor_flutter/moor_flutter.dart';
part 'country_dao.g.dart';

@UseDao(tables: [Country])
class CountryDao extends DatabaseAccessor<AppDatabase> with _$CountryDaoMixin {
  final AppDatabase db;

  // Called by the AppDatabase class
  CountryDao(this.db) : super(db);

  Future<List<CountryData>> getAll() => select(country).get();
  Future<CountryData> getOne(String id) {
    print('getting country $id');
    return (select(country)..where((d) => d.id.equals(id))).getSingle();
  }

  Future<CountryData> getCode(int code) {
    print('getting country $code');
    return (select(country)
          ..where((d) => d.dialCode.equals(code))
          ..limit(1))
        .getSingle();
  }

  Future<bool> exists(String id) async => await getOne(id) != null;
  Stream<List<CountryData>> watchAll() => select(country).watch();

  Future add(CountryData data) {
    if (data.dialCode == null) {
      return null;
    }
    return into(country).insert(data);
  }

  Future edit(CountryData data) => update(country).replace(data);
  Future remove(CountryData data) => delete(country).delete(data);

  static CountryData fromMap(Map<String, dynamic> map) {
    return CountryData(
      id: map['id'],
      name: map['name'],
      dialCode: map['dialCode'],
      alpha2Code: map['alpha2Code'],
      alpha3Code: map['alpha3Code'],
      numericCode: map['numericCode'],
      domainExtension: map['domainExtension'],
    );
  }
}
