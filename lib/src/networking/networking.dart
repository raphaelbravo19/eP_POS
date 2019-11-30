import 'package:epaisa_pos/helpers/user_merchant_package/user/user.dart';
import 'package:epaisa_pos/helpers/user_merchant_package/user_lib.dart';
import 'package:epaisa_pos/helpers/util/request_builder.dart';
import 'package:epaisa_pos/helpers/util/util.dart';
import 'package:http/http.dart' show Client, Response;
import 'endpoint.dart';
import 'dart:convert';
import 'base_network.dart';

class Networking extends BaseNetwork {
  Future<Response> login({String username, String password}) async {
    Map<String, dynamic> plainRequest = {
      "username": username,
      "password": password,
      "sourceId": 2,
      "extra": ["merchant"]
    };
    String encryptedRequest =
        await RequestBuilder().addParameter(json.encode(plainRequest)).build();
    print('Login Req: ' + encryptedRequest);
    return post(EndPoint.login, encryptedRequest);
  }

  Future<Response> registerUser({
    String username,
    String userMobileNumber,
    String countryCode,
    String password,
    String firstname,
    String lastName,
    String businessname,
    String referralCode,
    String sourceId,
    String otpType,
  }) async {
    Map<String, dynamic> plainRequest = {
      "Username": username,
      "UserMobileNumber": userMobileNumber,
      "CountryCode": countryCode,
      "Password": password,
      "UserFirstName": firstname,
      "UserLastName": lastName,
      "BusinessName": businessname,
      "registeredReferralCode": referralCode,
      "sourceId": sourceId,
      "otpType": otpType
    };
    String encryptedRequest =
        await RequestBuilder().addParameter(json.encode(plainRequest)).build();
    print(encryptedRequest);
    return post(EndPoint.registerUser, encryptedRequest);
  }

  Future<Response> checkUser({String username, String mobile}) async {
    Map<String, dynamic> plainRequest = {
      "username": username,
      "mobile": mobile,
    };
    String encryptedRequest =
        await RequestBuilder().addParameter(json.encode(plainRequest)).build();
    print(encryptedRequest);
    return post(EndPoint.checkUser, encryptedRequest);
  }

  Future<Response> dashboard() async {
    String authKey = await AppUserInfo().getAuthKey();
    User user = await AppUserInfo().getUser();
    Map<String, dynamic> plainRequest = {
      "merchantId": user.merchantId,
      "userId": user.id,
      "fromDate": '2019-01-01',
      "endDate": '2019-07-31',
    };
    print('dashboard : ' + authKey + '####' + json.encode(plainRequest));

    String encryptedRequest = await RequestBuilder()
        .addParameter(authKey)
        .addParameter(json.encode(plainRequest))
        .build();
    print(encryptedRequest);
    return get(EndPoint.newDashboard, encryptedRequest);
  }

  Future<Response> getStores() async {
    String authKey = await AppUserInfo().getAuthKey();
    Map<String, dynamic> plainRequest = {};
    print('getStores() : ' + authKey + '####' + json.encode(plainRequest));

    String encryptedRequest = await RequestBuilder()
        .addParameter(authKey)
        .addParameter(json.encode(plainRequest))
        .build();
    print(encryptedRequest);
    return get(EndPoint.store, encryptedRequest);
  }

