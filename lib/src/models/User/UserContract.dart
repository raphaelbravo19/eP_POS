import 'package:epaisa_pos/src/models/BaseContract.dart';

class UserContract implements BaseContract {
  String get tableName => 'users';
  static final String id = 'id';
  static final String name = 'name';
  static final String age = 'age';
  UserContract();
}
