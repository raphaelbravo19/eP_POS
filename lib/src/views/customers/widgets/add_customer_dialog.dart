import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/create_account/widgets/otp_dialog.dart';
import 'package:epaisa_pos/src/views/transactions/transactions_screen.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/textfields/texfield_number.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddCustomerDialog extends StatefulWidget {
  AddCustomerDialog({
    Key key,
  }) : super(key: key);

  @override
  AddCustomerDialogState createState() => AddCustomerDialogState();
}

class AddCustomerDialogState extends State<AddCustomerDialog> {
  bool showModal = true;
  bool resendDisabled = true;
  GlobalKey<TextfieldClassicState> bkey = GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> akey = GlobalKey<TextfieldClassicState>();
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

    Widget content() {
      return Container(
        width: (tablet ? wp(42) : wp(85)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, hp(0.5), 0, hp(1)),
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: tablet ? hp(1.5) : hp(1.3)),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: AppColors.LightGray, width: 2.5))),
                      alignment: Alignment.center,
                      width: (tablet ? wp(42) : wp(85)),
                      child: Text(
                        eptxt('customer_information'),
                        style: TextStyle(
                            fontSize: tablet ? hp(2.4) : hp(2.2),
                            fontWeight: FontWeight.w700,
                            color: AppColors.DarkGray),
                      ),
                    ),
                    Positioned(
                      right: hp(1.5),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            showModal = false;
                          });
                          Navigator.of(context).pop();
                        },
                        child: Image.asset(
                          "assets/general_icons/xbutton.png",
                          height: tablet ? hp(2.2) : hp(2.2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: tablet ? wp(4) : wp(8)),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: tablet ? hp(1) : hp(0.5),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: TextfieldClassic(
                          paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
                          fontSize: tablet ? hp(2.7) : hp(2.1),
                          labelText: "First Name",
                        )),
                        Expanded(
                            child: TextfieldClassic(
                          leftBorder: true,
                          paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
                          fontSize: tablet ? hp(2.7) : hp(2.1),
                          labelText: "Last Name",
                        )),
                      ],
                    ),
                    SizedBox(
                      height: hp(1),
                    ),
                    TextfieldClassic(
                      fontSize: tablet ? hp(2.7) : hp(2.1),
                      paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
                      labelText: eptxt('email'),
                    ),
                    SizedBox(
                      height: hp(1),
                    ),
                    TextfieldNumber(
                      fontSize: tablet ? hp(2.7) : hp(2.1),
                      paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
                      labelText: eptxt('mobile_number'),
                    ),
                    SizedBox(
                      height: hp(1),
                    ),
                    TextfieldClassic(
                      disabled: true,
                      key: bkey,
                      optional: true,
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
                              bkey.currentState
                                  .changeText(DateFormat.yMd().format(picked));
                            }
                          },
                          child: Container(
                              child: Image.asset(
                            'assets/general_icons/calendar.png',
                            height: (tablet ? hp(2.7) : hp(2.1)) * 1.4,
                            colorBlendMode: BlendMode.srcIn,
                            color: !empty
                                ? AppColors.PrimaryBlue
                                : AppColors.BackPrimaryGray,
                          )),
                        );
                      },
                      noClear: true,
                      fontSize: tablet ? hp(2.7) : hp(2.1),
                      paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
                      labelText: "Date of Birth",
                      alwaysFocus: false,
                      //alwaysBlue: true,
                    ),
                    SizedBox(
                      height: hp(1),
                    ),
                    TextfieldClassic(
                      disabled: true,
                      key: akey,
                      optional: true,
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
                              akey.currentState
                                  .changeText(DateFormat.yMd().format(picked));
                            }
                          },
                          child: Container(
                              child: Image.asset(
                            'assets/general_icons/calendar.png',
                            height: (tablet ? hp(2.7) : hp(2.1)) * 1.4,
                            colorBlendMode: BlendMode.srcIn,
                            color: !empty
                                ? AppColors.PrimaryBlue
                                : AppColors.BackPrimaryGray,
                          )),
                        );
                      },
                      noClear: true,
                      fontSize: tablet ? hp(2.7) : hp(2.1),
                      paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
                      labelText: "Annyversary",
                      alwaysFocus: false,
                      //alwaysBlue: true,
                    ),
                    SizedBox(
                      height: hp(4),
                    ),
                    ButtonGradient(
                      callback: () {
                        _showDialog();
                      },
                      title: "ADD",
                      fontSize: tablet ? hp(2.3) : hp(1.8),
                      paddingVertical: tablet ? hp(2.3) : hp(1.8),
                      borderRadius: hp(2.3),
                    ),
                    SizedBox(
                      height: tablet ? hp(4) : hp(2.7),
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
                        width: (tablet ? wp(42) : wp(85)),
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

  void _showDialog() {
    // flutter defined function
    Navigator.of(context).push(new PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return OTPCreateDialog();
      },
    ));
  }
}
