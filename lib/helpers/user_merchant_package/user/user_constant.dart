import '../../base/base_columns.dart';

const String CREATE_USER_TABLE_QUERY = "CREATE TABLE IF NOT EXISTS " +
    TABLE_NAME +
    " (" +
    ID +
    " TEXT PRIMARY KEY," +
    MERCHANT_ID +
    "  INTEGER ," +
    LOCAL_ID +
    " TEXT ," +
    USERNAME +
    " TEXT ," +
    AUTH_KEY +
    " TEXT ," +
    MOBILE_NUMBER +
    "  TEXT ," +
    NAME +
    "  TEXT ," +
    LAST_NAME +
    "  TEXT ," +
    MIDDLE_NAME +
    "  TEXT ," +
    USER_ROLE_ID +
    "  INTEGER ," +
    COUNTRY_CODE +
    "  TEXT ," +
    USER_ROLE_PLAN +
    "  TEXT ," +
    PINCODE +
    "  TEXT ," +
    STORE_LOCATION_ID +
    "  INTEGER ," +
    STORE_ADDRESS +
    "  TEXT ," +
    STORE_ADDRESS_2 +
    "  TEXT ," +
    STORE_CITY_NAME +
    "  TEXT ," +
    STORE_STATE_NAME +
    "  TEXT ," +
    STORE_PINCODE +
    "  TEXT ," +
    STORE_ID +
    "  INTEGER ," +
    PUB_SUB +
    "  TEXT ," +
    ADDRESS_1 +
    "  TEXT ," +
    ADDRESS_2 +
    "  TEXT ," +
    PAN_NUMBER +
    "  TEXT ," +
    STORE_NAME +
    "  TEXT ," +
    STORE_CAPTION +
    "  TEXT ," +
    DOB +
    "  TEXT ," +
    UNVERIFIED_EMAIL +
    "  INTEGER ," +
    UNVERIFIED_MOBILE +
    "  INTEGER ," +
    IS_SYNCED +
    "  INTEGER ," +
    CREATED_AT +
    "  INTEGER ," +
    UPDATED_AT +
    "  INTEGER ," +
    STATUS +
    "  INTEGER );";

const String DROP_TABLE_QUERY = "DROP TABLE IF EXISTS " + TABLE_NAME;

const String TABLE_NAME = "user_table";
const String AUTH_KEY = "auth_key";
const String USER_ROLE_ID = "user_role_id";
const String USER_ROLE_PLAN = "user_role_plan";
const String USERNAME = "user_name";
const String PUB_SUB = "pub_sub";
const String MOBILE_NUMBER = "user_mobile_number";
const String LAST_NAME = "user_last_name";
const String MIDDLE_NAME = "user_middle_name";
const String COUNTRY_CODE = "user_country_code";
const String STORE_ID = "user_store_id";
const String STATE_ID = "user_state_id";
const String CITY_ID = "user_city_id";
const String PINCODE = "user_pincode";
const String PAN_NUMBER = "user_pan_number";
const String ADDRESS_1 = "user_address_1";
const String ADDRESS_2 = "user_address_2";
const String DOB = "user_dob";
const String STORE_ADDRESS = "user_store_address";
const String STORE_ADDRESS_2 = "user_store_address2";
const String STORE_CITY_NAME = "user_store_city_name";
const String STORE_STATE_NAME = "user_store_state_name";
const String STORE_PINCODE = "user_store_pincode";
const String STORE_LOCATION_ID = "user_location_id";
const String STORE_NAME = "user_store_name";
const String STORE_CAPTION = "user_caption";
const String UNVERIFIED_EMAIL = "unverified_email";
const String UNVERIFIED_MOBILE = "unverified_mobile";
