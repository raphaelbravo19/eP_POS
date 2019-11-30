import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:epaisa_pos/data/models/currentusers_dao.dart';

void getToken(Function req) async {
  CurrentUsersDao userdao = CurrentUsersDao(db);
  var user = await userdao.getAll();
  var token = user[0].token;
  await req(token);
}

Future<String> getauthkey() async {
  CurrentUsersDao userdao = CurrentUsersDao(db);
  var user = await userdao.getAll();
  var token = user[0].token;
  return token;
}

Future<String> getmerchantid() async {
  CurrentUsersDao userdao = CurrentUsersDao(db);
  var user = await userdao.getAll();
  var token = user[0].merchantId;
  return token;
}

Future<String> getuserid() async {
  CurrentUsersDao userdao = CurrentUsersDao(db);
  var user = await userdao.getAll();
  var token = user[0].id;
  return token;
}

Future isLogged() async {
  CurrentUsersDao currentUsersDao = new CurrentUsersDao(db);
  var cu = await currentUsersDao.getAll();

  return cu.length > 0;
}
