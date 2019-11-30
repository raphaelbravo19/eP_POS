import 'package:epaisa_pos/data/database.dart';
import 'package:moor_flutter/moor_flutter.dart';
part 'country_states_dao.g.dart';

@UseDao(tables: [CountryStates])
class CountryStatesDao extends DatabaseAccessor<AppDatabase>
    with _$CountryStatesDaoMixin {
  final AppDatabase db;

  // Called by the AppDatabase class
  CountryStatesDao(this.db) : super(db);

  Future<List<CountryState>> getAll() => select(countryStates).get();
  Future<CountryState> getOne(String id) =>
      (select(countryStates)..where((d) => d.id.equals(id))).getSingle();
  Future<bool> exists(String id) async => await getOne(id) != null;
  Stream<List<CountryState>> watchAll() => select(countryStates).watch();

  Future add(CountryState data) => into(countryStates).insert(data);
  Future edit(CountryState data) => update(countryStates).replace(data);
  Future remove(CountryState data) => delete(countryStates).delete(data);

  static CountryState fromMap(Map<String, dynamic> map) {
    return CountryState(
      id: map['id'],
      name: map['name'],
      countryId: map['country'],
    );
  }
}
