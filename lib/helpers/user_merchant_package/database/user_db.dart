import '../../base/base_database_helper.dart';
import '../database/user_db_contract.dart';

class UserDb extends BaseDbHelper {
  static final UserDb _singleton = new UserDb._internal(new UserDbContract());

  factory UserDb() {
    return _singleton;
  }

  UserDb._internal(UserDbContract contract) {
    super.contract = contract;
  }
}
