class PaymentResponse {
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

  PaymentResponse(
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
      bool isSplit}) {
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
  }
  static PaymentResponse fromMap(Map<String, dynamic> map) {
    return PaymentResponse(
      id: map['id'],
      object: map['object'],
      orderId: map['orderId'],
      userId: map['orderId'],
      storeId: map['orderId'],
      companyId: map['orderId'],
      merchantId: map['orderId'],
      currencyId: map['orderId'],
      updatedAt: map['orderId'],
      createdAt: map['orderId'],
      status: map['orderId'],
      subtotal: map['orderId'],
      amount: map['orderId'],
      discount: map['orderId'],
      tips: map['tips'],
      isSplit: map['orderId'],
      
    );
  }
}
