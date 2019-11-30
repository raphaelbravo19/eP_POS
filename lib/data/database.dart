import 'package:moor_flutter/moor_flutter.dart';
part 'database.g.dart';

@UseMoor(tables: [
  Country,
  Units,
  Areas,
  City,
  CountryStates,
  Industry,
  BusinessType,
  Taxs,
  Stores,
  Company,
  Merchants,
  Users,
  AuthenticatedUsers,
  CurrentMerchants,
  CurrentCompanys,
  CurrentStores,
  CurrentUsers,
  Distributors,
  Manufacturers,
  Categories,
  Products,
  FingerprintUser,
  Packages,
  Variants,
  Currencys,
  TransactionTypes,
  ProductAttributes
])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(
          FlutterQueryExecutor.inDatabaseFolder(
              path: 'db.sqlite', logStatements: true),
        );

  @override
  int get schemaVersion => 1;
}

class Country extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get dialCode => integer()();
  TextColumn get domainExtension => text().nullable()();
  TextColumn get alpha2Code => text().withLength(min: 2, max: 2)();
  TextColumn get alpha3Code => text().withLength(min: 3, max: 3)();
  IntColumn get numericCode => integer()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  // @override
  Set<Column> get primaryKey => {id};
}

class City extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  // @override
  Set<Column> get primaryKey => {id};
}

class CountryStates extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get countryId => text()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  // @override
  Set<Column> get primaryKey => {id};
}

class Areas extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get cityId => text()();
  TextColumn get pinCode => text()();
  TextColumn get taluka => text()();
  IntColumn get status => integer()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}

class Units extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}

class Industry extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get level => integer().nullable()();
  TextColumn get industryParentId => text().nullable()();
  TextColumn get parentId => text().nullable()();
  IntColumn get status => integer()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  // @override
  Set<Column> get primaryKey => {id};
}

class BusinessType extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get status => integer()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}

class Taxs extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get countryId => text()();
  TextColumn get taxType => text()();
  IntColumn get slab => integer()();
  IntColumn get taxValue => integer()();
  TextColumn get taxMode => text()();
  TextColumn get displayName1 => text()();
  TextColumn get displayName2 => text()();
  TextColumn get displayName3 => text()();
  IntColumn get cgstValue => integer()();
  IntColumn get sgstValue => integer()();
  IntColumn get igstValue => integer()();

  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  Set<Column> get primaryKey => {id};
}

class Stores extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get merchantId => text()();
  TextColumn get companyId => text()();
  IntColumn get status => integer()();

  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  Set<Column> get primaryKey => {id};
}

class Company extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get industryId => text()();
  TextColumn get businessTypeId => text()();
  TextColumn get merchantId => text()();
  IntColumn get status => integer()();

  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  Set<Column> get primaryKey => {id};
}

class Merchants extends Table {
  TextColumn get id => text()();
  TextColumn get planId => text()();
  IntColumn get status => integer()();

  Set<Column> get primaryKey => {id};
}

class Users extends Table {
  TextColumn get id => text()();
  TextColumn get mobile => text()();
  TextColumn get unverifiedMobile => text()();
  TextColumn get username => text()();
  TextColumn get unverifiedUsername => text()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  TextColumn get merchantId => text()();
  TextColumn get storeId => text()();
  TextColumn get token => text()();
  IntColumn get status => integer()();

  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  Set<Column> get primaryKey => {id};
}

class AuthenticatedUsers extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text().nullable()();
  BoolColumn get authenticated =>
      boolean().withDefault(const Constant(false))();

  Set<Column> get primaryKey => {id};
}

class CurrentMerchants extends Table {
  TextColumn get id => text()();
  TextColumn get plan => text()();
  IntColumn get status => integer()();

  Set<Column> get primaryKey => {id};
}

