import 'package:epaisa_pos/src/models/OrderItem.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/invoice/widgets/details_card.dart';
import 'package:epaisa_pos/src/views/payments/checkout/checkout.dart';
import 'package:epaisa_pos/src/views/payments/widgets/pay_amount.dart';
import 'package:epaisa_pos/src/views/payments/widgets/transaction_details.dart';
import 'package:epaisa_pos/src/views/saved_transactions/saved_transactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SplitPayment extends StatefulWidget {
  const SplitPayment({
    Key key,
    @required this.sHeight,
  }) : super(key: key);

  final double sHeight;

  @override
  _SplitPaymentState createState() => _SplitPaymentState();
}

class _SplitPaymentState extends State<SplitPayment> {
  Widget currentScreen;

  @override
  Widget build(BuildContext context) {
    final tablet = ScreenUtils.of(context).isTablet;
    return tablet
        ? buildLandscapeContent(context)
        : buildPortraitContent(context);
  }

  Container buildPortraitContent(BuildContext context) {
    final Function hp = ScreenUtils.of(context).hp;
    final Function wp = ScreenUtils.of(context).wp;
    return Container(
      // color: Colors.green,
      height: widget.sHeight * 0.75,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: hp(4)),
            margin: EdgeInsets.only(top: hp(1), bottom: hp(0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  eptxt('amount_paid').toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.BackPrimaryGray,
                    fontSize: hp(2.5),
                  ),
                ),
                Text(
                  '₹ 500.00',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.BackPrimaryGray,
                    fontSize: hp(2.5),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: PayAmount(),
            // color: Colors.red,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: hp(2)),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: hp(tablet ? 0 : 2)),
              scrollDirection: Axis.horizontal,
              child: ButtonsScroll(
                showSplit: false,
                marginRight: tablet ? hp(2) : hp(1.8),
                fontSize: hp(2),
                buttonSize: hp(tablet ? 11 : wp(2.4)),
                onButtonPress: ({paymentBuilder}) {
                  setState(() {
                    currentScreen = paymentBuilder();
                  });
                },
                tWidth: MediaQuery.of(context).size.width - 16,
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildLandscapeContent(BuildContext context) {
    final Function hp = ScreenUtils.of(context).hp;
    final Function wp = ScreenUtils.of(context).wp;
    final List<OrderItem> orderItems = [
      OrderItem(
        description: 'Heinz Ketchup',
        price: '145.00',
        quantity: '1',
      ),
      OrderItem(
        description: 'Custom Product 2',
        price: '145.00',
        quantity: '1',
        discount: Discount(calculated: '14.50', type: '%', value: '10'),
      ),
      OrderItem(
        description: 'Custom Product 3',
        price: '145.00',
        quantity: '3',
      ),
    ];
    return Container(
      // color: Colors.green,
/*       height: widget.sHeight * 0.93,
 */

      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: hp(1)),
              child: Container(
                padding: EdgeInsets.only(
                  top: hp(2),
                ),
                // color: Colors.red,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: hp(2)),
                      child: Container(
                        child: TransactionDetails(
                          expandHeight: getExpandHeight(
                            hp,
                            orderItems,
                            '12.50',
                            Discount(
                              calculated: '12.50',
                              value: '10',
                              type: '%',
                            ),
                          ),
                          height: (widget.sHeight * 0.25) - hp(4),
                          showMoreEnabled: false,
                          isTablet: true,
                          items: orderItems,
                          subTotal: '548.50',
                          discount: Discount(
                            calculated: '12.50',
                            value: '10',
                            type: '%',
                          ),
                        ),
                      ),
                    ),
                    DetailsCard(
                      isTablet: true,
                      footer: false,
                      headerBackgroundColor: AppColors.NotificationGreen,
                      headerTextColor: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: hp(1)),
              child: Container(
                padding: EdgeInsets.symmetric(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: PayAmount(
                        paddingTop: hp(2),
                      ),
                      margin: EdgeInsets.only(bottom: hp(3)),
                    ),
                    ButonsLandscape(
                      onButtonPress: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
