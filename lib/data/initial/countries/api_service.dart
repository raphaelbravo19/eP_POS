import 'dart:io';

import 'package:chopper/chopper.dart';

part 'api_service.chopper.dart';

final baseUrl = 'https://d.mobile.epaisa.com/v1/';

@ChopperApi()
abstract class ApiService extends ChopperService {
  @Get(path: '/countries')
  Future<Response> getCountries();

  @Get(path: '/units')
  Future<Response> getUnits();

  @Get(path: '/currencies')
  Future<Response> getCurrency();

  @Get(path: '/transactionTypes')
  Future<Response> getTransactionTypes();

  @Get(path: '/areas')
  Future<Response> getAreas();

  @Get(path: '/areas?pinCode={id}')
  Future<Response> getPincode(
    @Path('id') String id,
  );

  @Get(path: '/cities')
  Future<Response> getCities();

  @Get(path: '/cities?id={id}')
  Future<Response> getCity(
    @Path('id') String id,
  );
  @Get(path: '/states')
  Future<Response> getStates();
  @Get(path: '/states/{id}')
  Future<Response> getState(
    @Path('id') String id,
  );
  @Get(path: '/industries')
  Future<Response> getIndustries();

  @Get(path: '/industryClassification')
  Future<Response> getIndustriesClassifications({
    @Body() Map<String, dynamic> body,
  });

  @Get(path: '/businessTypes')
  Future<Response> getBusinessTypes();

  //STORES
  @Get(path: '/stores')
  Future<Response> getStores({
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });
  @Post(path: '/stores')
  Future<Response> createStore({
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });

  @Put(path: '/stores/{id}')
  Future<Response> updateStore({
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });

  @Delete(path: '/stores/{id}')
  Future<Response> deleteStore({
    @Path('id') String id,
    @Header('Authorization') String authKey,
  });

  //CRUD USERS
  @Get(path: '/users')
  Future<Response> getUsers({
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });

  @Post(path: '/users')
  Future<Response> createUsers({
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });

  @Put(path: '/users/{id}')
  Future<Response> updateUsers({
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });

  @Delete(path: '/users/{id}')
  Future<Response> deleteUsers({
    @Path('id') String id,
    @Header('Authorization') String authKey,
  });

  //CRUD COMPANIES
  @Get(path: '/companies')
  Future<Response> getCompany({
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });

  @Post(path: '/companies')
  Future<Response> createCompany({
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });

  @Put(path: '/companies/{id}')
  Future<Response> updateCompany({
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });

  @Delete(path: '/companies/{id}')
  Future<Response> deleteCompany({
    @Path('id') String id,
    @Header('Authorization') String authKey,
  });
  //TAX
  @Get(path: '/taxslabs')
  Future<Response> getTaxes();
  //CRUD DISTRIBUTORS
  @Get(path: '/distributors')
  Future<Response> getDistributors({
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });
  @Post(path: '/distributors')
  Future<Response> createDistributor({
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });

  @Put(path: '/distributors/{id}')
  Future<Response> updateDistributor({
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });

  @Put(path: '/distributors/{id}/products')
  Future<Response> addProductsToDistributor({
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });

  @Delete(path: '/distributors/{id}')
  Future<Response> deleteDistributor({
    @Path('id') String id,
    @Header('Authorization') String authKey,
  });
  //CRUD MANUFACTURERS
  @Get(path: '/manufacturers')
  Future<Response> getManufacturers({
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });
  @Post(path: '/manufacturers')
  Future<Response> createManufacturers({
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });

  @Put(path: '/manufacturers/{id}')
  Future<Response> updateManufacturers({
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });

  @Put(path: '/manufacturers/{id}/products')
  Future<Response> addProductsToManufacturer({
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });

  @Delete(path: '/manufacturers/{id}')
  Future<Response> deleteManufacturers({
    @Path('id') String id,
    @Header('Authorization') String authKey,
  });

  //CRUD CATEGORIES
  @Get(path: '/categories')
  Future<Response> getCategories({
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });

  @Post(path: '/categories')
  Future<Response> createCategories({
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });

  @Put(path: '/categories/{id}')
  Future<Response> updateCategories({
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });

  @Put(path: '/categories/{id}/products')
  Future<Response> addProductsToCategory({
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });

  @Delete(path: '/categories/{id}')
  Future<Response> deleteCategories({
    @Path('id') String id,
    @Header('Authorization') String authKey,
  });

  //CRUD VARIANTS
  @Get(path: '/variants')
  Future<Response> getVariants({
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });

  @Post(path: '/variants')
  Future<Response> createVariants({
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });

  @Put(path: '/variants/{id}')
  Future<Response> updateVariants({
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });

  @Delete(path: '/variants/{id}')
  Future<Response> deleteVariants({
    @Path('id') String id,
    @Header('Authorization') String authKey,
  });

  //CRUD CATEGORIES
  @Get(path: '/packages')
  Future<Response> getPackages({
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });

  @Post(path: '/packages')
  Future<Response> createPackages({
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });

  @Put(path: '/packages/{id}')
  Future<Response> updatePackages({
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });

  @Put(path: '/packages/{id}/products')
  Future<Response> addProductsToPackages({
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });

  @Delete(path: '/packages/{id}')
  Future<Response> deletePackages({
    @Path('id') String id,
    @Header('Authorization') String authKey,
  });
  //CRUD PRODUCTS
  @Get(path: '/products')
  Future<Response> getProducts({
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });

  @Post(path: '/products')
  Future<Response> createProducts({
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });
  @Post(path: '/products/variants')
  Future<Response> createProductWithVariants({
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });
  @Put(path: '/products/{id}/variants')
  Future<Response> updateProductWithVariants({
    @Body() Map<String, dynamic> body,
    @Path('id') String id,
    @Header('Authorization') String authKey,
  });
  @Put(path: '/products/{id}')
  Future<Response> updateProducts({
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });

  @Delete(path: '/products/{id}')
  Future<Response> deleteProducts({
    @Path('id') String id,
    @Header('Authorization') String authKey,
  });

  //REGISTER
  @Post(path: '/register')
  Future<Response> register(
    @Body() Map<String, dynamic> body,
  );

  //PROFILE
  @Get(path: '/profile')
  Future<Response> getProfile({
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });
  @Put(path: '/users/{id}')
  Future<Response> updateProfile({
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });

//DOWNLOAD KYC
  @Get(path: '/download/companies/{id}/kyc/{prefix}')
  Future<Response> downloadKYC({
    @Path('id') String id,
    @Path('prefix') String prefix,
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });
  //PAYMENTS
  @Get(path: '/payments')
  Future<Response> getPayments({
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });

  @Post(path: '/payment/init')
  Future<Response> initPayment({
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });
//CHANGE PASSWORD
  @Put(path: '/updateUserPassword')
  Future<Response> changePassword({
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });

  @Post(path: '/payment/process')
  Future<Response> processPayment({
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });

  @Post(path: '/payment/finalize')
  Future<Response> finalizePayment({
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });

  //LOGIN
  @Post(path: '/login')
  Future<Response> login(
    @Body() Map<String, dynamic> body,
  );

  @Post(path: '/fingerprint')
  Future<Response> registerFingerprint({
    @Body() Map<String, dynamic> body,
    @Header('Authorization') String authKey,
  });
  static ApiService create() {
    final client = ChopperClient(
      baseUrl: baseUrl,
      services: [
        _$ApiService(),
      ],
      converter: JsonConverter(),
    );

    return _$ApiService(client);
  }
}
