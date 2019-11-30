import '../../base/base_builder.dart';
import '../../base/base_columns.dart';
import 'user.dart';
import 'user_constant.dart';
import '../../base/local_id_generator.dart';

class UserBuilder extends Builder<User> {
  User model;

  UserBuilder() {
    model = new User();
  }

  @override
  UserBuilder id(var id) {
    model.id = (id);
    return this;
  }

  @override
  UserBuilder updatedAt(int updatedAt) {
    model.updatedAt = (updatedAt);
    return this;
  }

  @override
  UserBuilder createdAt(int createdAt) {
    model.createdAt = (createdAt);
    return this;
  }

  @override
  UserBuilder merchantId(String merchantId) {
    model.merchantId = (merchantId);
    return this;
  }

  @override
  UserBuilder status(int status) {
    model.status = (status);
    return this;
  }

  @override
  UserBuilder isSynced(bool isSynced) {
    model.isSync = (isSynced);
    return this;
  }

  @override
  UserBuilder name(String name) {
    model.name = (name);
    return this;
  }

  @override
  UserBuilder localId(String localId) {
    model.localId = (localId);
    return this;
  }

  UserBuilder roleId(int roleId) {
    model.roleId = roleId;
    return this;
  }

  UserBuilder storeLocationId(int storeLocationId) {
    model.storeLocationId = storeLocationId;
    return this;
  }

  UserBuilder unVerifiedUserMobileNumber(int unVerifiedUserMobileNumber) {
    model.unVerifiedUserMobileNumber = unVerifiedUserMobileNumber;
    return this;
  }

  UserBuilder unVerifiedUsername(int unVerifiedUsername) {
    model.unVerifiedUsername = unVerifiedUsername;
    return this;
  }

  UserBuilder username(String username) {
    model.username = username;
    return this;
  }

  UserBuilder storeAddress(String storeAddress) {
    model.storeAddress = storeAddress;
    return this;
  }

  UserBuilder storeAddress2(String storeAddress2) {
    model.storeAddress2 = storeAddress2;
    return this;
  }

  UserBuilder storeStateName(String storeStateName) {
    model.storeStateName = storeStateName;
    return this;
  }

  UserBuilder storeCityName(String storeCityName) {
    model.storeCityName = storeCityName;
    return this;
  }

  UserBuilder storePincode(String storePincode) {
    model.storePincode = storePincode;
    return this;
  }

  UserBuilder authKey(String authKey) {
    model.authKey = authKey;
    return this;
  }

  UserBuilder rolePlan(String rolePlan) {
    model.rolePlan = rolePlan;
    return this;
  }

  UserBuilder userMobileNumber(String userMobileNumber) {
    model.userMobileNumber = userMobileNumber;
    return this;
  }

  UserBuilder userMiddleName(String userMiddleName) {
    model.userMiddleName = userMiddleName;
    return this;
  }

  UserBuilder userLastName(String userLastName) {
    model.userLastName = userLastName;
    return this;
  }

  UserBuilder pubsubToken(String pubsubToken) {
    model.pubsubToken = pubsubToken;
    return this;
  }

  UserBuilder pincode(String pincode) {
    model.pincode = pincode;
    return this;
  }

  UserBuilder countryCode(String countryCode) {
    model.countryCode = countryCode;
    return this;
  }

  UserBuilder userAddress1(String userAddress1) {
    model.userAddress1 = userAddress1;
    return this;
  }

  UserBuilder userAddress2(String userAddress2) {
    model.userAddress2 = userAddress2;
    return this;
  }

  UserBuilder userPANNumber(String userPANNumber) {
    model.userPANNumber = userPANNumber;
    return this;
  }

  UserBuilder dateOfBirth(String dateOfBirth) {
    model.dateOfBirth = dateOfBirth;
    return this;
  }

  UserBuilder storeCaption(String storeCaption) {
    model.storeCaption = storeCaption;
    return this;
  }

  @override
  User build() {
    return model;
  }

  @override
  UserBuilder setModel(User model) {
    this.model = model;
    return this;
  }

  @override
  UserBuilder fromMap(Map<String, dynamic> map) {
    id(map[ID])
        .localId(map[LOCAL_ID])
        .name(map[NAME])
        .merchantId(map[MERCHANT_ID].toString())
        .status(map[STATUS])
        .updatedAt(map[UPDATED_AT])
        .createdAt(map[CREATED_AT])
        .isSynced(map[IS_SYNCED] == 1 ? true : false)
        .roleId(map[USER_ROLE_ID])
        .username(map[USERNAME])
        .storeAddress(map[STORE_ADDRESS])
        .storeAddress2(map[STORE_ADDRESS_2])
        .storeCityName(map[STORE_CITY_NAME])
        .storeStateName(map[STORE_STATE_NAME])
        .storePincode(map[STORE_PINCODE])
        .storeLocationId(map[STORE_LOCATION_ID])
        .authKey(map[AUTH_KEY])
        .rolePlan(map[USER_ROLE_PLAN])
        .userMobileNumber(map[MOBILE_NUMBER])
        .userMiddleName(map[MIDDLE_NAME])
        .userLastName(map[LAST_NAME])
        .pubsubToken(map[PUB_SUB])
        .pincode(map[PINCODE])
        .countryCode(map[COUNTRY_CODE])
        .userAddress1(map[ADDRESS_1])
        .userAddress2(map[ADDRESS_2])
        .pincode(map[PINCODE])
        .dateOfBirth(map[DOB])
        .storeCaption(map[STORE_CAPTION])
        .unVerifiedUserMobileNumber(map[UNVERIFIED_MOBILE])
        .unVerifiedUsername(map[UNVERIFIED_MOBILE]);
    return this;
  }

