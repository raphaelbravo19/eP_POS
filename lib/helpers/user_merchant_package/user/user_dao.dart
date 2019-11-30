import '../../base/base_dao.dart';
import 'user.dart';
import '../database/user_db.dart';
import 'user_builder.dart';
import 'user_constant.dart';

class UserDao extends Dao<User> {
  UserDao() : super(new UserDb(), new UserBuilder());

  @override
  String getTableName() {
    return TABLE_NAME;
  }
}
