import '../BaseContract.dart';
import './UserContract.dart';

class UserDao {
  String get createTableQuery => "CREATE TABLE ${UserContract().tableName} ( "
      " ${BaseContract.id} INTEGER PRIMARY KEY,"
      " ${UserContract.name} TEXT,"
      " ${UserContract.age} INTEGER"
      ")";
}
