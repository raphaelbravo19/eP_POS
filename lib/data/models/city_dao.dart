import 'package:epaisa_pos/data/database.dart';
import 'package:moor_flutter/moor_flutter.dart';
part 'city_dao.g.dart';

@UseDao(tables: [City])
class CityDao extends DatabaseAccessor<AppDatabase> with _$CityDaoMixin {
  final AppDatabase db;

  // Called by the AppDatabase class
  CityDao(this.db) : super(db);

  Future<List<CityData>> getAllCities() => select(city).get();
  Future<CityData> getSingleCity(String id) =>
      (select(city)..where((d) => d.id.equals(id))).getSingle();
  Future<bool> cityExists(String id) async => await getSingleCity(id) != null;
  Stream<List<CityData>> watchAllCities() => select(city).watch();
  
  Future insertCity(CityData data) => into(city).insert(data);
  Future updateCity(CityData data) => update(city).replace(data);
  Future deleteCity(CityData data) => delete(city).delete(data);
}