class CurrentCompanys extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get email => text().nullable()();
  TextColumn get mobile => text().nullable()();
  TextColumn get industryId => text().nullable()();
  TextColumn get businessTypeId => text().nullable()();
  TextColumn get country => text().nullable()();
  TextColumn get panNumber => text().nullable()();
  TextColumn get gstin => text().nullable()();
  TextColumn get currency => text().nullable()();
  TextColumn get language => text().nullable()();
  TextColumn get pinCode => text().nullable()();
  TextColumn get address1 => text().nullable()();
  TextColumn get address2 => text().nullable()();
  TextColumn get state => text().nullable()();
  TextColumn get city => text().nullable()();
  TextColumn get stateName => text().nullable()();
  TextColumn get cityName => text().nullable()();
  TextColumn get district => text().nullable()();

  TextColumn get merchantId => text()();
  TextColumn get image => text().nullable()();
  IntColumn get status => integer()();

  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  Set<Column> get primaryKey => {id};
}

class CurrentUsers extends Table {
  TextColumn get id => text()();
  TextColumn get mobile => text()();
  TextColumn get unverifiedMobile => text()();
  TextColumn get username => text()();
  TextColumn get unverifiedUsername => text()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  TextColumn get merchantId => text()();
  TextColumn get storeId => text()();
  TextColumn get token => text()();
  IntColumn get status => integer()();
  TextColumn get address1 => text().nullable()();
  TextColumn get address2 => text().nullable()();
  TextColumn get city => text().nullable()();
  TextColumn get state => text().nullable()();
  TextColumn get country => text().nullable()();
  TextColumn get district => text().nullable()();
  TextColumn get pinCode => text().nullable()();
  TextColumn get cityName => text().nullable()();
  TextColumn get stateName => text().nullable()();
  TextColumn get countryName => text().nullable()();

  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  Set<Column> get primaryKey => {id};
}

class CurrentStores extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get merchantId => text()();
  TextColumn get companyId => text()();
  TextColumn get pinCode => text().nullable()();
  TextColumn get district => text().nullable()();
  TextColumn get currency => text().nullable()();
  TextColumn get language => text().nullable()();
  TextColumn get area => text().nullable()();
  TextColumn get cityId => text().nullable()();
  TextColumn get stateId => text().nullable()();
  TextColumn get countryId => text().nullable()();
  TextColumn get cityName => text().nullable()();
  TextColumn get stateName => text().nullable()();
  TextColumn get countryName => text().nullable()();
  TextColumn get address1 => text().nullable()();
  TextColumn get address2 => text().nullable()();
  BoolColumn get invoice => boolean().nullable()();
  TextColumn get invoicePrefix => text().nullable()();
  TextColumn get invoiceStart => text().nullable()();

  IntColumn get status => integer()();

  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  Set<Column> get primaryKey => {id};
}

class Distributors extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get image => text().nullable()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  TextColumn get mail => text().nullable()();
  TextColumn get mobile => text().nullable()();
  TextColumn get merchantId => text()();
  TextColumn get since => text().nullable()();
  TextColumn get gstin => text().nullable()();
  TextColumn get address1 => text().nullable()();
  TextColumn get address2 => text().nullable()();
  TextColumn get pinCode => text().nullable()();
  TextColumn get district => text().nullable()();
  TextColumn get areaId => text().nullable()();
  TextColumn get cityId => text().nullable()();
  TextColumn get countryId => text().nullable()();
  TextColumn get stateId => text().nullable()();
  TextColumn get cityName => text().nullable()();
  TextColumn get stateName => text().nullable()();
  TextColumn get countryName => text().nullable()();
  TextColumn get products => text().nullable()();
  TextColumn get localId => text().nullable()();
  IntColumn get status => integer()();

  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  Set<Column> get primaryKey => {id};
}

class Manufacturers extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get mobile => text().nullable()();
  TextColumn get image => text().nullable()();
  TextColumn get mail => text().nullable()();
  TextColumn get merchantId => text()();
  TextColumn get gstin => text().nullable()();
  TextColumn get address1 => text().nullable()();
  TextColumn get address2 => text().nullable()();
  TextColumn get pinCode => text().nullable()();
  TextColumn get district => text().nullable()();
  TextColumn get products => text().nullable()();
  TextColumn get areaId => text().nullable()();
  TextColumn get cityId => text().nullable()();
  TextColumn get stateId => text().nullable()();
  TextColumn get countryId => text().nullable()();
  TextColumn get cityName => text().nullable()();
  TextColumn get stateName => text().nullable()();
  TextColumn get countryName => text().nullable()();
  IntColumn get status => integer()();

  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  Set<Column> get primaryKey => {id};
}

