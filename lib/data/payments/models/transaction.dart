import 'package:epaisa_pos/data/initial/countries/api_service.dart';

class Transaction {
  String id;
  String object;
  String paymentId;
  String userId;
  String storeId;
  String companyId;
  String merchantId;
  int status;
  String currencyId;
  String type;
  double amount;
  String createdAt;
  String updatedAt;

  Transaction(
      {String id,
      String object,
      String paymentId,
      String userId,
      String storeId,
      String companyId,
      String merchantId,
      int status,
      String currencyId,
      String type,
      double amount,
      String createdAt,
      String updatedAt}) {
    this.id = id;
    this.object = object;
    this.paymentId = paymentId;
    this.userId = userId;
    this.storeId = storeId;
    this.companyId = companyId;
    this.merchantId = merchantId;
    this.status = status;
    this.currencyId = currencyId;
    this.type = type;
    this.amount = amount;
    this.updatedAt = updatedAt;
    this.createdAt = createdAt;
  }

  final api = ApiService.create();

  static Transaction fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      object: map['object'],
      paymentId: map['paymentId'],
      userId: map['userId'],
      storeId: map['storeId'],
      companyId: map['companyId'],
      merchantId: map['merchantId'],
      currencyId: map['currencyId'],
      updatedAt: map['updatedAt'],
      createdAt: map['createdAt'],
      status: map['status'],
      type: map['type'],
      amount: map['amount'],
    );
  }
}
