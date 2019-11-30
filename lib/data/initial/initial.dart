import 'dart:convert';

import 'package:epaisa_pos/data/models/business_type_dao.dart';
import 'package:epaisa_pos/data/models/currencys_dao.dart';
import 'package:epaisa_pos/data/models/taxs_dao.dart';
import 'package:epaisa_pos/data/models/transaction_types_dao.dart';
import 'package:epaisa_pos/src/widgets/utils/dialogs_helper.dart';
import 'package:epaisa_pos/src/widgets/utils/request_helper.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/data/initial/countries/api_service.dart';
import 'package:epaisa_pos/data/models/areas_dao.dart';
import 'package:epaisa_pos/data/models/city_dao.dart';
import 'package:epaisa_pos/data/models/country_dao.dart';
import 'package:epaisa_pos/data/models/country_states_dao.dart';
import 'package:epaisa_pos/data/models/industry_dao.dart';
import 'package:epaisa_pos/data/models/units_dao.dart';
import 'package:moor_flutter/moor_flutter.dart';

final db = AppDatabase();

class Initial {
  final countryDao = CountryDao(db);
  final unitsDao = UnitsDao(db);
  final areasDao = AreasDao(db);
  final cityDao = CityDao(db);
  final statesDao = CountryStatesDao(db);
  final industryDao = IndustryDao(db);
  final businessTypeDao = BusinessTypeDao(db);
  final taxsDao = TaxsDao(db);
  final currencysDao = CurrencysDao(db);
  final transactionTypesDao = TransactionTypesDao(db);
  final api = ApiService.create();

  store({
    @required Function getData,
    @required Function mapItem,
    @required dynamic dao,
  }) async {
    final data = await getData();
    if (data.body["data"] != null) {
      for (var itemData in data.body['data']) {
        if (!await dao.exists(itemData['id'])) {
          final item = mapItem(itemData);
          await dao.add(item);
        }
      }
    }
    return await dao.getAll();
  }

  Future<List<CountryData>> storeCountries() async {
    return await store(
      getData: api.getCountries,
      dao: countryDao,
      mapItem: CountryDao.fromMap,
    );
  }

  Future<List<Unit>> storeUnits() async {
    return await store(
      getData: api.getUnits,
      dao: unitsDao,
      mapItem: UnitsDao.fromMap,
    );
  }

  Future<List<CountryState>> storeStates() async {
    return await store(
      getData: api.getStates,
      dao: statesDao,
      mapItem: CountryStatesDao.fromMap,
    );
  }

  Future<List<IndustryData>> storeIndustries() async {
    return await store(
      getData: api.getIndustries,
      dao: industryDao,
      mapItem: IndustryDao.fromMap,
    );
  }

  Future<List<Tax>> storeTaxes() async {
    return await store(
      getData: api.getTaxes,
      dao: taxsDao,
      mapItem: TaxsDao.fromMap,
    );
  }

  Future<List<TransactionType>> storeTransactionTypes() async {
    return await store(
      getData: api.getTransactionTypes,
      dao: transactionTypesDao,
      mapItem: TransactionTypesDao.fromMap,
    );
  }

  Future<List<BusinessTypeData>> storeBusinessTypes() async {
    return await store(
      getData: api.getBusinessTypes,
      dao: businessTypeDao,
      mapItem: BusinessTypeDao.fromMap,
    );
  }

  Future<List<Currency>> storeCurrencys() async {
    return await store(
      getData: api.getCurrency,
      dao: currencysDao,
      mapItem: CurrencysDao.fromMap,
    );
  }

  Future init() async {
    print('Data Initialization...');

    var countries = await countryDao.getAll();

    if (countries.length < 208) {
      countries = await storeCountries();
      print('Countries Inserted!');
    }
    print('Countries Ready! ${countries.length} countries added.');

    /* var transactionsType = await transactionTypesDao.getAll();

    if (transactionsType.length == 0) {
      transactionsType = await storeTransactionTypes();
      print('Transactions Inserted!');
    }
    print('Transactions Ready! ${transactionsType.length} transactions added.');
 */
    var units = await unitsDao.getAll();
    if (units.length == 0) {
      units = await storeUnits();
      print('Units Inserted!');
    }
    print('Units Ready! ${units.length} units added.');

    var states = await statesDao.getAll();
    if (states.length == 0) {
      states = await storeStates();
      print('States Inserted!');
    }
    print('States Ready! ${states.length} states added.');

    var currencys = await currencysDao.getAll();
    if (currencys.length == 0) {
      currencys = await storeCurrencys();
      print('Currencys Inserted!');
    }
    print('Currencys Ready! ${currencys.length} urrencys added.');
    /*var taxs = await taxsDao.getAll();
    if (taxs.length == 0) {
      taxs = await storeTaxes();
      print('Taxes Inserted!');
    }
    print('Taxes Ready! ${taxs.length} taxes added.');
    */
    var industry = await industryDao.getAll();
    if (industry.length == 0) {
      industry = await storeIndustries();
      print('Industry Inserted!');
    }
    print('Industries Ready! ${industry.length} industries added.');

    var businessType = await businessTypeDao.getAll();
    if (businessType.length == 0) {
      businessType = await storeBusinessTypes();
      print('BusinessType Inserted!');
    }
    print('BusinessTypes Ready! ${businessType.length} businessTypes added.');
  }
}
