import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/data/initial/countries/api_service.dart';
import 'package:epaisa_pos/data/models/authenticated_users_dao.dart';
import 'package:epaisa_pos/data/models/company_dao.dart';
import 'package:epaisa_pos/data/models/stores_dao.dart';
import 'package:epaisa_pos/data/models/users_dao.dart';
import 'package:epaisa_pos/data/models/merchants_dao.dart' as p1;

final db = AppDatabase();

class UserRepository {
  // UserRepository() : true;
  final api = ApiService.create();
  final merchantsDao = p1.MarchantsDao(db);
  final storesDao = StoresDao(db);
  final usersDao = UsersDao(db);
  final companyDao = CompanyDao(db);
  final auDao = AuthenticatedUsersDao(db);
  Future<bool> isSignedIn() async {
    if (!await auDao.exists('currentUser')) {
      return false;
    }
    final authenticatedData = await auDao.getOne('currentUser');

    return authenticatedData.authenticated;
  }

  Future<User> getUser() async {
    final authenticatedData = await auDao.getOne('currentUser');
    final user = await usersDao.getOne(authenticatedData.userId);
    return user;
  }

  Future<void> signOut() async {
    return await auDao.edit(
      AuthenticatedUser(
        authenticated: false,
        userId: null,
        id: 'currentUser',
      ),
    );
  }

  signUp(currentState) async {
    final response = await api.register({
      "firstName": currentState.firstName.value,
      "lastName": currentState.lastName.value,
      "username": currentState.email.value,
      "password": currentState.password.value,
      "mobile": "+1" + currentState.mobileNumber.value,
      "industry": currentState.industry.value,
      "type": currentState.businessType.value
    });
    print(response.body);
    merchantsDao.add(p1.MarchantsDao.fromMap(response.body['merchant']));
    companyDao.add(CompanyDao.fromMap(response.body['company']));
    storesDao.add(StoresDao.fromMap(response.body['store']));
    usersDao.add(UsersDao.fromMap(response.body['user']));
    final currentUser = AuthenticatedUser(
      authenticated: true,
      id: 'currentUser',
      userId: response.body['user']['id'],
    );
    if (await auDao.exists('currentUser')) {
      auDao.edit(currentUser);
    } else {
      auDao.add(currentUser);
    }
    return;
  }

  Future<void> signInWithCredentials(String email, String password) async {
    return ApiService.create().login({"username": email, "password": password});
  }
  // final FirebaseAuth _firebaseAuth;
  // final GoogleSignIn _googleSignIn;

  // UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
  //     : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
  //       _googleSignIn = googleSignin ?? GoogleSignIn();
}
