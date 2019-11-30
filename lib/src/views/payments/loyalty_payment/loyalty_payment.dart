import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/payments/widgets/pay_amount.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_card.dart';
import 'package:epaisa_pos/src/widgets/buttons/epaisa_button.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class LoyaltyPayment extends StatefulWidget {
  const LoyaltyPayment({
    Key key,
    @required this.sHeight,
  }) : super(key: key);

  final double sHeight;

  @override
  _LoyaltyPaymentState createState() => _LoyaltyPaymentState();
}

class _LoyaltyPaymentState extends State<LoyaltyPayment> {
  Widget currentScreen;
  double sliderValue = 0.5;
  @override
  Widget build(BuildContext context) {
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final bool tablet = isTablet(MediaQuery.of(context));
    return Container(
      // color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                child: PayAmount(
                  paddingTop: 0,
                  bottomText: 'Balance Amount: ₹ 70.00 ',
                ),
              ),
              EpaisaCard(
                margin:
                    EdgeInsets.symmetric(horizontal: hp(1), vertical: hp(1.6)),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: hp(10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFEBEBEB),
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(hp(1)),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: hp(7),
                              width: hp(7),
                              margin: EdgeInsets.only(right: hp(2)),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/customers/personal.png'),
                                ),
                                color: AppColors.BackPrimaryGray,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Expanded(
                              flex: 80,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Abhishek Maurya',
                                    style: TextStyle(
                                      color: AppColors.BackPrimaryGray,
                                      fontWeight: FontWeight.w600,
                                      fontSize: tablet ? hp(3) : wp(5),
                                    ),
                                  ),
                                  Text(
                                    '174 265 44',
                                    style: TextStyle(
                                      color: AppColors.BackPrimaryGray,
                                      fontWeight: FontWeight.w600,
                                      fontSize: tablet ? hp(2) : wp(3.5),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 20,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '500',
                                    style: TextStyle(
                                      color: AppColors.BackPrimaryGray,
                                      fontWeight: FontWeight.w600,
                                      fontSize: tablet ? hp(3) : wp(5),
                                    ),
                                  ),
                                  Text(
                                    'Points',
                                    style: TextStyle(
                                      color: AppColors.BackPrimaryGray,
                                      fontWeight: FontWeight.w600,
                                      fontSize: tablet ? hp(2) : wp(3.5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFEBEBEB),
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: hp(2),
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: AppColors.DisabledBorder, width: 2),
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 50,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: hp(2)),
                                    child: Text(
                                      'Redeem Points',
                                      style: TextStyle(
                                        color: AppColors.DarkGray,
                                        fontWeight: FontWeight.w600,
                                        fontSize: tablet ? hp(2.4) : wp(3.5),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 25,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    eptxt('point'),
                                    style: TextStyle(
                                      color:
                                          AppColors.DarkGray.withOpacity(0.8),
                                      fontWeight: FontWeight.w600,
                                      fontSize: tablet ? hp(2) : wp(3),
                                    ),
                                  ),
                                  TextfieldClassic(
                                    center: true,
                                    noClear: true,
                                    fontSize: hp(2.4),
                                    paddingBottomInput: hp(0.5),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: tablet ? hp(5) : wp(10),
                              child: Text(
                                "=",
                                style: TextStyle(
                                  color: AppColors.PrimaryBlue,
                                  fontWeight: FontWeight.w600,
                                  fontSize: hp(2.2),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 25,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '${eptxt('amount')} (₹)',
                                    style: TextStyle(
                                      color:
                                          AppColors.DarkGray.withOpacity(0.8),
                                      fontWeight: FontWeight.w600,
                                      fontSize: tablet ? hp(2) : wp(3),
                                    ),
                                  ),
                                  TextfieldClassic(
                                    center: true,
                                    noClear: true,
                                    fontSize: hp(2.4),
                                    paddingBottomInput: hp(0.5),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      height: hp(14),
                    ),
                    Container(
                      height: hp(12),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 18,
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                '0 pts',
                                style: TextStyle(
                                  color: AppColors.BackPrimaryGray,
                                  fontWeight: FontWeight.w600,
                                  fontSize: tablet ? hp(2.4) : wp(4),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 64,
                            child: Container(
                              child: Slider(
                                activeColor: AppColors.PrimaryBlue,
                                inactiveColor: Colors.grey,
                                onChanged: (double values) {
                                  setState(() {
                                    sliderValue = values;
                                  });
                                },
                                value: sliderValue,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 18,
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                '500 pts',
                                style: TextStyle(
                                  color: AppColors.BackPrimaryGray,
                                  fontWeight: FontWeight.w600,
                                  fontSize: tablet ? hp(2.4) : wp(4),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
