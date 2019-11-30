import '../../base/base_builder.dart';
import '../../base/base_columns.dart';
import 'merchant.dart';
import 'merchant_constant.dart';
import '../../base/local_id_generator.dart';

class MerchantBuilder extends Builder<Merchant> {
  Merchant model;

  MerchantBuilder() {
    model = new Merchant();
  }

  @override
  MerchantBuilder id(String id) {
    model.id = (id);
    return this;
  }

  MerchantBuilder planId(int planId) {
    model.planId = planId;
    return this;
  }

  MerchantBuilder businessPlanId(String businessPlanId) {
    model.businessPlanId = businessPlanId;
    return this;
  }

  MerchantBuilder industryId(String industryId) {
    model.industryId = industryId;
    return this;
  }

  MerchantBuilder industryName(String industryName) {
    model.industryName = industryName;
    return this;
  }

  MerchantBuilder categoryId(String categoryId) {
    model.categoryId = categoryId;
    return this;
  }

  MerchantBuilder categoryName(String categoryName) {
    model.categoryName = categoryName;
    return this;
  }

  MerchantBuilder subCategoryId(String subCategoryId) {
    model.subCategoryId = subCategoryId;
    return this;
  }

  MerchantBuilder subCategory(String subCategory) {
    model.subCategory = subCategory;
    return this;
  }

  MerchantBuilder subCategoryName(String subCategoryName) {
    model.subCategoryName = subCategoryName;
    return this;
  }

  MerchantBuilder countryCode(String countryCode) {
    model.countryCode = countryCode;
    return this;
  }

  MerchantBuilder companyName(String companyName) {
    model.companyName = companyName;
    return this;
  }

  MerchantBuilder panNumber(String panNumber) {
    model.panNumber = panNumber;
    return this;
  }

  MerchantBuilder yearlyRevenue(String yearlyRevenue) {
    model.yearlyRevenue = yearlyRevenue;
    return this;
  }

  @override
  Merchant build() {
    return model;
  }

  @override
  MerchantBuilder setModel(Merchant model) {
    this.model = model;
    return this;
  }

  @override
  MerchantBuilder fromMap(Map<String, dynamic> map) {
    id(map[ID])
        .localId(map[LOCAL_ID])
        .status(map[STATUS])
        .updatedAt(map[UPDATED_AT])
        .createdAt(map[CREATED_AT])
        .isSynced(map[IS_SYNCED] == 1 ? true : false)
        .planId(map[PLAN_ID])
        .businessPlanId(map[BUSINESS_TYPE_ID])
        .industryId(map[INDUSTRY_ID])
        .industryName(map[INDUSTRY_NAME])
        .categoryId(map[CATEGORY_ID])
        .categoryName(map[CATEGORY_NAME])
        .subCategoryId(map[SUB_CATEGORY_ID])
        .subCategory(map[SUB_CATEGORY])
        .subCategoryName(map[SUB_CATEGORY_NAME])
        .countryCode(map[COUNTRY_CODE])
        .companyName(map[COMPANY_NAME])
        .panNumber(map[PAN_NUMBER])
        .yearlyRevenue(map[YEARLY_REVENUE]);
    return this;
  }

  @override
  Builder<Merchant> fromJson(Map<String, dynamic> json) {
    id(json['merchantId'])
        .localId(
            json['localId'] ? json['localId'] : LocalIdGenerator.generate())
        .status(json['status'])
        .updatedAt(json['updated_at'])
        .createdAt(json['created_at'])
        .isSynced(true)
        .planId(json['planId'])
        .businessPlanId(json['businessTypeId'])
        .industryId(json['industryId'])
        .industryName(json['industryName'])
        .categoryId(json['categoryId'])
        .categoryName(json['categoryName'])
        .subCategoryId(json['subCategoryId'])
        .subCategory(json['subCategory'])
        .subCategoryName(json['subCategoryName'])
        .countryCode(json['countryCode'])
        .companyName(json['merchantCompanyName'])
        .panNumber(json['merchantPANCode'])
        .yearlyRevenue(json['merchantYearlyRevenue']);
    return this;
  }

  @override
  Map<String, dynamic> buildMapFromJson(Map<String, dynamic> json) {
    Map<String, dynamic> map = new Map();
    map[ID] = json['merchantId'];
    map[LOCAL_ID] = LocalIdGenerator.generate();
    map[STATUS] = json['status'];
    map[UPDATED_AT] = json['updated_at'];
    map[CREATED_AT] = json['created_at'];
    map[IS_SYNCED] = 1;
    map[PLAN_ID] = json['planId'];
    map[BUSINESS_TYPE_ID] = json['businessTypeId'];
    map[INDUSTRY_ID] = json['industryId'];
    map[INDUSTRY_NAME] = json['industryName'];
    map[CATEGORY_ID] = json['categoryId'];
    map[CATEGORY_NAME] = json['categoryName'];
    map[SUB_CATEGORY_ID] = json['subCategoryId'];
    map[SUB_CATEGORY] = json['subCategory'];
    map[SUB_CATEGORY_NAME] = json['subCategoryName'];
    map[COUNTRY_CODE] = json['countryCode'];
    map[COMPANY_NAME] = json['merchantCompanyName'];
    map[PAN_NUMBER] = json['merchantPANCode'];
    map[YEARLY_REVENUE] = json['merchantYearlyRevenue'];
    return map;
  }

  @override
  Map<String, dynamic> buildMap() {
    Map<String, dynamic> map = new Map();
    map[ID] = model.id;
    map[LOCAL_ID] = model.localId;
    map[STATUS] = model.status;
    map[UPDATED_AT] = model.updatedAt;
    map[CREATED_AT] = model.createdAt;
    map[IS_SYNCED] = model.isSync ? 1 : 0;
    map[PLAN_ID] = model.planId;
    map[BUSINESS_TYPE_ID] = model.businessPlanId;
    map[INDUSTRY_ID] = model.industryId;
    map[INDUSTRY_NAME] = model.industryName;
    map[CATEGORY_ID] = model.categoryId;
    map[CATEGORY_NAME] = model.categoryName;
    map[SUB_CATEGORY_ID] = model.subCategoryId;
    map[SUB_CATEGORY] = model.subCategory;
    map[SUB_CATEGORY_NAME] = model.subCategoryName;
    map[COUNTRY_CODE] = model.countryCode;
    map[COMPANY_NAME] = model.companyName;
    map[PAN_NUMBER] = model.panNumber;
    map[YEARLY_REVENUE] = model.yearlyRevenue;
    return map;
  }

  @override
  MerchantBuilder updatedAt(int updatedAt) {
    model.updatedAt = (updatedAt);
    return this;
  }

  @override
  MerchantBuilder createdAt(int createdAt) {
    model.createdAt = (createdAt);
    return this;
  }

  @override
  MerchantBuilder merchantId(String merchantId) {
    model.merchantId = (merchantId);
    return this;
  }

  @override
  MerchantBuilder status(int status) {
    model.status = (status);
    return this;
  }

  @override
  MerchantBuilder isSynced(bool isSynced) {
    model.isSync = (isSynced);
    return this;
  }

  @override
  MerchantBuilder name(String name) {
    model.name = (name);
    return this;
  }

  @override
  MerchantBuilder localId(String localId) {
    model.localId = (localId);
    return this;
  }
}
