import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'areas_dao.g.dart';

class AreaWithCity {
  final CityData city;
  final Area area;
  AreaWithCity(this.city, this.area);
}

@UseDao(tables: [Areas, City])
class AreasDao extends DatabaseAccessor<AppDatabase> with _$AreasDaoMixin {
  final AppDatabase db;

//   // Called by the AppDatabase class
  AreasDao(this.db) : super(db);

  Future<List<AreaWithCity>> getAllAreasWithCity() async {
    final data = await (select(areas).join([
      leftOuterJoin(city, city.id.equalsExp(areas.cityId)),
    ]).get());

    return data.map((row) {
      final cityData = row.readTable(city);
      final areaData = row.readTable(areas);
      return AreaWithCity(cityData, areaData);
    }).toList();
  }

  Future<List<Area>> getAllAreas() => select(areas).get();
  Future<List<Area>> getByCity(String cityId) {
    return (select(areas)..where((area) => area.cityId.equals(cityId))).get();
  }

  Future<Area> getSingleArea(String id) {
    return (select(areas)..where((d) => d.id.equals(id))).getSingle();
  }

  Future<bool> areaExists(String id) async {
    return await getSingleArea(id) != null;
  }

  Stream<List<Area>> watchAllAreas() => select(areas).watch();

  Future insertArea(Area data) => into(areas).insert(data);
  Future updateArea(Area data) => update(areas).replace(data);
  Future deleteArea(Area data) => delete(areas).delete(data);
}
