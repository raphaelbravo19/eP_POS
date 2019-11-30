import '../../base/database_contract.dart';
import '../user/user_constant.dart';
import '../merchant/merchant_constant.dart';

class UserDbContract extends DatabaseContract {
  @override
  int getVersion() {
    return 1;
  }

  @override
  List<String> getUpdateQueries() {}

  @override
  List<String> getDropQueries() {}

  @override
  List<String> getCreateQueries() {
    List<String> queries = new List();
    queries.add(CREATE_USER_TABLE_QUERY);
    queries.add(CREATE_MERCHANT_TABLE_QUERY);
    return queries;
  }

  @override
  String getDatabaseName() {
    // TODO: implement getDatabaseName
    return 'user.db';
  }
}
