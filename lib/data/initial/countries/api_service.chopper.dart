// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$ApiService extends ApiService {
  _$ApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = ApiService;

  Future<Response> getCountries() {
    final $url = '/countries';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getUnits() {
    final $url = '/units';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getCurrency() {
    final $url = '/currencies';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getTransactionTypes() {
    final $url = '/transactionTypes';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getAreas() {
    final $url = '/areas';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getPincode(String id) {
    final $url = '/areas?pinCode=${id}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getCities() {
    final $url = '/cities';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getCity(String id) {
    final $url = '/cities?id=${id}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getStates() {
    final $url = '/states';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getState(String id) {
    final $url = '/states/${id}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getIndustries() {
    final $url = '/industries';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getIndustriesClassifications({Map<String, dynamic> body}) {
    final $url = '/industryClassification';
    final $body = body;
    final $request = Request('GET', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getBusinessTypes() {
    final $url = '/businessTypes';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getStores({Map<String, dynamic> body, String authKey}) {
    final $url = '/stores';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('GET', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> createStore({Map<String, dynamic> body, String authKey}) {
    final $url = '/stores';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> updateStore(
      {String id, Map<String, dynamic> body, String authKey}) {
    final $url = '/stores/${id}';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('PUT', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> deleteStore({String id, String authKey}) {
    final $url = '/stores/${id}';
    final $headers = {'Authorization': authKey};
    final $request = Request('DELETE', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getUsers({Map<String, dynamic> body, String authKey}) {
    final $url = '/users';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('GET', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> createUsers({Map<String, dynamic> body, String authKey}) {
    final $url = '/users';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> updateUsers(
      {String id, Map<String, dynamic> body, String authKey}) {
    final $url = '/users/${id}';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('PUT', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> deleteUsers({String id, String authKey}) {
    final $url = '/users/${id}';
    final $headers = {'Authorization': authKey};
    final $request = Request('DELETE', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getCompany({Map<String, dynamic> body, String authKey}) {
    final $url = '/companies';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('GET', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> createCompany({Map<String, dynamic> body, String authKey}) {
    final $url = '/companies';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> updateCompany(
      {String id, Map<String, dynamic> body, String authKey}) {
    final $url = '/companies/${id}';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('PUT', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> deleteCompany({String id, String authKey}) {
    final $url = '/companies/${id}';
    final $headers = {'Authorization': authKey};
    final $request = Request('DELETE', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getTaxes() {
    final $url = '/taxslabs';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getDistributors(
      {Map<String, dynamic> body, String authKey}) {
    final $url = '/distributors';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('GET', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> createDistributor(
      {Map<String, dynamic> body, String authKey}) {
    final $url = '/distributors';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> updateDistributor(
      {String id, Map<String, dynamic> body, String authKey}) {
    final $url = '/distributors/${id}';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('PUT', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> addProductsToDistributor(
      {String id, Map<String, dynamic> body, String authKey}) {
    final $url = '/distributors/${id}/products';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('PUT', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> deleteDistributor({String id, String authKey}) {
    final $url = '/distributors/${id}';
    final $headers = {'Authorization': authKey};
    final $request = Request('DELETE', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getManufacturers(
      {Map<String, dynamic> body, String authKey}) {
    final $url = '/manufacturers';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('GET', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> createManufacturers(
      {Map<String, dynamic> body, String authKey}) {
    final $url = '/manufacturers';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> updateManufacturers(
      {String id, Map<String, dynamic> body, String authKey}) {
    final $url = '/manufacturers/${id}';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('PUT', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> addProductsToManufacturer(
      {String id, Map<String, dynamic> body, String authKey}) {
    final $url = '/manufacturers/${id}/products';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('PUT', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> deleteManufacturers({String id, String authKey}) {
    final $url = '/manufacturers/${id}';
    final $headers = {'Authorization': authKey};
    final $request = Request('DELETE', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getCategories({Map<String, dynamic> body, String authKey}) {
    final $url = '/categories';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('GET', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> createCategories(
      {Map<String, dynamic> body, String authKey}) {
    final $url = '/categories';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> updateCategories(
      {String id, Map<String, dynamic> body, String authKey}) {
    final $url = '/categories/${id}';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('PUT', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> addProductsToCategory(
      {String id, Map<String, dynamic> body, String authKey}) {
    final $url = '/categories/${id}/products';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('PUT', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> deleteCategories({String id, String authKey}) {
    final $url = '/categories/${id}';
    final $headers = {'Authorization': authKey};
    final $request = Request('DELETE', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getVariants({Map<String, dynamic> body, String authKey}) {
    final $url = '/variants';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('GET', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> createVariants({Map<String, dynamic> body, String authKey}) {
    final $url = '/variants';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> updateVariants(
      {String id, Map<String, dynamic> body, String authKey}) {
    final $url = '/variants/${id}';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('PUT', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> deleteVariants({String id, String authKey}) {
    final $url = '/variants/${id}';
    final $headers = {'Authorization': authKey};
    final $request = Request('DELETE', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getPackages({Map<String, dynamic> body, String authKey}) {
    final $url = '/packages';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('GET', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> createPackages({Map<String, dynamic> body, String authKey}) {
    final $url = '/packages';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> updatePackages(
      {String id, Map<String, dynamic> body, String authKey}) {
    final $url = '/packages/${id}';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('PUT', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> addProductsToPackages(
      {String id, Map<String, dynamic> body, String authKey}) {
    final $url = '/packages/${id}/products';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('PUT', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> deletePackages({String id, String authKey}) {
    final $url = '/packages/${id}';
    final $headers = {'Authorization': authKey};
    final $request = Request('DELETE', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getProducts({Map<String, dynamic> body, String authKey}) {
    final $url = '/products';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('GET', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> createProducts({Map<String, dynamic> body, String authKey}) {
    final $url = '/products';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> createProductWithVariants(
      {Map<String, dynamic> body, String authKey}) {
    final $url = '/products/variants';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> updateProductWithVariants(
      {Map<String, dynamic> body, String id, String authKey}) {
    final $url = '/products/${id}/variants';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('PUT', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> updateProducts(
      {String id, Map<String, dynamic> body, String authKey}) {
    final $url = '/products/${id}';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('PUT', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> deleteProducts({String id, String authKey}) {
    final $url = '/products/${id}';
    final $headers = {'Authorization': authKey};
    final $request = Request('DELETE', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> register(Map<String, dynamic> body) {
    final $url = '/register';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getProfile({Map<String, dynamic> body, String authKey}) {
    final $url = '/profile';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('GET', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> updateProfile(
      {String id, Map<String, dynamic> body, String authKey}) {
    final $url = '/users/${id}';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('PUT', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> downloadKYC(
      {String id, String prefix, Map<String, dynamic> body, String authKey}) {
    final $url = '/download/companies/${id}/kyc/${prefix}';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('GET', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getPayments({Map<String, dynamic> body, String authKey}) {
    final $url = '/payments';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('GET', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> initPayment({Map<String, dynamic> body, String authKey}) {
    final $url = '/payment/init';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> changePassword({Map<String, dynamic> body, String authKey}) {
    final $url = '/updateUserPassword';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('PUT', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> processPayment({Map<String, dynamic> body, String authKey}) {
    final $url = '/payment/process';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> finalizePayment(
      {Map<String, dynamic> body, String authKey}) {
    final $url = '/payment/finalize';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> login(Map<String, dynamic> body) {
    final $url = '/login';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> registerFingerprint(
      {Map<String, dynamic> body, String authKey}) {
    final $url = '/fingerprint';
    final $headers = {'Authorization': authKey};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }
}
