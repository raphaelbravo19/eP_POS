import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/payment_button_names.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_card.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_border.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/buttons/epaisa_button.dart';
import 'package:epaisa_pos/src/widgets/buttons/payment_method_button.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:flutter/material.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';

class UpiPayment extends StatefulWidget {
  const UpiPayment({
    Key key,
    @required this.sHeight,
  }) : super(key: key);

  final double sHeight;

  @override
  _UpiPaymentState createState() => _UpiPaymentState();
}

class _UpiPaymentState extends State<UpiPayment> {
  var collectNow = true;
  @override
  Widget build(BuildContext context) {
    final tablet = ScreenUtils.of(context).isTablet;
    final hp = ScreenUtils.of(context).hp;
    final wp = ScreenUtils.of(context).wp;
    final inputFontSize = hp(tablet ? 3 : 2.6);

    return Container(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Center(
              child: EpaisaCard(
                margin: EdgeInsets.all(8),
                header: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(
                      horizontal: hp(1.5),
                      // vertical: hp(3),
                    ),
                    height: hp(8),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: tablet ? hp(6.5) : hp(6),
                          alignment: Alignment.bottomCenter,
                          child: PaymentMethodButton(
                            onPress: () {},
                            marginRight: tablet ? hp(2) : wp(2.6),
                            paymentName: PaymentButtonNames.UpiPayments,
                            size: tablet ? hp(6.5) : hp(6),
                          ),
                        ),
                        Text(
                          eptxt('payment_button_upi'),
                          style: TextStyle(
                            color: AppColors.BackPrimaryGray,
                            fontWeight: FontWeight.bold,
                            fontSize: tablet ? hp(2.8) : wp(5),
                          ),
                        ),
                      ],
                    )),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: hp(4),
                    vertical: hp(3),
                  ),
                  child: Column(
                    children: <Widget>[
                      TextfieldClassic(
                        paddingBottomInput: hp(1),
                        fontSize: tablet ? hp(2.6) : wp(4),
                        labelText: eptxt('upi_payment_virtual_address'),
                      ),
                      SizedBox(
                        height: hp(1),
                      ),
                      TextfieldClassic(
                        paddingBottomInput: hp(1),
                        fontSize: tablet ? hp(2.6) : wp(4),
                        labelText: eptxt('upi_payment_remark'),
                      ),
                      SizedBox(
                        height: hp(2.4),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(right: hp(1)),
                              child: collectNow
                                  ? ButtonGradient(
                                      paddingVertical:
                                          tablet ? hp(2.35) : hp(2.5),
                                      borderRadius: hp(3.4),
                                      fontSize: tablet ? hp(2) : wp(3.3),
                                      title: eptxt('upi_payment_collect_now')
                                          .toUpperCase(),
                                      callback: () {
                                        setState(() {
                                          collectNow = true;
                                        });
                                      },
                                    )
                                  : ButtonBorder(
                                      paddingVertical:
                                          tablet ? hp(2.05) : hp(2.2),
                                      borderRadius: hp(3.4),
                                      fontSize: tablet ? hp(2) : wp(3.3),
                                      title: eptxt('upi_payment_collect_now')
                                          .toUpperCase(),
                                      callback: () {
                                        setState(() {
                                          collectNow = true;
                                        });
                                      },
                                    ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: hp(1)),
                              child: !collectNow
                                  ? ButtonGradient(
                                      paddingVertical:
                                          tablet ? hp(2.35) : hp(2.5),
                                      borderRadius: hp(3.4),
                                      fontSize: tablet ? hp(2) : wp(3.3),
                                      title: eptxt('upi_payment_collect_later')
                                          .toUpperCase(),
                                      callback: () {
                                        setState(() {
                                          collectNow = false;
                                        });
                                      },
                                    )
                                  : ButtonBorder(
                                      paddingVertical:
                                          tablet ? hp(2.05) : hp(2.2),
                                      borderRadius: hp(3.4),
                                      fontSize: tablet ? hp(2) : wp(3.3),
                                      title: eptxt('upi_payment_collect_later')
                                          .toUpperCase(),
                                      callback: () {
                                        setState(() {
                                          collectNow = false;
                                        });
                                      },
                                    ),
                            ),
                          )
                        ],
                      ),
                      if (!collectNow)
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: hp(2.4),
                            ),
                            TextfieldClassic.withDatePicker(
                              disable: true,
                              isIcon: true,
                              firstDate: 1955,
                              lastDate: 2020,
                              ctx: context,
                              paddingBottomInput: hp(1),
                              fontSize: tablet ? hp(2.6) : wp(4),
                              labelText: eptxt('date'),
                            ),
                            SizedBox(
                              height: hp(1),
                            ),
                            TextfieldClassic.withTimePicker(
                              disable: true,
                              firstDate: 1955,
                              lastDate: 2020,
                              ctx: context,
                              paddingBottomInput: hp(1),
                              fontSize: tablet ? hp(2.6) : wp(4),
                              labelText: eptxt('time'),
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
