import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:flutter/material.dart';

class CardPayment extends StatefulWidget {
  CardPayment({
    Key key,
    @required this.sHeight,
  }) : super(key: key);

  final double sHeight;
  final List<Map<String, String>> status = [
    {
      "title": eptxt('card_payment_swipe_insert'),
      "image": 'assets/payments/card/insert.png'
    },
    {
      "title": eptxt('card_payment_type_pin'),
      "image": 'assets/payments/card/type_pin.png'
    },
    {
      "title": eptxt('card_payment_verifying'),
      "image": 'assets/payments/card/verifying.png',
    },
    {
      "title": eptxt('card_payment_failed'),
      "image": 'assets/payments/card/error.png',
      "subtitle": eptxt('error_504'),
      "text": eptxt('verify_connection'),
    },
    {
      "title": eptxt('card_payment_succesful'),
      "image": 'assets/payments/card/success.png',
    },
  ];
  @override
  _CardPaymentState createState() => _CardPaymentState();
}

class _CardPaymentState extends State<CardPayment> {
  var collectNow = true;
  var statusIndex = 0;
  @override
  Widget build(BuildContext context) {
    final tablet = isTablet(MediaQuery.of(context));
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final inputFontSize = hp(tablet ? 3 : 2.6);

    return Container(
      // color: Colors.green,
      // color: Colors.red,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Container(
                padding: EdgeInsets.only(top: hp(2.5), bottom: hp(2)),
                alignment: Alignment.center,
                child: Text(
                  widget.status[statusIndex]['title'],
                  style: TextStyle(
                    color: AppColors.PrimaryBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: tablet ? hp(2.8) : wp(5),
                    letterSpacing: hp(0.3),
                  ),
                ),
              ),
            ),
            Container(
              child: Container(
                alignment: Alignment.topCenter,
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          statusIndex =
                              statusIndex == (widget.status.length - 1)
                                  ? 0
                                  : statusIndex + 1;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: hp(2)),
                        child: Image.asset(widget.status[statusIndex]['image']),
                        width: hp(36),
                      ),
                    ),
                    if (tablet)
                      SizedBox(
                        height: hp(4),
                      ),
                    if (widget.status[statusIndex]['subtitle'] != null)
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(
                          horizontal: hp(4),
                        ),
                        margin: EdgeInsets.symmetric(vertical: hp(0.5)),
                        child: Text(
                          widget.status[statusIndex]['subtitle'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: hp(2.6),
                            color: AppColors.BackPrimaryGray,
                          ),
                        ),
                      ),
                    if (widget.status[statusIndex]['text'] != null)
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(
                          horizontal: hp(4),
                        ),
                        child: Text(
                          widget.status[statusIndex]['text'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: tablet ? hp(1.9) : wp(3),
                            color: AppColors.BackPrimaryGray,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
