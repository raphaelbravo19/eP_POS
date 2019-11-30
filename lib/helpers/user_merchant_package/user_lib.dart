import 'user/user_dao.dart';
import 'merchant/merchant_dao.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user/user.dart';
import 'merchant/merchant.dart';

class AppUserInfo {
  static final AppUserInfo _singleton = new AppUserInfo._internal();
  static const String _LOGIN_FLAG = "_LOGIN_FLAG";
  static const String _LOGGED_IN_USER_ID = "_LOGGED_IN_USER_ID";
  static const String _USER_IMAGE = "USER_IMAGE";
  static const String _LOGGED_IN_MERCHANT_ID = "_LOGGED_IN_MERCHANT_ID";
  static const String _AUTH_KEY_CREATION_TIME = "_AUTH_KEY_CREATION_TIME";
  static const String _AUTH_KEY = "_AUTH_KEY";

  factory AppUserInfo() {
    return _singleton;
  }

  AppUserInfo._internal();

  final UserDao _userDao = new UserDao();
  final MerchantDao _merchantDao = new MerchantDao();

  UserDao get userDao => _userDao;

  MerchantDao get merchantDao => _merchantDao;

  Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_LOGIN_FLAG);
  }

  void login(User user, Merchant merchant) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_LOGIN_FLAG, true);
    prefs.setString(_LOGGED_IN_USER_ID, user.id);
    prefs.setString(_LOGGED_IN_MERCHANT_ID, merchant.id);
    prefs.setInt(
        _AUTH_KEY_CREATION_TIME, new DateTime.now().millisecondsSinceEpoch);
    userDao.save(user);
    merchantDao.save(merchant);
  }

  void loginWithJsonValue(
      Map<String, dynamic> user, Map<String, dynamic> merchant) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_LOGIN_FLAG, true);
    prefs.setString(_LOGGED_IN_USER_ID, user['id'].toString());
    prefs.setString(_USER_IMAGE, user['userImage'].toString());
    prefs.setString(_LOGGED_IN_MERCHANT_ID, merchant['merchantId'].toString());
    prefs.setString(_AUTH_KEY, user['auth_key']);
    prefs.setInt(
        _AUTH_KEY_CREATION_TIME, new DateTime.now().millisecondsSinceEpoch);
    userDao.saveJson(user);
    merchantDao.saveJson(merchant);
  }

 void coldLoginWithJsonValue(
      Map<String, dynamic> user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_LOGIN_FLAG, true);
    prefs.setString(_USER_IMAGE, user['userImage'].toString());
    prefs.setString(_AUTH_KEY, user['auth_key']);
    prefs.setInt(
        _AUTH_KEY_CREATION_TIME, new DateTime.now().millisecondsSinceEpoch);
    userDao.saveJson(user);
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_LOGIN_FLAG, false);
  }

  Future<int> lastLoginTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_AUTH_KEY_CREATION_TIME);
  }

  Future<User> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return _userDao.getById(prefs.getString(_LOGGED_IN_USER_ID));
  }

  Future<Merchant> getMerchant() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return _merchantDao.getById(prefs.getString(_LOGGED_IN_MERCHANT_ID));
  }

  Future<String> getAuthKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_AUTH_KEY);
  }

   Future<String> getUserImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_USER_IMAGE);
  }

 Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_LOGGED_IN_USER_ID);
  }

 Future<String> getMerchantId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_LOGGED_IN_MERCHANT_ID);
  }

  void saveUser(User user) async {
    _userDao.save(user);
  }

  void saveMerchant(Merchant merchant) async {
    _merchantDao.save(merchant);
  }
}