  Future<Response> verifyUser(
      {String pin, String otpType, String authKey}) async {
    Map<String, dynamic> plainRequest = {"otpValue": pin, "type": otpType};
    // String authKey = await AppUserInfo().getAuthKey();
    print('otpvalue ' + pin);
    print('verifyUser : ' + authKey + '####' + json.encode(plainRequest));
    String encryptedRequest = await RequestBuilder()
        .addParameter(authKey)
        .addParameter(json.encode(plainRequest))
        .build();

    print(encryptedRequest);
    return put(EndPoint.verifyUser, encryptedRequest);
  }

//   Future<Response> coldLogin() async {
//     var merchantId = await AppUserInfo().getMerchantId();
//     var userId = await AppUserInfo().getUserId();
//     String authKey = await AppUserInfo().getAuthKey();
//     User user = await AppUserInfo().getUser();

//     Map<String, dynamic> plainRequest = {
//       "merchantId": merchantId,
//       'userId': userId,
//       'username': user.username,
//       'sourceId': 2
//     };

//     print('coldLogin : ' + authKey + '####' + json.encode(plainRequest));
//     String encryptedRequest = await RequestBuilder()
//         .addParameter(authKey)
//         .addParameter(json.encode(plainRequest))
//         .build();
//     print('Request2: ' + encryptedRequest);
//     String a = await Crypto.decrypt(encryptedRequest);
//     print(a);
//     return post(EndPoint.cold_login, encryptedRequest);
//   }

//   Future<Response> getBalance() async {
//     var merchantId = await AppUserInfo().getMerchantId();
//     Map<String, dynamic> plainRequest = {"merchantId": merchantId};
//     String authKey = await AppUserInfo().getAuthKey();
//     print('getBalance : ' + authKey + '####' + json.encode(plainRequest));
//     String encryptedRequest = await RequestBuilder()
//         .addParameter(authKey)
//         .addParameter(json.encode(plainRequest))
//         .build();
//     print('Request2: ' + encryptedRequest);
//     String a = await Crypto.decrypt(encryptedRequest);
//     print(a);
//     return get(EndPoint.balance, encryptedRequest);
//   }

//   Future<Response> getServices({int limit = 100, int offset = 0}) async {
//     Map<String, dynamic> plainRequest = {"limit": limit, "offset": offset};
//     String authKey = await AppUserInfo().getAuthKey();
//     print('Request: ' + authKey + '####' + json.encode(plainRequest));
//     String encryptedRequest = await RequestBuilder()
//         .addParameter(authKey)
//         .addParameter(json.encode(plainRequest))
//         .build();
//     print('Request2: ' + encryptedRequest);
//     return get(EndPoint.vas_services, encryptedRequest);
//   }

//   Future<Response> getStates({int limit = 100, int offset = 0}) async {
//     Map<String, dynamic> plainRequest = {"limit": limit, "offset": offset};
//     String authKey = await AppUserInfo().getAuthKey();
//     print('Request: ' + authKey + '####' + json.encode(plainRequest));
//     String encryptedRequest = await RequestBuilder()
//         .addParameter(authKey)
//         .addParameter(json.encode(plainRequest))
//         .build();
//     print('Request2: ' + encryptedRequest);
//     return get(EndPoint.states, encryptedRequest);
//   }

//   Future<Response> getProviders({int limit = 100, int offset = 0}) async {
//     Map<String, dynamic> plainRequest = {"limit": limit, "offset": offset};
//     String authKey = await AppUserInfo().getAuthKey();
//     print('Request: ' + authKey + '####' + json.encode(plainRequest));
//     String encryptedRequest = await RequestBuilder()
//         .addParameter(authKey)
//         .addParameter(json.encode(plainRequest))
//         .build();
//     print('Request2: ' + encryptedRequest);
//     return get(EndPoint.provider, encryptedRequest);
//   }

//   Future<Response> getProvidersCircle({int limit = 100, int offset = 0}) async {
//     Map<String, dynamic> plainRequest = {"limit": limit, "offset": offset};
//     String authKey = await AppUserInfo().getAuthKey();
//     print('Request: ' + authKey + '####' + json.encode(plainRequest));
//     String encryptedRequest = await RequestBuilder()
//         .addParameter(authKey)
//         .addParameter(json.encode(plainRequest))
//         .build();
//     print('Request2: ' + encryptedRequest);
//     return get(EndPoint.provider_circle, encryptedRequest);
//   }

//   Future<Response> checkUser({String username, String mobile}) async {
//     print(mobile);
//     Map<String, dynamic> plainRequest = {
//       "username": username,
//       "mobile": mobile,
//     };
//     String encryptedRequest =
//         await RequestBuilder().addParameter(json.encode(plainRequest)).build();
//     print(encryptedRequest);
//     return post(EndPoint.checkUser, encryptedRequest);
//   }

//   Future<Response> requestOtp({
//     String otpType,
//   }) async {
//     Map<String, dynamic> plainRequest = {"type": otpType};
//     String authKey = await AppUserInfo().getAuthKey();
//     print('verifyUser : ' + authKey + '####' + json.encode(plainRequest));
//     String encryptedRequest = await RequestBuilder()
//         .addParameter(authKey)
//         .addParameter(json.encode(plainRequest))
//         .build();

//     print(encryptedRequest);
//     return post(EndPoint.requestOtp, encryptedRequest);
//   }

