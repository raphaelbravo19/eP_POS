import 'dart:convert' as JSON;

import 'package:epaisa_pos/data/database.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'distributors_dao.g.dart';

@UseDao(tables: [Distributors])
class DistributorsDao extends DatabaseAccessor<AppDatabase>
    with _$DistributorsDaoMixin {
  final AppDatabase db;

//   // Called by the AppDatabase class
  DistributorsDao(this.db) : super(db);

  Future<List<Distributor>> getAll() => select(distributors).get();

  Future<Distributor> getOne(String id) {
    return (select(distributors)..where((d) => d.id.equals(id))).getSingle();
  }

  Future<bool> exists(String id) async {
    return await getOne(id) != null;
  }

  Stream<List<Distributor>> watchAll() => select(distributors).watch();

  Future add(Distributor data) => into(distributors).insert(data);
  Future edit(Distributor data) => update(distributors).replace(data);
  Future remove(Distributor data) => delete(distributors).delete(data);

  static Distributor fromMap(Map<String, dynamic> map) {
    return Distributor(
        id: map['id'],
        name: map['name'],
        image: map['image'],
        firstName: map['firstName'],
        lastName: map['lastName'],
        mail: map['mail'],
        mobile: map['mobile'],
        merchantId: map['merchantId'],
        gstin: map['gstin'],
        address1: map['address1'],
        address2: map['address2'],
        pinCode: map['pinCode'],
        district: map['district'],
        areaId: map['areaId'],
        cityId: map['cityId'],
        stateId: map['stateId'],
        since: map['since'],
        countryId: map['countryId'],
        stateName: map['stateName'],
        cityName: map['cityName'],
        countryName: map['countryName'],
        localId: map['localId'],
        status: map['status'],
        products:
            JSON.jsonEncode(map["products"] != null ? map["products"] : []));
  }

  static Map<String, dynamic> toAPI(Distributor d) {
    return {
      "id": d.id,
      "name": d.name,
      "image": d.image,
      "firstName": d.firstName,
      "lastName": d.lastName,
      "mail": d.mail,
      "mobile": d.mobile,
      "merchantId": d.merchantId,
      "gstin": d.gstin,
      "address1": d.address1,
      "address2": d.address2,
      "pinCode": d.pinCode,
      "district": d.district,
      "areaId": d.areaId,
      "cityId": d.cityId,
      "stateId": d.stateId,
      "localId": d.localId,
      "status": d.status,
      "products": d.products != null ? JSON.jsonDecode(d.products) : []
    };
  }
}
