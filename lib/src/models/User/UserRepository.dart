import 'package:epaisa_pos/src/models/BaseContract.dart';
import '../DatabaseRepository.dart';
import './User.dart';
import './UserContract.dart';
import 'package:flutter/material.dart';

class UserRepository extends DatabaseRepository<User> {
  UserRepository(BuildContext context) : super();

  @override
  String getTableName() {
    return UserContract().tableName;
  }

  @override
  User fromJson(Map query) {
    User user = new User();
    user.id = query[BaseContract.id];
    user.name = query[UserContract.name];
    user.age = query[UserContract.age];
    return user;
  }

  @override
  Map<String, dynamic> toMap(User user) {
    return <String, dynamic>{
      BaseContract.id: user.id,
      UserContract.name: user.name,
      UserContract.age: user.age,
    };
  }

  @override
  List<User> fromList(List<Map<String, dynamic>> query) {
    List<User> userList = List<User>();
    for (Map map in query) {
      userList.add(fromMap(map));
    }
    return userList;
  }

  @override
  Future<User> fromListOne(List<Map<String, dynamic>> query) async {
    User user = new User();
    for (int i = 0; i < query.length; i++) {
      Map map = query[i];
      user = fromMap(map);
    }
    return user;
  }

  @override
  User fromMap(Map<String, dynamic> query) {
    User user = new User();
    user.id = query[UserContract.id];
    user.name = query[UserContract.name];
    user.age = query[UserContract.age];
    return user;
  }
}
