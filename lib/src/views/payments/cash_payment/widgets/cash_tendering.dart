import 'dart:io';

import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/views/cash_register/cash_register.dart';
import 'package:epaisa_pos/src/views/payments/widgets/tendering_button.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class CashTendering extends StatefulWidget {
  final Function updateAmount;
  final BehaviorSubject amountStream;
  const CashTendering({Key key, this.updateAmount, this.amountStream})
      : super(key: key);

  @override
  _CashTenderingState createState() => _CashTenderingState();
}

class _CashTenderingState extends State<CashTendering> {
  List<Map<String, dynamic>> buttons = [
    {
      'title': '₹ 2000',
      'value': 2000,
      'count': 0,
      'colors': {
        'first': Color.fromRGBO(171, 108, 175, 1),
        'second': Color.fromRGBO(253, 225, 255, 1),
      }
    },
    {
      'title': '₹ 200',
      'value': 200,
      'count': 0,
      'colors': {
        'first': Color.fromRGBO(233, 139, 66, 1),
        'second': Color.fromRGBO(255, 197, 153, 1),
      }
    },
    {
      'title': '₹ 50',
      'value': 50,
      'count': 0,
      'colors': {
        'first': Color.fromRGBO(107, 214, 199, 1),
        'second': Color.fromRGBO(173, 255, 243, 1),
      }
    },
    {
      'title': '₹ 10',
      'value': 10,
      'count': 0,
      'colors': {
        'first': Color.fromRGBO(181, 142, 125, 1),
        'second': Color.fromRGBO(255, 217, 200, 1),
      }
    },
    {
      'title': '₹ 500',
      'value': 500,
      'count': 0,
      'colors': {
        'first': Color.fromRGBO(154, 150, 139, 1),
        'second': Color.fromRGBO(223, 220, 212, 1),
      }
    },
    {
      'title': '₹ 100',
      'value': 100,
      'count': 0,
      'colors': {
        'first': Color.fromRGBO(146, 139, 229, 1),
        'second': Color.fromRGBO(217, 214, 255, 1),
      }
    },
    {
      'title': '₹ 20',
      'value': 20,
      'count': 0,
      'colors': {
        'first': Color.fromRGBO(206, 105, 89, 1),
        'second': Color.fromRGBO(255, 192, 182, 1),
      }
    },
    {
      'title': '₹ 5',
      'value': 5,
      'count': 0,
      'colors': {
        'first': Color.fromRGBO(156, 173, 129, 1),
        'second': Color.fromRGBO(215, 234, 183, 1),
      }
    },
  ];
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hp = ScreenUtils.of(context).hp;
    final wp = ScreenUtils.of(context).wp;
    final isTablet = ScreenUtils.of(context).isTablet;
    bool isIOS = Platform.isIOS;
    return Container(
      // color: Colors.red,
      padding: EdgeInsets.only(
          left: tablet ? hp(1) : hp(2),
          right: tablet ? hp(1) : hp(2),
          bottom: 0,
          top: 0),
      child:
          // PayAmount(),
          Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            // color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  eptxt('cash_register_easy_tendering'),
                  style: TextStyle(
                    fontSize: isTablet ? hp(3) : wp(6),
                    fontWeight: FontWeight.w600,
                    color: AppColors.BackPrimaryGray,
                  ),
                ),
                Text(
                  multilang.get('cash_register_cash_tendering_descripition'),
                  style: TextStyle(
                    fontSize: isTablet ? hp(1.8) : wp(3.2),
                    fontWeight: FontWeight.w600,
                    color: AppColors.BackPrimaryGray,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: tablet ? isIOS ? hp(31) : hp(29) : isIOS ? hp(34) : hp(37),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          // color: Colors.green,
                          padding: EdgeInsets.only(
                              top: hp(0.5), bottom: 0, right: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              ...buttons.sublist(0, 4).map((button) {
                                return Expanded(
                                  //margin: EdgeInsets.only(bottom: hp(1)),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        top: tablet ? hp(0.8) : hp(1.2),
                                        bottom: tablet ? hp(0.8) : hp(1.2)),
                                    child: TenderingButton(
                                      onTap: () {
                                        if (widget.amountStream.value >
                                            cashRegisterBloc
                                                .streamTotal.value) {
                                          return;
                                        }
                                        if (widget.updateAmount != null) {
                                          widget.updateAmount(
                                              (button['value'] as int)
                                                  .toDouble());
                                        }
                                        setState(() {
                                          button['count'] = button['count'] + 1;
                                        });
                                      },
                                      buttonColor: button['colors']['first'],
                                      iconColor: button['colors']['second'],
                                      title: button['title'],
                                      iconRight: button['count'] > 0
                                          ? FittedBox(
                                              child: Text(
                                                '${'x' + button['count'].toString()}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      AppColors.BackPrimaryGray,
                                                  fontSize:
                                                      tablet ? hp(2) : wp(3.2),
                                                  letterSpacing: hp(0.1),
                                                ),
                                              ),
                                            )
                                          : null,
                                      iconLeftTap: () {
                                        if (button['count'] == 0) return;
                                        if (widget.updateAmount != null) {
                                          widget.updateAmount(
                                              (-1 * button['value'] as int)
                                                  .toDouble());
                                        }
                                        setState(() {
                                          button['count'] = button['count'] - 1;
                                        });
                                      },
                                      iconLeft: button['count'] > 0
                                          ? Icon(
                                              Icons.remove,
                                              size: hp(2.5),
                                            )
                                          : null,
                                    ),
                                  ),
                                );
                              }).toList()
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              top: hp(0.5), bottom: 0, left: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              ...buttons.sublist(4, 8).map((button) {
                                return Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        top: tablet ? hp(0.8) : hp(1.2),
                                        bottom: tablet ? hp(0.8) : hp(1.2)),
                                    child: TenderingButton(
                                      onTap: () {
                                        if (widget.amountStream.value >
                                            cashRegisterBloc
                                                .streamTotal.value) {
                                          return;
                                        }
                                        if (widget.updateAmount != null) {
                                          widget.updateAmount(
                                              (button['value'] as int)
                                                  .toDouble());
                                        }
                                        setState(() {
                                          button['count'] = button['count'] + 1;
                                        });
                                      },
                                      buttonColor: button['colors']['first'],
                                      iconColor: button['colors']['second'],
                                      title: button['title'],
                                      iconRight: button['count'] > 0
                                          ? FittedBox(
                                              child: Text(
                                                '${'x' + button['count'].toString()}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      AppColors.BackPrimaryGray,
                                                  fontSize:
                                                      tablet ? hp(2) : wp(3.2),
                                                  letterSpacing: hp(0.1),
                                                ),
                                              ),
                                            )
                                          : null,
                                      iconLeftTap: () {
                                        if (button['count'] == 0) return;
                                        if (widget.updateAmount != null) {
                                          widget.updateAmount(
                                              (-1 * button['value'] as int)
                                                  .toDouble());
                                        }
                                        setState(() {
                                          button['count'] = button['count'] - 1;
                                        });
                                      },
                                      iconLeft: button['count'] > 0
                                          ? Icon(
                                              Icons.remove,
                                              size: hp(2.5),
                                            )
                                          : null,
                                    ),
                                  ),
                                );
                              }).toList()
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
