import 'package:epaisa_pos/data/database.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'users_dao.g.dart';

@UseDao(tables: [Users])
class UsersDao extends DatabaseAccessor<AppDatabase> with _$UsersDaoMixin {
  final AppDatabase db;

//   // Called by the AppDatabase class
  UsersDao(this.db) : super(db);

  Future<List<User>> getAll() => select(users).get();

  Future<User> getOne(String id) {
    return (select(users)..where((d) => d.id.equals(id))).getSingle();
  }

  Future<bool> exists(String id) async {
    return await getOne(id) != null;
  }

  Stream<List<User>> watchAll() => select(users).watch();

  Future add(User data) => into(users).insert(data);
  Future edit(User data) => update(users).replace(data);
  Future remove(User data) => delete(users).delete(data);

  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      mobile: map['mobile'],
      unverifiedMobile: map['unverifiedMobile'],
      username: map['username'],
      unverifiedUsername: map['unverifiedUsername'],
      merchantId: map['merchantId'],
      storeId: map['storeId'],
      token: map['token'],
      status: map['status'],
    );
  }
}