  @override
  Builder<User> fromJson(Map<String, dynamic> json) {
    id(json['id'])
        .localId(
            json['localId'] ? json['localId'] : LocalIdGenerator.generate())
        .name(json['userFirstName'])
        .merchantId(json['merchantId'].toString())
        .status(json['status'])
        .updatedAt(json['updated_at'])
        .createdAt(json['created_at'])
        .isSynced(true)
        .roleId(json['roleId'])
        .username(json['username'])
        .storeAddress(json['storeAddress'])
        .storeAddress2(json['storeAddress2'])
        .storeCityName(json['storeCityName'])
        .storeStateName(json['storeStateName'])
        .storePincode(json['storePincode'])
        .storeLocationId(json['storeLocationId'])
        .authKey(json['auth_key'])
        .rolePlan(json['userRole'])
        .userMobileNumber(json['userMobileNumber'])
        .userMiddleName(json['userMiddleName'])
        .userLastName(json['userLastName'])
        .pubsubToken(json['pubsubToken'])
        .pincode(json['pincode'])
        .countryCode(json['countryCode'])
        .userAddress1(json['userAddress1'])
        .userAddress2(json['userAddress2'])
        .dateOfBirth(json['dateOfBirth'])
        .userPANNumber(json['userPanNumber'])
        .storeCaption(json['storeCaption'])
        .unVerifiedUserMobileNumber(json['unVerifiedUserMobileNumber'])
        .unVerifiedUsername(json['unVerifiedUsername']);
    return this;
  }

  @override
  Map<String, dynamic> buildMapFromJson(Map<String, dynamic> json) {
    Map<String, dynamic> map = new Map();
    map[ID] = json['id'];
    map[LOCAL_ID] = LocalIdGenerator.generate();
    map[NAME] = json['userFirstName'];
    map[MERCHANT_ID] = json['merchantId'].toString();
    map[STATUS] = json['status'];
    map[UPDATED_AT] = json['updated_at'];
    map[CREATED_AT] = json['created_at'];
    map[IS_SYNCED] = 1;
    map[USER_ROLE_ID] = json['roleId'];
    map[USERNAME] = json['username'];
    map[STORE_ADDRESS] = json['storeAddress'];
    map[STORE_ADDRESS_2] = json['storeAddress2'];
    map[STORE_CITY_NAME] = json['storeCityName'];
    map[STORE_STATE_NAME] = json['storeStateName'];
    map[STORE_PINCODE] = json['storePincode'];
    map[STORE_LOCATION_ID] = json['storeLocationId'];
    map[AUTH_KEY] = json['auth_key'];
    map[USER_ROLE_PLAN] = json['userRole'];
    map[MOBILE_NUMBER] = json['userMobileNumber'];
    map[MIDDLE_NAME] = json['userMiddleName'];
    map[LAST_NAME] = json['userLastName'];
    map[PUB_SUB] = json['pubsubToken'];
    map[PINCODE] = json['pincode'];
    map[COUNTRY_CODE] = json['countryCode'];
    map[ADDRESS_1] = json['userAddress1'];
    map[ADDRESS_2] = json['userAddress2'];
    map[PAN_NUMBER] = json['userPanNumber'];
    map[DOB] = json['dateOfBirth'];
    map[STORE_CAPTION] = json['storeCaption'];
    map[UNVERIFIED_MOBILE] = json['unVerifiedUserMobileNumber'];
    map[UNVERIFIED_EMAIL] = json['unVerifiedUsername'];
    return map;
  }

  @override
  Map<String, dynamic> buildMap() {
    Map<String, dynamic> map = new Map();
    map[ID] = model.id;
    map[LOCAL_ID] = model.localId;
    map[NAME] = model.name;
    map[MERCHANT_ID] = model.merchantId;
    map[STATUS] = model.status;
    map[UPDATED_AT] = model.updatedAt;
    map[CREATED_AT] = model.createdAt;
    map[IS_SYNCED] = model.isSync ? 1 : 0;
    map[USER_ROLE_ID] = model.roleId;
    map[USERNAME] = model.username;
    map[STORE_ADDRESS] = model.storeAddress;
    map[STORE_ADDRESS_2] = model.storeAddress2;
    map[STORE_CITY_NAME] = model.storeCityName;
    map[STORE_STATE_NAME] = model.storeStateName;
    map[STORE_PINCODE] = model.pincode;
    map[STORE_LOCATION_ID] = model.storeLocationId;
    map[AUTH_KEY] = model.authKey;
    map[USER_ROLE_PLAN] = model.rolePlan;
    map[MOBILE_NUMBER] = model.userMobileNumber;
    map[MIDDLE_NAME] = model.userMiddleName;
    map[LAST_NAME] = model.userLastName;
    map[PUB_SUB] = model.pubsubToken;
    map[PINCODE] = model.pincode;
    map[COUNTRY_CODE] = model.countryCode;
    map[ADDRESS_1] = model.userAddress1;
    map[ADDRESS_2] = model.userAddress2;
    map[PAN_NUMBER] = model.userPANNumber;
    map[DOB] = model.dateOfBirth;
    map[STORE_CAPTION] = model.storeCaption;
    map[UNVERIFIED_MOBILE] = model.unVerifiedUserMobileNumber;
    map[UNVERIFIED_EMAIL] = model.unVerifiedUsername;
    return map;
  }
}