  // Future<Response> forgotPassRequestEmailMobNo(
  //     {String email, String mobile}) async {
  //   print("Email is: $email and mobile no: $mobile");
  //   Map<String, dynamic> emailRequest = {"email": email};
  //   Map<String, dynamic> mobRequest = {"mobile": "+91$mobile"};

  //   print("FP emailRequest: $emailRequest");
  //   print("FP mobRequest: $mobRequest");
  //   String encryptedRequest = await RequestBuilder()
  //       .addParameter(json.encode(email != null && email.length > 0 ? emailRequest : mobRequest))
  //       .build();
  //   print('Login Req: ' + encryptedRequest);
  //   return post(EndPoint.forgotPassRequestEmailMobNo, encryptedRequest);
  // }

//   Future<Response> forgetPassRequestMobNoOtp(
//       {String mobileNumber, String otp}) async {
//     print("mobileNumber is: $mobileNumber and OPT: $otp");
//     Map<String, dynamic> mobNoOtp = {
//       "0": "+91$mobileNumber",
//       "1": otp,
//       "2": 7,
//       "outside": true
//     };

//     String encryptedRequest =
//         await RequestBuilder().addParameter(json.encode(mobNoOtp)).build();
//     return put(EndPoint.forgetPassMobNoOtp, encryptedRequest);
//   }

//   Future<Response> forgetPassUpdatePass(String countryCodeAndMobileNumber, String otp, String newPass, String token)async{
//     print("FP Pass: $newPass and Opt: $otp");
//     Map<String, dynamic> updatedPassword = {
//       "mobile": countryCodeAndMobileNumber,
//       "otp": otp,
//       "newpassword": newPass,
//       "token": token
//     };

//     String encryptedRequest =
//         await RequestBuilder().addParameter(token).addParameter(json.encode(updatedPassword)).build();
//     return post(EndPoint.forgetPassUpdatePass, encryptedRequest);
//   }

//   Future<Response> addWallet({
//     String amount,
//   }) async {
//     print('addwaler api');
//     var merchantId = await AppUserInfo().getMerchantId();
//     var userId = await AppUserInfo().getUserId();
// //    token####{"merchantId":"","userId":"","amount":"","sourceId":""}
//     Map<String, dynamic> plainRequest = {
//       "merchantId": merchantId,
//       "userId": userId,
//       "sourceId": "2",
//       "amount": "2.00"
//     };
//     String authKey = await AppUserInfo().getAuthKey();
//     print('addWallet : ' + authKey + '####' + json.encode(plainRequest));
//     String encryptedRequest = await RequestBuilder()
//         .addParameter(authKey)
//         .addParameter(json.encode(plainRequest))
//         .build();
//     print('addWallet enc: ' + encryptedRequest);
//     String a = await Crypto.decrypt(encryptedRequest);
//     print(a);
//     return post(EndPoint.addWalletCitrus, encryptedRequest);
//   }

//   Future<Response> updateWallet({
//     String amount,
//   }) async {
//     print('updateWallet api');

//     var merchantId = await AppUserInfo().getMerchantId();
//     var userId = await AppUserInfo().getUserId();
//     Map<String, dynamic> plainRequest = {
//       "orderId": merchantId,
//       "TxStatus": userId,
//       "merchantId": "2",
//       "amount": "2.00",
//       "TxId": merchantId,
//       "TxRefNo": userId,
//       "TxMsg": "2",
//       "transactionId": "2.00",
//       "txnDateTime": merchantId,
//       "signature": userId,
//       "sourceId": "2",
//     };
//     String authKey = await AppUserInfo().getAuthKey();
//     print('addWallet : ' + authKey + '####' + json.encode(plainRequest));
//     String encryptedRequest = await RequestBuilder()
//         .addParameter(authKey)
//         .addParameter(json.encode(plainRequest))
//         .build();
//     print('updateWallet enc: ' + encryptedRequest);
//     String a = await Crypto.decrypt(encryptedRequest);
//     print(a);
//     return post(EndPoint.updateWalletCitrus, encryptedRequest);
//   }