class Categories extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get merchantId => text()();
  TextColumn get storeId => text()();
  TextColumn get color => text().nullable()();
  TextColumn get parent => text().nullable()();
  TextColumn get children => text().nullable()();
  TextColumn get products => text().nullable()();
  TextColumn get images => text().nullable()();
  IntColumn get status => integer()();

  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  Set<Column> get primaryKey => {id};
}

class Products extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get unitId => text()();
  TextColumn get merchantId => text()();
  TextColumn get distributors => text().nullable()();
  TextColumn get manufacturerId => text().nullable()();
  TextColumn get variants => text().nullable()();
  TextColumn get categories => text().nullable()();
  TextColumn get images => text().nullable()();
  TextColumn get storeId => text()();
  TextColumn get hsn => text().nullable()();
  IntColumn get status => integer()();

  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  Set<Column> get primaryKey => {id};
}

class FingerprintUser extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();

  Set<Column> get primaryKey => {id};
}

class Packages extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get unitId => text().nullable()();
  RealColumn get price => real().nullable()();
  TextColumn get sku => text().nullable()();
  TextColumn get categories => text().nullable()();
  IntColumn get inventory => integer().nullable()();
  IntColumn get threshold => integer().nullable()();

  TextColumn get image => text().nullable()();
  TextColumn get list => text().nullable()();
  TextColumn get barcode => text().nullable()();
  IntColumn get gst => integer().nullable()();
  IntColumn get vat => integer().nullable()();
  IntColumn get cess => integer().nullable()();
  BoolColumn get isGst => boolean().nullable()();
  BoolColumn get isVat => boolean().nullable()();
  TextColumn get merchantId => text().nullable()();
  TextColumn get storeId => text().nullable()();
  TextColumn get localId => text().nullable()();
  IntColumn get status => integer()();

  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  Set<Column> get primaryKey => {id};
}

class Variants extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  RealColumn get price => real().nullable()();
  TextColumn get barcode => text().nullable()();
  TextColumn get sku => text().nullable()();
  TextColumn get attributes => text().nullable()();
  IntColumn get inventory => integer().nullable()();
  IntColumn get mrp => integer().nullable()();
  IntColumn get threshold => integer().nullable()();
  IntColumn get gst => integer().nullable()();
  IntColumn get vat => integer().nullable()();
  IntColumn get cess => integer().nullable()();
  TextColumn get merchantId => text().nullable()();
  TextColumn get productId => text().nullable()();
  TextColumn get storeId => text().nullable()();
  IntColumn get status => integer()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  Set<Column> get primaryKey => {id};
}

class Currencys extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get code => text()();
  IntColumn get status => integer()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  Set<Column> get primaryKey => {id};
}

class TransactionTypes extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get parentId => text().nullable()();
  TextColumn get displayName => text()();
  RealColumn get providerCommision => real().nullable()();
  RealColumn get epaisaCommision => real().nullable()();
  RealColumn get serviceTax => real().nullable()();
  RealColumn get mdr => real().nullable()();
  TextColumn get credentials => text().nullable()();
  TextColumn get extraFields => text().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  Set<Column> get primaryKey => {id};
}

class ProductAttributes extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  BoolColumn get isRequired => boolean().nullable()();
  BoolColumn get isVariant => boolean().nullable()();
  IntColumn get position => integer().nullable()();
  TextColumn get type => text().nullable()();
  TextColumn get industryId => text().nullable()();
  IntColumn get status => integer().nullable()();

  Set<Column> get primaryKey => {id};
}

/* 
"id": "5d9df16abbc8d8001bd9f1fd",
            "object": "product",
            "name": "Product #1",
            "unitId": "5d9313fe4a3e9f2da83f2c4a",
            "merchantId": "5d921362fda696001b0865b6",
            "storeId": "5d921362fda696001b0865b9",
            "status": 1,
            "createdAt": "Wed Oct 09 2019 14:40:42 GMT+0000 (Coordinated Universal Time)",
            "updatedAt": "Wed Oct 09 2019 14:40:42 GMT+0000 (Coordinated Universal Time)"*/
