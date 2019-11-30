import 'dart:io';

import 'package:epaisa_pos/src/bloc/bloc.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/customers/widgets/circle_button.dart';
import 'package:epaisa_pos/src/views/personal/widgets/personal_widget.dart';
import 'package:epaisa_pos/src/widgets/cards/toggle_card.dart';
import 'package:epaisa_pos/src/widgets/textfields/texfield_number.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:flutter/material.dart';
import 'package:epaisa_pos/src/views/transactions/transactions_screen.dart';
import 'package:intl/intl.dart';

class CustomerPersonalScreen extends StatefulWidget {
  @override
  _CustomerPersonalScreenState createState() => _CustomerPersonalScreenState();
}

class _CustomerPersonalScreenState extends State<CustomerPersonalScreen> {
  bool creditPermission = false;
  final locationBloc = LocationBloc();
  @override
  void dispose() {
    locationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    bool isIOS = Platform.isIOS;

    Widget _buildCardInfoAndroid() {
      return Container(
        padding: EdgeInsets.fromLTRB(
            tablet ? wp(1.3) : wp(2.9),
            tablet ? hp(1) : hp(0.8),
            tablet ? wp(1.22) : wp(2.9),
            tablet ? hp(2.74) : hp(2.3)),
        margin: EdgeInsets.only(top: hp(1)),
        width: tablet ? wp(43) : wp(100),
        height: wp((tablet ? 43 : 100) * 880 / 1412),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/customers/card.png"),
                fit: BoxFit.fitWidth)),
        child: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                padding: EdgeInsets.only(
                    left: tablet ? wp(2.5) : wp(5),
                    bottom: tablet ? hp(3) : hp(2.2)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: tablet ? hp(3) : hp(2.2)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Stack(
                            alignment: Alignment.bottomLeft,
                            children: <Widget>[
                              Container(
                                height: tablet ? hp(8.5) : wp(15),
                                width: tablet ? hp(8.5) : wp(15),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/customers/personal.png")),
                                    color: AppColors.DarkGray,
                                    shape: BoxShape.circle),
                              ),
                              Image.asset(
                                "assets/general_icons/edit.png",
                                height: tablet ? hp(3.12) : wp(5.5),
                              )
                            ],
                          ),
                          SizedBox(
                            width: tablet ? wp(1.3) : wp(4),
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: hp(1.1)),
                                Text(
                                  "Customer Name",
                                  style: TextStyle(
                                      fontSize: tablet ? hp(2) : wp(3.4),
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.DarkWhite),
                                ),
                                SizedBox(
                                  height: tablet ? hp(0.5) : hp(0.3),
                                ),
                                Text("Ashton Clark",
                                    style: TextStyle(
                                        fontSize: tablet ? hp(2.7) : wp(4.5),
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.DarkWhite))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: hp(2)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(3, (index) {
                            return Text(
                              "1125125478 ".substring((index * 4),
                                  (index * 4) + (index == 2 ? 3 : 4)),
                              style: TextStyle(
                                  fontSize: tablet ? wp(3) : wp(7),
                                  letterSpacing: tablet ? 3 : 4,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.DarkWhite),
                            );
                          }).toList()),
                    ),
                    Container(
                      padding: isIOS
                          ? null
                          : tablet ? EdgeInsets.only(bottom: hp(1)) : 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Credit Available",
                                  style: TextStyle(
                                      fontSize: tablet
                                          ? hp(isIOS ? 1.9 : 2.2)
                                          : wp(3.2),
                                      color: AppColors.LightBlue,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: hp(0.6),
                                ),
                                Text(
                                  "₹ 2720.00",
                                  style: TextStyle(
                                      fontSize: tablet
                                          ? hp(isIOS ? 2.3 : 3.1)
                                          : wp(4),
                                      color: AppColors.LightBlue,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.1),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                right: tablet ? wp(0.8) : wp(2)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Loyalty Points",
                                  style: TextStyle(
                                      fontSize: tablet
                                          ? hp(isIOS ? 1.9 : 2.2)
                                          : wp(3.2),
                                      color: AppColors.LightYellow,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: hp(0.6),
                                ),
                                Text(
                                  "5720",
                                  style: TextStyle(
                                      fontSize: tablet
                                          ? hp(isIOS ? 2.3 : 3.1)
                                          : wp(4),
                                      color: AppColors.LightYellow,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.8),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
              Container(
                padding: EdgeInsets.fromLTRB(
                    tablet ? wp(isIOS ? 2.5 : 2) : wp(3),
                    tablet ? hp(4) : hp(3.3),
                    tablet ? wp(isIOS ? 0.5 : 0) : wp(3),
                    tablet ? hp(isIOS ? 3 : 4.05) : hp(2)),
                margin: EdgeInsets.only(right: tablet ? wp(3.7) : wp(4)),
                //alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Cust. Since",
                            style: TextStyle(
                                fontSize:
                                    tablet ? hp(isIOS ? 1.9 : 2.2) : wp(3.2),
                                color: AppColors.LightOrange,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: hp(0.6),
                          ),
                          Text(
                            "02/30",
                            style: TextStyle(
                                fontSize:
                                    tablet ? hp(isIOS ? 2.7 : 3.1) : wp(4.3),
                                color: AppColors.LightOrange,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.8),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Expiry date",
                            style: TextStyle(
                                fontSize:
                                    tablet ? hp(isIOS ? 1.7 : 2.2) : wp(3.2),
                                color: AppColors.LightRed,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: hp(0.6),
                          ),
                          Text(
                            "02/30",
                            style: TextStyle(
                                fontSize:
                                    tablet ? hp(isIOS ? 2.7 : 3.1) : wp(4.3),
                                color: AppColors.LightRed,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.8),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Points Value",
                            style: TextStyle(
                                fontSize:
                                    tablet ? hp(isIOS ? 1.9 : 2.2) : wp(3.2),
                                color: AppColors.LightGreen,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: hp(0.6),
                          ),
                          Text(
                            "₹ 57.20",
                            style: TextStyle(
                                fontSize:
                                    tablet ? hp(isIOS ? 2.7 : 3.1) : wp(4.3),
                                color: AppColors.LightGreen,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.8),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget _buildCardInfo() {
      return Container(
        padding: EdgeInsets.fromLTRB(
            tablet ? wp(1.3) : wp(2.9),
            tablet ? hp(1) : hp(0.8),
            tablet ? wp(1.22) : wp(2.9),
            tablet ? hp(2.74) : hp(2.3)),
        margin: EdgeInsets.only(top: hp(1)),
        width: tablet ? wp(43) : wp(100),
        height: wp((tablet ? 43 : 100) * 880 / 1412),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/customers/card.png"),
                fit: BoxFit.fitWidth)),
        child: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                padding: EdgeInsets.only(
                    left: tablet ? wp(2.5) : wp(5),
                    bottom: tablet ? hp(3) : hp(2.2)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: tablet ? hp(3) : hp(2.2)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Stack(
                            alignment: Alignment.bottomLeft,
                            children: <Widget>[
                              Container(
                                height: tablet ? hp(8.5) : wp(15),
                                width: tablet ? hp(8.5) : wp(15),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/customers/personal.png")),
                                    color: AppColors.DarkGray,
                                    shape: BoxShape.circle),
                              ),
                              Image.asset(
                                "assets/general_icons/edit.png",
                                height: tablet ? hp(3.12) : wp(5.5),
                              )
                            ],
                          ),
                          SizedBox(
                            width: tablet ? wp(1.3) : wp(4),
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: hp(1.1)),
                                Text(
                                  "Customer Name",
                                  style: TextStyle(
                                      fontSize: tablet ? hp(1.9) : wp(3.4),
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.DarkWhite),
                                ),
                                SizedBox(
                                  height: tablet ? hp(0.5) : hp(0.3),
                                ),
                                Text("Ashton Clark",
                                    style: TextStyle(
                                        fontSize: tablet ? hp(2.5) : wp(4.5),
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.DarkWhite))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: hp(2)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(3, (index) {
                            return Text(
                              "1125125478 ".substring((index * 4),
                                  (index * 4) + (index == 2 ? 3 : 4)),
                              style: TextStyle(
                                  fontSize: tablet ? wp(3) : wp(7),
                                  letterSpacing: tablet ? 3 : 4,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.DarkWhite),
                            );
                          }).toList()),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Credit Available",
                                  style: TextStyle(
                                      fontSize: tablet ? hp(1.6) : hp(1.6),
                                      color: AppColors.LightBlue,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: hp(0.6),
                                ),
                                Text(
                                  "₹ 2720.00",
                                  style: TextStyle(
                                      fontSize: tablet ? hp(2) : hp(2.3),
                                      color: AppColors.LightBlue,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.8),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                right: tablet ? wp(1.5) : wp(2)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Loyalty Points",
                                  style: TextStyle(
                                      fontSize: tablet ? hp(1.6) : hp(1.6),
                                      color: AppColors.LightYellow,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: hp(0.6),
                                ),
                                Text(
                                  "5720",
                                  style: TextStyle(
                                      fontSize: tablet ? hp(2) : hp(2.3),
                                      color: AppColors.LightYellow,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.8),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
              Container(
                padding: EdgeInsets.fromLTRB(
                    tablet ? wp(2.5) : wp(3),
                    tablet ? hp(4) : hp(3.3),
                    tablet ? wp(0.5) : wp(3),
                    tablet ? hp(3) : hp(2.3)),
                margin: EdgeInsets.only(right: tablet ? wp(3.7) : wp(4)),
                //alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Cust. Since",
                            style: TextStyle(
                                fontSize: tablet ? hp(1.6) : hp(1.6),
                                color: AppColors.LightOrange,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: hp(0.6),
                          ),
                          Text(
                            "02/30",
                            style: TextStyle(
                                fontSize: tablet ? hp(2.4) : hp(2.3),
                                color: AppColors.LightOrange,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.8),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Expiry date",
                            style: TextStyle(
                                fontSize: tablet ? hp(1.6) : hp(1.6),
                                color: AppColors.LightRed,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: hp(0.6),
                          ),
                          Text(
                            "02/30",
                            style: TextStyle(
                                fontSize: tablet ? hp(2.4) : hp(2.3),
                                color: AppColors.LightRed,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.8),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Points Value",
                            style: TextStyle(
                                fontSize: tablet ? hp(1.6) : hp(1.6),
                                color: AppColors.LightGreen,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: hp(0.6),
                          ),
                          Text(
                            "₹ 57.20",
                            style: TextStyle(
                                fontSize: tablet ? hp(2) : hp(2.3),
                                color: AppColors.LightGreen,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.8),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget _cardContainer() {
      double fontSize = tablet ? hp(2.4) : hp(2.10);
      double separator = tablet ? hp(1) : hp(1);
      double paddingBottomInput = tablet ? hp(1.2) : hp(1);
      GlobalKey<TextfieldClassicState> _BController = GlobalKey();
      GlobalKey<TextfieldClassicState> _AController = GlobalKey();

      return Container(
        padding: tablet
            ? EdgeInsets.fromLTRB(hp(3), hp(0), hp(3), hp(3))
            : EdgeInsets.all(hp(1.5)),
        //height: hp(65),
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: tablet
              ? EdgeInsets.symmetric(horizontal: hp(3.2), vertical: hp(2.5))
              : EdgeInsets.all(tablet ? hp(3.2) : hp(1.5)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(hp(1.2)),
            color: AppColors.PrimaryWhite,
            boxShadow: [
              new BoxShadow(
                  color: AppColors.DarkGray.withOpacity(tablet ? 0.6 : 0.5),
                  offset: new Offset(0.3, 2.0),
                  blurRadius: 2.0),
              new BoxShadow(
                  color: AppColors.DarkGray.withOpacity(tablet ? 0.6 : 0.5),
                  offset: new Offset(-0.6, 0),
                  blurRadius: 1.0)
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  CircleButton(
                    imagePath: "assets/customers/firstname.png",
                    size: hp(5),
                    extraShadow: true,
                  ),
                  SizedBox(
                    width: wp(2),
                  ),
                  Expanded(
                      child: TextfieldClassic(
                    paddingBottomInput: paddingBottomInput,
                    fontSize: fontSize,
                    labelText: "First Name",
                  )),
                  Expanded(
                      child: TextfieldClassic(
                    leftBorder: true,
                    paddingBottomInput: paddingBottomInput,
                    fontSize: fontSize,
                    labelText: "Last Name",
                  )),
                ],
              ),
              SizedBox(
                height: separator,
              ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    CircleButton(
                      imagePath: "assets/customers/mail.png",
                      size: hp(5),
                      extraShadow: true,
                    ),
                    SizedBox(
                      width: wp(2),
                    ),
                    Expanded(
                        child: TextfieldClassic(
                      toUpperCase: TextCapitalization.none,
                      keyType: TextInputType.emailAddress,
                      paddingBottomInput: paddingBottomInput,
                      fontSize: fontSize,
                      labelText: eptxt('email'),
                    ))
                  ]),
              SizedBox(
                height: separator,
              ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    CircleButton(
                      imagePath: "assets/customers/mobile.png",
                      size: hp(5),
                      extraShadow: true,
                    ),
                    SizedBox(
                      width: wp(2),
                    ),
                    Expanded(
                        child: TextfieldNumber(
                      paddingBottomInput: paddingBottomInput,
                      fontSize: fontSize,
                      labelText: eptxt('mobile_number'),
                    ))
                  ]),
              SizedBox(
                height: separator,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      final DateTime picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1955),
                          lastDate: DateTime(2020),
                          footerBuilder: datePickerFooter,
                          width: tablet ? wp(45) : wp(80),
                          headerBuilder: datePickerHeader,
                          builder: (ct, child) {
                            return child;
                          });
                      if (picked != null) {
                        _AController.currentState
                            .changeText(DateFormat.yMd().format(picked));
                      }
                    },
                    child: CircleButton(
                      imagePath: "assets/customers/calendar.png",
                      size: hp(5),
                      extraShadow: true,
                    ),
                  ),
                  SizedBox(
                    width: wp(2),
                  ),
                  Expanded(
                    child: TextfieldClassic(
                      disabled: true,
                      key: _AController,
                      optional: false,
                      calendar: true,
                      firstDate: 1955,
                      lastDate: 2020,
                      customIconBuilder: (hasFocus, empty) {
                        return GestureDetector(
                          onTap: () async {
                            final DateTime picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1955),
                                lastDate: DateTime(2020),
                                footerBuilder: datePickerFooter,
                                width: tablet ? wp(45) : wp(80),
                                headerBuilder: datePickerHeader,
                                builder: (ct, child) {
                                  return child;
                                });
                            if (picked != null) {
                              _AController.currentState
                                  .changeText(DateFormat.yMd().format(picked));
                            }
                          },
                          child: Container(),
                        );
                      },
                      noClear: true,
                      fontSize: tablet ? hp(2.7) : hp(2.1),
                      paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
                      labelText: "Birthday",
                      alwaysFocus: false,
                      alwaysBlue: true,
                    ),
                  ),
                  SizedBox(
                    width: wp(2),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final DateTime picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1955),
                          lastDate: DateTime(2020),
                          footerBuilder: datePickerFooter,
                          width: tablet ? wp(45) : wp(80),
                          headerBuilder: datePickerHeader,
                          builder: (ct, child) {
                            return child;
                          });
                      if (picked != null) {
                        _BController.currentState
                            .changeText(DateFormat.yMd().format(picked));
                      }
                    },
                    child: CircleButton(
                      imagePath: "assets/customers/calendar.png",
                      size: hp(5),
                      extraShadow: true,
                    ),
                  ),
                  SizedBox(
                    width: wp(2),
                  ),
                  Expanded(
                    child: TextfieldClassic(
                      disabled: true,
                      key: _BController,
                      optional: false,
                      calendar: true,
                      firstDate: 1955,
                      lastDate: 2020,
                      customIconBuilder: (hasFocus, empty) {
                        return GestureDetector(
                          onTap: () async {
                            final DateTime picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1955),
                                lastDate: DateTime(2020),
                                footerBuilder: datePickerFooter,
                                width: tablet ? wp(45) : wp(80),
                                headerBuilder: datePickerHeader,
                                builder: (ct, child) {
                                  return child;
                                });
                            if (picked != null) {
                              _BController.currentState
                                  .changeText(DateFormat.yMd().format(picked));
                            }
                          },
                          child: Container(),
                        );
                      },
                      noClear: true,
                      fontSize: tablet ? hp(2.7) : hp(2.1),
                      paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
                      labelText: "Anniversary",
                      alwaysFocus: false,
                      alwaysBlue: true,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: separator,
              ),
              /*Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    CircleButton(
                      imagePath: "assets/customers/address.png",
                      size: hp(5),
                      extraShadow: true,
                    ),
                    SizedBox(
                      width: wp(2),
                    ),
                    Expanded(
                        child: TextfieldClassic(
                      paddingBottomInput: paddingBottomInput,
                      fontSize: fontSize,
                      customIcon: tablet
                          ? InkWell(
                              onTap: () {},
                              child: Text(
                                'Detect Location',
                                style: TextStyle(
                                  color: AppColors.PrimaryBlue,
                                  fontSize: tablet ? hp(2.5) : wp(3),
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            )
                          : SizedBox(),
                      labelText: "Address 1",
                    ))
                  ]),
              SizedBox(
                height: separator,
              ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: hp(5),
                      width: hp(5),
                      decoration: BoxDecoration(shape: BoxShape.circle),
                    ),
                    SizedBox(
                      width: wp(2),
                    ),
                    Expanded(
                        child: TextfieldClassic(
                      paddingBottomInput: paddingBottomInput,
                      fontSize: fontSize,
                      labelText: "Address 2",
                    ))
                  ]),
              SizedBox(
                height: separator,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: hp(5),
                    width: hp(5),
                    decoration: BoxDecoration(shape: BoxShape.circle),
                  ),
                  SizedBox(
                    width: wp(2),
                  ),
                  Expanded(
                      child: TextfieldClassic(
                    paddingBottomInput: paddingBottomInput,
                    fontSize: fontSize,
                    labelText: "City",
                  )),
                  Expanded(
                      child: TextfieldClassic(
                    leftBorder: true,
                    paddingBottomInput: paddingBottomInput,
                    fontSize: fontSize,
                    labelText: "State",
                  )),
                ],
              ),*/

              SizedBox(
                height: hp(1),
              ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    if (tablet) ...[
                      Container(
                        height: hp(5),
                        width: hp(5),
                        decoration: BoxDecoration(shape: BoxShape.circle),
                      ),
                      SizedBox(
                        width: wp(2),
                      ),
                    ],
                    Expanded(
                      child: ToggleCard(
                          background: false,
                          description: "Enable Credit Permissions",
                          fontSize: tablet ? hp(2.4) : wp(3.2),
                          paddingVertical: tablet ? hp(2.3) : hp(1.6),
                          paddingHorizontal: tablet ? wp(2) : wp(5),
                          letterSpacing: 1,
                          toggleSize: tablet ? hp(1.8) : wp(2.4),
                          onChanged: (bool value) {
                            setState(() {
                              creditPermission = value;
                            });
                          }),
                    )
                  ]),
              SizedBox(
                height: hp(1.2),
              ),
              if (creditPermission)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    if (tablet)
                      Container(
                        height: hp(5),
                        width: hp(5) + wp(2),
                        decoration: BoxDecoration(shape: BoxShape.circle),
                      ),
                    Container(
                      width: tablet ? wp(30) : wp(60),
                      margin: EdgeInsets.only(bottom: hp(2)),
                      child: Text(
                        "Amount of Credit made available",
                        style: TextStyle(
                            color: AppColors.DarkGray.withOpacity(0.8),
                            fontWeight: FontWeight.w700,
                            fontSize: tablet ? hp(2.3) : wp(3.4)),
                      ),
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        width: tablet ? wp(3) : wp(6),
                        margin: EdgeInsets.only(left: wp(1), bottom: hp(2)),
                        child: Text(
                          "=",
                          style: TextStyle(
                              color: AppColors.PrimaryBlue,
                              fontWeight: FontWeight.w700,
                              fontSize: hp(2.2)),
                        )),
                    Expanded(
                      flex: tablet ? 5 : 1,
                      child: Container(
                        child: TextfieldClassic(
                          noClear: true,
                          labelText: "Amount (₹)",
                          alwaysFocus: true,
                          fontSize: tablet ? hp(3) : wp(4.1),
                          paddingBottomInput: hp(0.5),
                        ),
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        (isIOS && tablet ? _buildCardInfo() : _buildCardInfoAndroid()),
        _cardContainer()
      ],
    ));
  }
}
