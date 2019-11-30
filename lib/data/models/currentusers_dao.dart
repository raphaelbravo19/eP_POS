import 'package:epaisa_pos/data/database.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'currentusers_dao.g.dart';

@UseDao(tables: [CurrentUsers])
class CurrentUsersDao extends DatabaseAccessor<AppDatabase>
    with _$CurrentUsersDaoMixin {
  final AppDatabase db;

//   // Called by the AppDatabase class
  CurrentUsersDao(this.db) : super(db);

  Future<List<CurrentUser>> getAll() => select(currentUsers).get();

  Future<CurrentUser> getOne(String id) {
    return (select(currentUsers)..where((d) => d.id.equals(id))).getSingle();
  }

  Future<bool> exists(String id) async {
    return await getOne(id) != null;
  }

  Stream<List<CurrentUser>> watchAll() => select(currentUsers).watch();

  Future add(CurrentUser data) => into(currentUsers).insert(data);
  Future edit(CurrentUser data) => update(currentUsers).replace(data);
  Future remove(CurrentUser data) => delete(currentUsers).delete(data);

  static CurrentUser fromMap(Map<String, dynamic> map) {
    return CurrentUser(
      id: map['id'],
      //roleId: map["roleId"],
      firstName: map['firstName'],
      lastName: map['lastName'],
      mobile: map['mobile'],
      unverifiedMobile: map['unverifiedMobile'],
      username: map['username'],
      city: map['city'],
      state: map['state'],
      country: map['country'],
      cityName: map['cityName'],
      stateName: map['stateName'],
      countryName: map['countryName'],
      address1: map['address1'],
      address2: map['address2'],
      district: map['district'],
      pinCode: map['pinCode'],
      unverifiedUsername: map['unverifiedUsername'],
      merchantId: map['merchantId'],
      storeId: map['storeId'],
      token: map['token'],
      status: map['status'],
    );
  }
}
