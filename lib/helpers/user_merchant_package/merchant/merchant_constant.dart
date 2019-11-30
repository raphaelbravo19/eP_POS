import '../../base/base_columns.dart';

const String CREATE_MERCHANT_TABLE_QUERY = "CREATE TABLE IF NOT EXISTS " +
    TABLE_NAME +
    " (" +
    ID +
    " TEXT PRIMARY KEY," +
    LOCAL_ID +
    " TEXT ," +
    PLAN_ID +
    " INTEGER ," +
    BUSINESS_TYPE_ID +
    " TEXT ," +
    INDUSTRY_ID +
    "  TEXT ," +
    INDUSTRY_NAME +
    "  TEXT ," +
    CATEGORY_ID +
    "  TEXT ," +
    CATEGORY_NAME +
    "  TEXT ," +
    SUB_CATEGORY_ID +
    "  TEXT ," +
    SUB_CATEGORY +
    "  TEXT ," +
    SUB_CATEGORY_NAME +
    "  TEXT ," +
    COUNTRY_CODE +
    "  TEXT ," +
    COMPANY_NAME +
    "  TEXT ," +
    PAN_NUMBER +
    "  TEXT ," +
    YEARLY_REVENUE +
    "  TEXT ," +
    CREATED_AT +
    "  INTEGER ," +
    UPDATED_AT +
    "  INTEGER ," +
    IS_SYNCED +
    "  INTEGER ," +
    STATUS +
    "  INTEGER "
        ");";
const String DROP_TABLE_QUERY = "DROP TABLE IF EXISTS " + TABLE_NAME;

const String TABLE_NAME = "merchant_table";

const String PLAN_ID = "planId";
const String BUSINESS_TYPE_ID = "business_id";
const String INDUSTRY_ID = "industry_id";
const String INDUSTRY_NAME = "industry_name";
const String CATEGORY_ID = "category_id";
const String CATEGORY_NAME = "category_name";
const String SUB_CATEGORY_ID = "sub_category_id";
const String SUB_CATEGORY = "sub_category";
const String SUB_CATEGORY_NAME = "sub_category_name";
const String COUNTRY_CODE = "country_code";
const String COMPANY_NAME = "company_name";
const String PAN_NUMBER = "pan_number";
const String YEARLY_REVENUE = "yearly_revenue";