  //Start - Get User Personal Details (MY ACCOUNT)
  Future<Response> getPersonalData() async {
    var merchantId = await AppUserInfo().getMerchantId();
    var userId = await AppUserInfo().getUserId();
    User user = await AppUserInfo().getUser();

    print("MA merchantID : ${user.countryCode} ");
    print("MA merchantID : $merchantId and userId: $userId");

    Map<String, dynamic> plainRequest = {
      "merchantId": merchantId,
      "userId": userId
    };

    print("MA Request: $plainRequest");

    String authKey = await AppUserInfo().getAuthKey();
    print('getPersonal Details : ' +
        authKey +
        '####' +
        json.encode(plainRequest));
    String encryptedRequest = await RequestBuilder()
        .addParameter(authKey)
        .addParameter(json.encode(plainRequest))
        .build();
    print('getPersonal: ' + encryptedRequest);
    String a = await Crypto.decrypt(encryptedRequest);
    print("get" + a);
    return get(EndPoint.myAccountPersonal, encryptedRequest);
  }
//   //End - Get User Personal Details (MY ACCOUNT)

//   //Start - Save User Personal Details (MY ACCOUNT)

//   Future<Response> savePersonData({
//     String firstName,
//     String lastName,
//     String address,
//     String dateOfBirth,
//     var image,
//   }) async {
//     var merchantId = await AppUserInfo().getMerchantId();
//     var userId = await AppUserInfo().getUserId();
//     String authKey = await AppUserInfo().getAuthKey();

//     Map<String, dynamic> userData = {
//       "merchantId": merchantId,
//       "userId": userId,
//       "userFirstName": firstName,
//       "userLastName": lastName,
//       "userAddress1": address,
//       "dateOfBirth": dateOfBirth,
//       "files": image
//     };

//     print("User Data Personal: $userData");

//     String encryptedRequest = await RequestBuilder()
//         .addParameter(authKey)
//         .addParameter(jsonEncode(userData))
//         .build();

//     return put(EndPoint.myAccountPersonal, encryptedRequest);
//   }
//   //End - Save User Personal Details (MY ACCOUNT)

//   Future<Response> saveBussinessData({
//     String firstName,
//     String lastName,
//     String address,
//     String dateOfBirth,
//     var image,
//   }) async {
//     var merchantId = await AppUserInfo().getMerchantId();
//     var userId = await AppUserInfo().getUserId();
//     String authKey = await AppUserInfo().getAuthKey();

//     Map<String, dynamic> userData = {
//       "merchantId": merchantId,
//       "userId": userId,
//       "userFirstName": firstName,
//       "userLastName": lastName,
//       "userAddress1": address,
//       "dateOfBirth": dateOfBirth,
//       "merchantCompanyImage": image
//     };

//     print("User Data Personal: $userData");

//     String encryptedRequest = await RequestBuilder()
//         .addParameter(authKey)
//         .addParameter(jsonEncode(userData))
//         .build();

//     return put(EndPoint.myAccountPersonal, encryptedRequest);
//   }

//   //Start - Save Change Password
//   Future<Response> changedPassword(
//       {String currentPass, String newPass}) async {

//     String authKey = await AppUserInfo().getAuthKey();

//     Map<String, dynamic> updatePass = {
//       "newPassword": newPass,
//       "currentPassword": currentPass
//     };

//     print("updatePass values: $updatePass");

//     String encryptionData = await RequestBuilder()
//         .addParameter(authKey)
//         .addParameter(json.encode(updatePass))
//         .build();

//     return put(EndPoint.changePassword, encryptionData);
//   }
//End - Save Change Password
}
