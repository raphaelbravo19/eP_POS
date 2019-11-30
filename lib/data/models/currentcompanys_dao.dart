import 'package:epaisa_pos/data/database.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'currentcompanys_dao.g.dart';

@UseDao(tables: [CurrentCompanys])
class CurrentCompanysDao extends DatabaseAccessor<AppDatabase>
    with _$CurrentCompanysDaoMixin {
  final AppDatabase db;

//   // Called by the AppDatabase class
  CurrentCompanysDao(this.db) : super(db);

  Future<List<CurrentCompany>> getAll() =>
      (select(currentCompanys)..where((d) => d.status.equals(1))).get();

  Future<CurrentCompany> getOne(String id) {
    return (select(currentCompanys)..where((d) => d.id.equals(id))).getSingle();
  }

  Future<bool> exists(String id) async {
    return await getOne(id) != null;
  }

  Stream<List<CurrentCompany>> watchAll() => select(currentCompanys).watch();

  Future add(CurrentCompany data) => into(currentCompanys).insert(data);
  Future edit(CurrentCompany data) => update(currentCompanys).replace(data);
  Future remove(CurrentCompany data) => delete(currentCompanys).delete(data);

  static CurrentCompany fromMap(Map<String, dynamic> map) {
    return CurrentCompany(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      email: map['email'],
      mobile: map['mobile'],
      industryId: map['industry'],
      businessTypeId: map['type'],
      merchantId: map['merchantId'],
      status: map['status'],
      country: map['country'],
      currency: map['currency'],
      gstin: map['gstin'],
      address1: map['address1'],
      address2: map['address2'],
      district: map['district'],
      pinCode: map['pinCode'],
      city: map['city'],
      state: map['state'],
      cityName: map['cityName'],
      stateName: map['stateName'],
      panNumber: map['panNumber'],
      language: map['language'],
    );
  }

  static CurrentCompany fromMapOwn(Map<String, dynamic> map) {
    return CurrentCompany(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      email: map['email'],
      mobile: map['mobile'],
      industryId: map['industryId'],
      businessTypeId: map['businessTypeId'],
      merchantId: map['merchantId'],
      status: map['status'],
    );
  }

  static Map<String, dynamic> toAPI(Map<String, dynamic> map) {
    return {
      "id": map['id'],
      "name": map['name'],
      "image": map['image'],
      "email": map['email'],
      "mobile": map['mobile'],
      "industry": map['industryId'],
      "type": map['businessTypeId'],
      "merchantId": map['merchantId'],
      "status": map['status'],
    };
  }
}
