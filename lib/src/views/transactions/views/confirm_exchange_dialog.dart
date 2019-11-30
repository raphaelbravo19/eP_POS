import 'package:epaisa_pos/src/models/OrderItem.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/remove_over_scroll_glow.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/cash_register/cash_register.dart';
import 'package:epaisa_pos/src/views/payments/widgets/transaction_details.dart';
import 'package:epaisa_pos/src/views/saved_transactions/saved_transactions_screen.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/buttons/epaisa_button.dart';
import 'package:epaisa_pos/src/widgets/textfields/texfield_number.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:flutter/material.dart';

class ConfirmExchangeDialog extends StatefulWidget {
  ConfirmExchangeDialog({
    Key key,
  }) : super(key: key);

  @override
  ConfirmExchangeDialogState createState() => ConfirmExchangeDialogState();
}

class ConfirmExchangeDialogState extends State<ConfirmExchangeDialog> {
  bool showModal = true;
  bool resendDisabled = true;
  @override
  void initState() {
    super.initState();
  }

  void closeModal() {
    Navigator.of(context).pop();
    setState(() {
      showModal = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    Widget header() {
      return Container(
          padding: EdgeInsets.symmetric(vertical: hp(2)),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: AppColors.LightGray, width: 2.5))),
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Exchange",
                    style: TextStyle(
                        fontSize: tablet ? hp(3) : wp(5.6),
                        fontWeight: FontWeight.w700,
                        color: AppColors.DarkGray),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: wp(2)),
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showModal = false;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Image.asset(
                        "assets/general_icons/xbutton.png",
                        height: tablet ? hp(2.5) : wp(4.3),
                      ))),
            ],
          ));
    }

    Widget content() {
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
        width: (tablet ? wp(42) : wp(95)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              header(),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: hp(2), vertical: hp(1)),
                child: Column(
                  children: <Widget>[
                    TransactionDetails(
                      showInvoice: false,
                      items: orderItems,
                      isExpanded: true,
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
                      height: hp(20),
                      showMoreEnabled: false,
                      subTotal: '548.50',
                      discount: Discount(
                        calculated: '12.50',
                        value: '10',
                        type: '%',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: hp(2)),
                      child: EpaisaButton.medium(
                        borderRadius: BorderRadius.circular(hp(2)),
                        title: 'ADD MORE ITEMS',
                        onPress: () {},
                      ),
                    ),
                    Text(
                      'OR',
                      style: TextStyle(
                        fontSize: hp(3),
                        fontWeight: FontWeight.bold,
                        color: AppColors.BackPrimaryGray,
                      ),
                    ),
                    Container(
                      // margin: EdgeInsets.symmetric(vertical: hp(2)),
                      child: Buttons(
                        buttonSize: hp(8.5),
                        fontSize: hp(2),
                        gap: hp(2),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0),
      body: Container(
        alignment: Alignment.center,
        width: wp(100),
        height: hp(100),
        child: !showModal
            ? Container()
            : Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showModal = false;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: wp(100),
                      height: hp(100),
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                        width: (tablet ? wp(42) : wp(95)),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(),
                            ),
                            Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      tablet ? wp(1) : wp(3)),
                                  color: AppColors.PrimaryWhite,
                                ),
                                child: content()),
                            Expanded(
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  )
                ],
              ),
      ),
    );
  }
}
