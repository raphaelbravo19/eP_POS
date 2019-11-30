import 'dart:async';
import 'dart:convert';

import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/data/initial/countries/api_service.dart';
import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:epaisa_pos/data/models/attributes_dao.dart';
import 'package:epaisa_pos/data/models/categories_dao.dart';
import 'package:epaisa_pos/data/models/currencys_dao.dart';
import 'package:epaisa_pos/data/models/currentcompanys_dao.dart';
import 'package:epaisa_pos/data/models/currentmerchants_dao.dart';
import 'package:epaisa_pos/data/models/currentstores_dao.dart';
import 'package:epaisa_pos/data/models/currentusers_dao.dart';
import 'package:epaisa_pos/data/models/distributors_dao.dart';
import 'package:epaisa_pos/data/models/fingerprintuser_dao.dart';
import 'package:epaisa_pos/data/models/manufacturers_dao.dart';
import 'package:epaisa_pos/data/models/packages_dao.dart';
import 'package:epaisa_pos/data/models/products_dao.dart';
import 'package:epaisa_pos/data/models/variants_dao.dart';
import 'package:epaisa_pos/helpers/flutter_ortc_plugin/flutter_ortc_plugin.dart';
import 'package:epaisa_pos/helpers/user_merchant_package/user_lib.dart';
import 'package:epaisa_pos/src/networking/networking.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/validators/Validator.dart';
import 'package:epaisa_pos/src/views/dashboard/dashboard_screen.dart';
import 'package:epaisa_pos/src/views/fingerprint/fingerprint_screen.dart';
import 'package:epaisa_pos/src/widgets/utils/dialogs_helper.dart';
import 'package:flutter/material.dart';
import 'package:chopper/chopper.dart' as p1;
import 'package:rxdart/rxdart.dart';

class LoginBloc extends Object with Validators {
  final _username = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final api = ApiService.create();
  CurrentMerchantsDao currentMerchantsDao = new CurrentMerchantsDao(db);
  CurrentCompanysDao currentCompanysDao = new CurrentCompanysDao(db);
  CurrentUsersDao currentUsersDao = new CurrentUsersDao(db);
  CurrentStoresDao currentStoresDao = new CurrentStoresDao(db);
  DistributorsDao distributorsDao = new DistributorsDao(db);
  ManufacturersDao manufacturersDao = new ManufacturersDao(db);
  CategoriesDao categoriesDao = new CategoriesDao(db);
  ProductsDao productsDao = new ProductsDao(db);
  CurrencysDao currencysDao = new CurrencysDao(db);
  FingerprintUserDao fingerprintdao = FingerprintUserDao(db);
  PackagesDao packagesDao = PackagesDao(db);
  VariantsDao variantsDao = VariantsDao(db);
  ProductAttributesDao productAttributesDao = ProductAttributesDao(db);
  //final _password = BehaviorSubject<String>();

