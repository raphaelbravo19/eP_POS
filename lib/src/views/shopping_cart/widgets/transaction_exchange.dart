import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/shopping_cart/widgets/row_product.dart';
import 'package:epaisa_pos/src/views/transactions/views/send_receipt_dialog.dart';
import 'package:epaisa_pos/src/widgets/buttons/epaisa_button.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class TransactionExchange extends StatelessWidget {
  final Function partialRefund;
  final Function fullRefund;
  TransactionExchange({
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
          "description": "AADBURY BOURN VITA & LAYS SOUR",
          "Qty": "3",
          "Price": "75.00"
        },
      ];
      List<Widget> list = new List<Widget>();
      for (var i = 0; i < products.length; i++) {
        list.add(RowProduct(product: products[i]));
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
                    color: AppColors.BackPrimaryGray,
                  ),
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
                    color: AppColors.BackPrimaryGray,
                  ),
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
                    color: AppColors.BackPrimaryGray,
                  ),
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

    return Expanded(
      child: Column(
        children: <Widget>[
          _tabletProducts(),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.LightGray,
                  width: 0.5,
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: hp(2), vertical: hp(1)),
            child: Column(
              children: <Widget>[
                TotalAmountRow(
                  hp: hp,
                  name: 'Sub Total',
                  value: '₹ 100.00',
                ),
                TotalAmountRow(
                  hp: hp,
                  name: 'SGST',
                  value: '₹ 4.50',
                ),
                TotalAmountRow(
                  hp: hp,
                  name: 'CGST',
                  value: '₹ 4.50',
                ),
                TotalAmountRow(
                  hp: hp,
                  name: 'Credit',
                  value: '- ₹ 100.00',
                  color: AppColors.DiscountText,
                ),
                TotalAmountRow(
                  hp: hp,
                  name: 'Balance Amount',
                  value: '- ₹ 100.00',
                  fontSize: hp(2.8),
                ),
                Container(
                  child: EpaisaButton.medium(
                    fontSize: isIOS? hp(2.2) : hp(2.4),
                    title: 'ISSUE CREDIT NOTE',
                    borderRadius: BorderRadius.circular(hp(0.8)),
                    onPress: () {},
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TotalAmountRow extends StatelessWidget {
  const TotalAmountRow({
    Key key,
    @required this.hp,
    @required this.name,
    @required this.value,
    this.color,
    this.fontSize,
  }) : super(key: key);

  final Function hp;
  final Color color;
  final String name;
  final String value;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: hp(0.5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            name,
            style: TextStyle(
              fontSize: fontSize != null ? fontSize : hp(2.4),
              fontWeight: FontWeight.w700,
              color: color != null ? color : AppColors.BackPrimaryGray,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fontSize != null ? fontSize : hp(2.4),
              fontWeight: FontWeight.w700,
              color: color != null ? color : AppColors.PrimaryBlue,
            ),
          ),
        ],
      ),
    );
  }
}
