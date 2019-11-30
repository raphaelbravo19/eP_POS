import 'package:flutter/material.dart';

class OrderItem {
  final Discount discount;
  final String quantity;
  final String price;
  final String description;
  // final Map<String, dynamic> customOrder;
  OrderItem({
    @required this.description,
    @required this.quantity,
    @required this.price,
    this.discount,
    // this.customOrder = const {
    //   "first": {"column": 'description', "flex": 50},
    //   "second": {"column": 'description', "flex": 25},
    //   "third": {"column": 'description', "flex": 25}
    // }
  });

  // get height {
  //   return 3.6;
  // }
}

class Discount {
  final String calculated;
  final String type;
  final String value;

  Discount({this.type, this.value, this.calculated});
}