  // Add data to stream
  Stream<String> get username => _username.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);

  Stream<bool> get loginValid =>
      Observable.combineLatest2(username, password, (us, pw) => true);

  Function(String) get changeUsername => _username.sink.add;
  Function(String) get changePassword => _password.sink.add;

  loginWithCredentials(
      BuildContext context, bool manual, dynamic response) async {
    if (manual) showLoading(context);
    try {
      var cm = await currentMerchantsDao.getAll();
      var cs = await currentStoresDao.getAll();
      var cc = await currentCompanysDao.getAll();
      var cu = await currentUsersDao.getAll();
      var dt = await distributorsDao.getAll();
      var mf = await manufacturersDao.getAll();
      var ct = await categoriesDao.getAll();
      var pd = await productsDao.getAll();
      var pk = await packagesDao.getAll();
      var vt = await variantsDao.getAll();
      var pa = await productAttributesDao.getAll();
      var res;
      if (manual) {
        res = await api.login({
          "loginType": 1,
          "username": _username.value != null ? _username.value : "",
          "password": _password.value != null ? _password.value : "",
        });
      } else {
        res = response;
      }
      if (cm.length > 0) {
        for (var i = 0; i < cm.length; i++) {
          currentMerchantsDao.remove(cm[i]);
        }
      }
      if (cs.length > 0) {
        for (var i = 0; i < cs.length; i++) {
          currentStoresDao.remove(cs[i]);
        }
      }
      if (cc.length > 0) {
        for (var i = 0; i < cc.length; i++) {
          currentCompanysDao.remove(cc[i]);
        }
      }
      if (cu.length > 0) {
        for (var i = 0; i < cu.length; i++) {
          currentUsersDao.remove(cu[i]);
        }
      }
      if (dt.length > 0) {
        for (var i = 0; i < dt.length; i++) {
          distributorsDao.remove(dt[i]);
        }
      }
      if (mf.length > 0) {
        for (var i = 0; i < mf.length; i++) {
          manufacturersDao.remove(mf[i]);
        }
      }
      if (ct.length > 0) {
        for (var i = 0; i < ct.length; i++) {
          categoriesDao.remove(ct[i]);
        }
      }
      if (pd.length > 0) {
        for (var i = 0; i < pd.length; i++) {
          productsDao.remove(pd[i]);
        }
      }
      if (pk.length > 0) {
        for (var i = 0; i < pk.length; i++) {
          packagesDao.remove(pk[i]);
        }
      }
      if (vt.length > 0) {
        for (var i = 0; i < vt.length; i++) {
          variantsDao.remove(vt[i]);
        }
      }
      if (pa.length > 0) {
        for (var i = 0; i < pa.length; i++) {
          productAttributesDao.remove(pa[i]);
        }
      }
      var data = res.body;
      CurrentUser user = CurrentUsersDao.fromMap(data["user"]);
      var newuser = await api.getProfile(authKey: user.token);
      user = CurrentUsersDao.fromMap(newuser.body["user"]);

      var stores = await api.getStores(authKey: user.token);
      for (var itemData in stores.body['data']) {
        if (!await currentStoresDao.exists(itemData['id'])) {
          final item = CurrentStoresDao.fromMap(itemData);
          await currentStoresDao.add(item);
        }
      }
      var companies = await api.getCompany(authKey: user.token);
      for (var itemData in companies.body['data']) {
        if (!await currentCompanysDao.exists(itemData['id'])) {
          final item = CurrentCompanysDao.fromMap(itemData);
          await currentCompanysDao.add(item);
        }
      }
      var distributors = await api.getDistributors(authKey: user.token);
      if (distributors.body['data'] != null) {
        for (var itemData in distributors.body['data']) {
          if (!await distributorsDao.exists(itemData['id'])) {
            final item = DistributorsDao.fromMap(itemData);
            await distributorsDao.add(item);
          }
        }
      }
      var manufacturers = await api.getManufacturers(authKey: user.token);
      if (manufacturers.body['data'] != null) {
        for (var itemData in manufacturers.body['data']) {
          if (!await manufacturersDao.exists(itemData['id'])) {
            final item = ManufacturersDao.fromMap(itemData);
            await manufacturersDao.add(item);
          }
        }
      }
      var categories = await api.getCategories(authKey: user.token);
      if (categories.body['data'] != null) {
        for (var itemData in categories.body['data']) {
          if (!await categoriesDao.exists(itemData['id'])) {
            final item = CategoriesDao.fromMap(itemData);
            await categoriesDao.add(item);
          }
        }
      }
      var products = await api.getProducts(authKey: user.token);
      if (products.body['data'] != null) {
        for (var itemData in products.body['data']) {
          if (!await productsDao.exists(itemData['id'])) {
            final item = ProductsDao.fromMap(itemData);
            await productsDao.add(item);
          }
        }
      }

      var packages = await api.getPackages(authKey: user.token);
      print("PACKAGE: ${packages.body}");
      if (packages.body['data'] != null) {
        for (var itemData in packages.body['data']) {
          if (!await packagesDao.exists(itemData['id'])) {
            final item = PackagesDao.fromMap(itemData);
            await packagesDao.add(item);
          }
        }
      }
      var variants = await api.getVariants(authKey: user.token);
      print("VARIANTS: ${variants.body}");
      if (variants.body['data'] != null) {
        for (var itemData in variants.body['data']) {
          if (!await variantsDao.exists(itemData['id'])) {
            final item = VariantsDao.fromMap(itemData);
            await variantsDao.add(item);
          }
        }
      }
      var productAttributes = await api.getIndustriesClassifications(
          body: {"industryId": "5dc32371c63c9602d10b71cb"});
      print("ProductAttributes: ${productAttributes.body}");
      if (productAttributes.body['data'] != null) {
        for (var itemData in productAttributes.body['data']) {
          if (!await productAttributesDao.exists(itemData['id'])) {
            final item = ProductAttributesDao.fromMap(itemData);
            await productAttributesDao.add(item);
          }
        }
      }
      print(data);
      // var body =
      // printata = json.decode(res.body);
      //var
      currentMerchantsDao.add(CurrentMerchantsDao.fromMap(data["merchant"]));

      currentUsersDao.add(user);
      var fuser = await fingerprintdao.getAll();
      var isFinger = fuser.length > 0;
      Navigator.pop(context);
      if (manual && !isFinger) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => FingerprintScreen(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardScreen(),
          ),
        );
      }
    } catch (e) {
      print(e);
      if (e.body != null) {
        print(e.body);

        var error = json.decode(e.body);
        Navigator.pop(context);
        showDialogMessage(context, error["message"], () {});
      } else {
        print(e);
        Navigator.pop(context);
      }
    }

    /*Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => FingerprintScreen(),
      ),
    );*/
  }

  getPersistance() async {
    var cu = await currentUsersDao.getAll();

    print(cu);
    return cu.length > 0;
  }

  getDataWithMagic(context, token) async {
    print("TOKEN:$token");
    showLoading(context);
    try {
      var cm = await currentMerchantsDao.getAll();
      var cs = await currentStoresDao.getAll();
      var cc = await currentCompanysDao.getAll();
      var cu = await currentUsersDao.getAll();
      var dt = await distributorsDao.getAll();
      var mf = await manufacturersDao.getAll();
      var ct = await categoriesDao.getAll();
      var pd = await productsDao.getAll();
      var res;

      res = await api.getProfile(authKey: token);
      print(res.body);
      if (cm.length > 0) {
        for (var i = 0; i < cm.length; i++) {
          currentMerchantsDao.remove(cm[i]);
        }
      }
      if (cs.length > 0) {
        for (var i = 0; i < cs.length; i++) {
          currentStoresDao.remove(cs[i]);
        }
      }
      if (cc.length > 0) {
        for (var i = 0; i < cc.length; i++) {
          currentCompanysDao.remove(cc[i]);
        }
      }
      if (cu.length > 0) {
        for (var i = 0; i < cu.length; i++) {
          currentUsersDao.remove(cu[i]);
        }
      }
      if (dt.length > 0) {
        for (var i = 0; i < dt.length; i++) {
          distributorsDao.remove(dt[i]);
        }
      }
      if (mf.length > 0) {
        for (var i = 0; i < mf.length; i++) {
          manufacturersDao.remove(mf[i]);
        }
      }
      if (ct.length > 0) {
        for (var i = 0; i < ct.length; i++) {
          categoriesDao.remove(ct[i]);
        }
      }
      if (pd.length > 0) {
        for (var i = 0; i < pd.length; i++) {
          productsDao.remove(pd[i]);
        }
      }
      var data = res.body;
      var user = CurrentUsersDao.fromMap(data["user"]);
      var stores = await api.getStores(authKey: user.token);
      for (var itemData in stores.body['data']) {
        if (!await currentStoresDao.exists(itemData['id'])) {
          final item = CurrentStoresDao.fromMap(itemData);
          await currentStoresDao.add(item);
        }
      }
      var companies = await api.getCompany(authKey: user.token);
      for (var itemData in companies.body['data']) {
        if (!await currentCompanysDao.exists(itemData['id'])) {
          final item = CurrentCompanysDao.fromMap(itemData);
          await currentCompanysDao.add(item);
        }
      }
      var distributors = await api.getDistributors(authKey: user.token);
      if (distributors.body['data'] != null) {
        for (var itemData in distributors.body['data']) {
          if (!await distributorsDao.exists(itemData['id'])) {
            final item = DistributorsDao.fromMap(itemData);
            await distributorsDao.add(item);
          }
        }
      }
      var manufacturers = await api.getManufacturers(authKey: user.token);
      if (manufacturers.body['data'] != null) {
        for (var itemData in manufacturers.body['data']) {
          if (!await manufacturersDao.exists(itemData['id'])) {
            final item = ManufacturersDao.fromMap(itemData);
            await manufacturersDao.add(item);
          }
        }
      }
      var categories = await api.getCategories(authKey: user.token);
      if (categories.body['data'] != null) {
        for (var itemData in categories.body['data']) {
          if (!await categoriesDao.exists(itemData['id'])) {
            final item = CategoriesDao.fromMap(itemData);
            await categoriesDao.add(item);
          }
        }
      }
      var products = await api.getProducts(authKey: user.token);
      if (products.body['data'] != null) {
        for (var itemData in products.body['data']) {
          if (!await productsDao.exists(itemData['id'])) {
            final item = ProductsDao.fromMap(itemData);
            await productsDao.add(item);
          }
        }
      }
      print(data);
      // var body =
      // printata = json.decode(res.body);
      //var
      currentMerchantsDao.add(CurrentMerchantsDao.fromMap(data["merchant"]));

      currentUsersDao.add(user);
      var fuser = await fingerprintdao.getAll();
      var isFinger = fuser.length > 0;
      Navigator.pop(context);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => FingerprintScreen(),
        ),
      );
    } catch (e) {
      print(e);
      if (e.body != null) {
        print(e.body);

        var error = json.decode(e.body);
        Navigator.pop(context);
        showDialogMessage(context, error["message"], () {});
      } else {
        print(e);
        Navigator.pop(context);
      }
    }
  }

  signOut() async {
    var cm = await currentMerchantsDao.getAll();
    var cs = await currentStoresDao.getAll();
    var cc = await currentCompanysDao.getAll();
    var cu = await currentUsersDao.getAll();
    var dt = await distributorsDao.getAll();
    var mf = await manufacturersDao.getAll();
    var ct = await categoriesDao.getAll();
    var pd = await productsDao.getAll();
    var pa = await productAttributesDao.getAll();

    if (cm.length > 0) {
      for (var i = 0; i < cm.length; i++) {
        currentMerchantsDao.remove(cm[i]);
      }
    }
    if (cs.length > 0) {
      for (var i = 0; i < cs.length; i++) {
        currentStoresDao.remove(cs[i]);
      }
    }
    if (cc.length > 0) {
      for (var i = 0; i < cc.length; i++) {
        currentCompanysDao.remove(cc[i]);
      }
    }
    if (cu.length > 0) {
      for (var i = 0; i < cu.length; i++) {
        currentUsersDao.remove(cu[i]);
      }
    }
    if (dt.length > 0) {
      for (var i = 0; i < dt.length; i++) {
        distributorsDao.remove(dt[i]);
      }
    }
    if (mf.length > 0) {
      for (var i = 0; i < mf.length; i++) {
        manufacturersDao.remove(mf[i]);
      }
    }
    if (ct.length > 0) {
      for (var i = 0; i < ct.length; i++) {
        categoriesDao.remove(ct[i]);
      }
    }
    if (pd.length > 0) {
      for (var i = 0; i < pd.length; i++) {
        productsDao.remove(pd[i]);
      }
    }
    if (pa.length > 0) {
      for (var i = 0; i < pa.length; i++) {
        productAttributesDao.remove(pa[i]);
      }
    }
    /* if (cr.length > 0) {
      for (var i = 0; i < cr.length; i++) {
        currencysDao.remove(cr[i]);
      }
    } */
    print("CLEAN");
  }

  dispose() {
    print('dispose');
    _username.close();
    _password.close();
  }
}

LoginBloc loginBloc = LoginBloc();
