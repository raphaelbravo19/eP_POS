import 'package:epaisa_pos/data/database.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'authenticated_users_dao.g.dart';

@UseDao(tables: [AuthenticatedUsers])
class AuthenticatedUsersDao extends DatabaseAccessor<AppDatabase>
    with _$AuthenticatedUsersDaoMixin {
  final AppDatabase db;

//   // Called by the AppDatabase class
  AuthenticatedUsersDao(this.db) : super(db);

  Future<List<AuthenticatedUser>> getAll() => select(authenticatedUsers).get();

  Future<AuthenticatedUser> getOne(String id) {
    return (select(authenticatedUsers)..where((d) => d.id.equals(id)))
        .getSingle();
  }

  Future<bool> exists(String id) async {
    return await getOne(id) != null;
  }

  Stream<List<AuthenticatedUser>> watchAll() =>
      select(authenticatedUsers).watch();

  Future add(AuthenticatedUser data) => into(authenticatedUsers).insert(data);
  Future edit(AuthenticatedUser data) =>
      update(authenticatedUsers).replace(data);
  Future remove(AuthenticatedUser data) =>
      delete(authenticatedUsers).delete(data);

  static AuthenticatedUser fromMap(Map<String, dynamic> map) {
    return AuthenticatedUser(
      id: map['id'],
      userId: map['userId'],
      authenticated: map['authenticated'],
    );
  }
}
