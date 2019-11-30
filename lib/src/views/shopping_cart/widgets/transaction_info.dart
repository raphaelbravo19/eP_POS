import 'dart:io';

import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/shopping_cart/widgets/row_product.dart';
import 'package:epaisa_pos/src/views/transactions/views/send_receipt_dialog.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:flutter/material.dart';

class TransactionInfo extends StatelessWidget {
  final Function partialRefund;
  final Function fullRefund;
  TransactionInfo({
    @required this.partialRefund,
    @required this.fullRefund,
  });
  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    var isIOS = Platform.isIOS;

    void _showSendReceipt(BuildContext context) {
      // flutter defined function
      Navigator.of(context).push(new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return SendReceiptDialog();
        },
      ));
    }

    Widget _tabletProducts() {
      List<Map<String, dynamic>> products = [
        {
          "id": "1.",
          "description": "Heinz Ketchup",
          "Qty": "999",
          "Price": "145,148.50"
        },
        {
          "id": "2.",
          "description": "Custom Product 2",
          "Qty": "1",
          "Price": "125.00"
        },
        {
          "id": "3.",
          "description": "Custom Product 3",
          "Qty": "3",
          "Price": "275.50"
        },
      ];
      List<Widget> list = new List<Widget>();
      for (var i = 0; i < products.length; i++) {
        list.add(RowProduct(
          product: products[i],
          transaction: true,
        ));
      }
      Widget headerTable = Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: AppColors.TextGray.withOpacity(0.3),
            ),
          ),
        ),
        padding: EdgeInsets.fromLTRB(wp(0.2), hp(0.7), wp(1.6), hp(0.7)),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: tablet ? wp(2.5) : wp(6.2),
            ),
            Expanded(
              flex: 12,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Description",
                  style: TextStyle(
                      fontSize: hp(2),
                      fontWeight: FontWeight.w700,
                      color: AppColors.BackPrimaryGray),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Qty",
                  style: TextStyle(
                      fontSize: hp(2),
                      fontWeight: FontWeight.w700,
                      color: AppColors.BackPrimaryGray),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  "Price",
                  style: TextStyle(
                      fontSize: hp(2),
                      fontWeight: FontWeight.w700,
                      color: AppColors.BackPrimaryGray),
                ),
              ),
            )
          ],
        ),
      );

      return Expanded(
        child: Container(
          child: Column(
            children: <Widget>[
              headerTable,
              products.length > 0
                  ? Expanded(child: ListView(children: list))
                  : Expanded(
                      child: Container(
                      alignment: Alignment.center,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 20,
                              height: hp(22),
                            ),
                            SizedBox(
                              height: hp(2),
                            ),
                            Text(
                              "Your Cart is empty",
                              style: TextStyle(
                                  fontSize: hp(2.7),
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.IconGray),
                            )
                          ],
                        ),
                      ),
                    )),
            ],
          ),
        ),
      );
    }

    Widget _cardInfo() {
      return Container(
        padding: EdgeInsets.fromLTRB(wp(1), 0, wp(1), 0),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    width: 1, color: AppColors.TextGray.withOpacity(0.3)))),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: hp(1.8),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: hp(1.5)),
              decoration: BoxDecoration(
                color: AppColors.LightDarkWhite,
                borderRadius: BorderRadius.circular(hp(1)),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.DarkGray.withOpacity(0.7),
                      offset: Offset(-0.7, 2),
                      blurRadius: 2)
                ],
              ),
              child: Column(
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: wp(1.3)),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Payment ID",
                                style: TextStyle(
                                    fontSize: isIOS ? wp(1.2) : hp(1.8),
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.DarkGray),
                              ),
                              SizedBox(
                                height: hp(0.6),
                              ),
                              Text(
                                "Status",
                                style: TextStyle(
                                    fontSize: isIOS ? wp(1.2) : hp(1.8),
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.DarkGray),
                              )
                            ],
                          ),
                          SizedBox(
                            width: wp(2),
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                ":",
                                style: TextStyle(
                                    fontSize: isIOS ? wp(1.2) : hp(1.8),
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.DarkGray),
                              ),
                              SizedBox(
                                height: hp(0.6),
                              ),
                              Text(
                                ":",
                                style: TextStyle(
                                    fontSize: isIOS ? wp(1.2) : hp(1.8),
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.DarkGray),
                              )
                            ],
                          ),
                          SizedBox(
                            width: wp(2),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "7894654",
                                style: TextStyle(
                                    fontSize: isIOS ? wp(1.2) : hp(1.8),
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.DarkGray),
                              ),
                              SizedBox(
                                height: hp(0.6),
                              ),
                              Text(
                                "Approved",
                                style: TextStyle(
                                    fontSize: isIOS ? wp(1.2) : hp(1.8),
                                    fontWeight: FontWeight.w500,
                                    color: TransactionColors.Approved),
                              )
                            ],
                          )
                        ],
                      )),
                  Container(
                    padding: EdgeInsets.only(left: wp(1.3), right: wp(0.9)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(vertical: hp(0.5)),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color:
                                              AppColors.LightGray.withOpacity(
                                                  0.4),
                                          width: 2))),
                              child: Row(
                                children: <Widget>[
                                  Text("PAID ",
                                      style: TextStyle(
                                          fontSize: isIOS ? wp(1.8) : hp(2.6),
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.4,
                                          color: AppColors.SuccessText)),
                                  Container(
                                    padding: EdgeInsets.only(top: hp(0.5)),
                                    child: Text("06/23/17 at 4:19 PM",
                                        style: TextStyle(
                                            fontSize: isIOS ? wp(1.1) : hp(1.6),
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.7,
                                            color: AppColors.DarkGray)),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: hp(1)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: wp(0.65)),
                                    height: hp(2.5),
                                    width: hp(2.5) * 1.5,
                                    color: AppColors.PrimaryBlue,
                                  ),
                                  Text("Visa  |  9086",
                                      style: TextStyle(
                                          fontSize: isIOS ? wp(1.4) : hp(1.7),
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.2,
                                          color: AppColors.BackSecondGray))
                                ],
                              ),
                            )
                          ],
                        ),
                        Text(
                          "₹ 456.00",
                          style: TextStyle(
                              fontSize: isIOS ? wp(1.9) : hp(2.9),
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.4,
                              color: AppColors.PrimaryBlue),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: hp(1.3),
            ),
            Row(children: <Widget>[
              Expanded(
                child: ButtonGradient(
                  borderRadius: 5,
                  shadowLevel: 2,
                  disabled: true,
                  fontSize: wp(1.6),
                  paddingVertical: hp(1.5),
                  fontWeight: FontWeight.w700,
                  textColor: AppColors.DarkGray,
                  title: "PRINT",
                  letterSpacing: 0,
                ),
              ),
              SizedBox(
                width: wp(1),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => _showSendReceipt(context),
                  child: ButtonGradient(
                    borderRadius: 5,
                    shadowLevel: 2,
                    disabled: true,
                    fontSize: wp(1.6),
                    paddingVertical: hp(1.5),
                    fontWeight: FontWeight.w700,
                    textColor: AppColors.DarkGray,
                    title: "SEND",
                    letterSpacing: 0,
                  ),
                ),
              )
            ]),
            SizedBox(
              height: hp(1.3),
            ),
            Row(children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    partialRefund();
                  },
                  child: ButtonGradient(
                    borderRadius: 5,
                    shadowLevel: 2,
                    disabled: true,
                    fontSize: wp(1.6),
                    paddingVertical: hp(1.5),
                    fontWeight: FontWeight.w700,
                    textColor: AppColors.DarkGray,
                    title: "PARTIAL REFUND",
                    letterSpacing: 0,
                  ),
                ),
              ),
              SizedBox(
                width: wp(1),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    fullRefund();
                  },
                  child: ButtonGradient(
                    borderRadius: 5,
                    shadowLevel: 2,
                    disabled: true,
                    fontSize: wp(1.6),
                    paddingVertical: hp(1.5),
                    fontWeight: FontWeight.w700,
                    textColor: AppColors.DarkGray,
                    title: "FULL REFUND",
                    letterSpacing: 0,
                  ),
                ),
              )
            ]),
            SizedBox(
              height: hp(1.3),
            ),
          ],
        ),
      );
    }

    Widget _getFooter() {
      return _cardInfo();

      // return _fotterContainer();
    }

    return Expanded(
      child: Column(
        children: <Widget>[
          _tabletProducts(),
          _getFooter(),
        ],
      ),
    );
  }
}
