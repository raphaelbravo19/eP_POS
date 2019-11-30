import 'package:chopper/chopper.dart';
import 'package:epaisa_pos/data/initial/countries/api_service.dart';
import 'package:epaisa_pos/data/payments/models/transaction.dart';
import 'package:epaisa_pos/src/widgets/utils/request_helper.dart';

class Payment {
  String id;
  String object;
  String orderId;
  String userId;
  String storeId;
  String companyId;
  String merchantId;
  String currencyId;
  String updatedAt;
  String createdAt;
  int status;
  double subtotal;
  double amount;
  double discount;
  double tips;
  bool isSplit;
  List<Transaction> transactions;
  Payment(
      {String id,
      String object,
      String orderId,
      String userId,
      String storeId,
      String companyId,
      String merchantId,
      String currencyId,
      String updatedAt,
      String createdAt,
      int status,
      double subtotal,
      double amount,
      double discount,
      double tips,
      bool isSplit,
      List<Map<String, dynamic>> transactions}) {
    this.id = id;
    this.object = object;
    this.orderId = orderId;
    this.userId = userId;
    this.storeId = storeId;
    this.companyId = companyId;
    this.merchantId = merchantId;
    this.currencyId = currencyId;
    this.updatedAt = updatedAt;
    this.createdAt = createdAt;
    this.status = status;
    this.subtotal = subtotal;
    this.amount = amount;
    this.discount = discount;
    this.tips = tips;
    this.isSplit = isSplit;
    this.transactions =
        transactions.map((x) => Transaction.fromMap(x)).toList();
  }

  final api = ApiService.create();

  Future<Response> init() async {
    var key = await getauthkey();
    var response = await api.initPayment(authKey: key, body: {
      "orderId": this.orderId,
      "currencyId": this.currencyId,
      "amount": this.amount
    });
    return response;
  }

  Future<Response> process({Transaction transaction}) async {
    var key = await getauthkey();
    var response = await api.processPayment(authKey: key, body: {
      "paymentId": this.id,
      "currencyId": transaction.currencyId,
      "type": transaction.type,
      "amount": transaction.amount
    });
    return response;
  }

  static Payment fromMap(Map<String, dynamic> map) {
    return Payment(
      id: map['id'],
      object: map['object'],
      orderId: map['orderId'],
      userId: map['userId'],
      storeId: map['storeId'],
      companyId: map['companyId'],
      merchantId: map['merchantId'],
      currencyId: map['currencyId'],
      updatedAt: map['updatedAt'],
      createdAt: map['createdAt'],
      status: map['status'],
      subtotal: map['subtotal'],
      amount: map['amount'],
      discount: map['discount'],
      tips: map['tips'],
      isSplit: map['isSplit'],
    );
  }
}
