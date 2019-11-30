import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/payments/credit_payment/widgets/balance_card.dart';
import 'package:epaisa_pos/src/views/payments/credit_payment/widgets/points_card.dart';
import 'package:flutter/material.dart';

class CreditPayment extends StatelessWidget {
  const CreditPayment({
    Key key,
    @required this.sHeight,
  }) : super(key: key);

  final double sHeight;

  @override
  Widget build(BuildContext context) {
    final tablet = isTablet(MediaQuery.of(context));
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final inputFontSize = hp(tablet ? 3 : 2.6);

    return Container(
      // color: Colors.green,
      child: Container(
        padding: EdgeInsets.only(bottom: hp(1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  PointsCard(hp: hp, wp: wp, isTablet: tablet),
                  BalanceCard(hp: hp, wp: wp, isTablet: tablet),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
