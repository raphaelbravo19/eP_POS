import 'dart:convert';

import 'package:epaisa_pos/data/database.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'manufacturers_dao.g.dart';

@UseDao(tables: [Manufacturers])
class ManufacturersDao extends DatabaseAccessor<AppDatabase>
    with _$ManufacturersDaoMixin {
  final AppDatabase db;

//   // Called by the AppDatabase class
  ManufacturersDao(this.db) : super(db);

  Future<List<Manufacturer>> getAll() => select(manufacturers).get();

  Future<Manufacturer> getOne(String id) {
    return (select(manufacturers)..where((d) => d.id.equals(id))).getSingle();
  }

  Future<bool> exists(String id) async {
    return await getOne(id) != null;
  }

  Stream<List<Manufacturer>> watchAll() => select(manufacturers).watch();

  Future add(Manufacturer data) => into(manufacturers).insert(data);
  Future edit(Manufacturer data) => update(manufacturers).replace(data);
  Future remove(Manufacturer data) => delete(manufacturers).delete(data);

  static Manufacturer fromMap(Map<String, dynamic> map) {
    var list = map["products"] != null ? map["products"] : [];
    List<String> productList = new List<String>();
    for (var i = 0; i < list.length; i++) {
      productList.add(list[i].toString());
    }

    return Manufacturer(
      id: map['id'],
      name: map['name'],
      mail: map['mail'],
      mobile: map['mobile'],
      image: map["image"],
      merchantId: map['merchantId'],
      gstin: map['gstin'],
      address1: map['address1'],
      address2: map['address2'],
      pinCode: map['pinCode'],
      district: map['district'],
      products: json.encode(map["products"] != null ? map["products"] : []),
      areaId: map['areaId'],
      cityId: map['cityId'],
      countryId: map['countryId'],
      cityName: map['cityName'],
      stateName: map['stateName'],
      countryName: map['countryName'],
      stateId: map['stateId'],
      status: map['status'],
    );
  }
}
