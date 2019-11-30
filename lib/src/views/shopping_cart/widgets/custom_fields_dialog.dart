import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/remove_over_scroll_glow.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/payments/checkout/checkout.dart';
import 'package:epaisa_pos/src/views/payments/payments_screen.dart';
import 'package:epaisa_pos/src/views/reset_password/widgets/otp_fields.dart';
import 'package:epaisa_pos/src/views/reset_password/widgets/timer.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_border.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/dialogs/screen_as_modal.dart';
import 'package:epaisa_pos/src/widgets/textfields/texfield_number.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_password.dart';
import 'package:epaisa_pos/src/widgets/texts/text_gray.dart';
import 'package:flutter/material.dart';

class CustomFieldsDialog extends StatefulWidget {
  CustomFieldsDialog({
    Key key,
  }) : super(key: key);

  @override
  CustomFieldsDialogState createState() => CustomFieldsDialogState();
}

class CustomFieldsDialogState extends State<CustomFieldsDialog> {
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

  void _showDialog(
      {BuildContext context,
      Widget paymentScreen,
      double width,
      double height}) {
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    Navigator.of(context).pushReplacement(
      new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return ScreenAsModal(
            body: paymentScreen,
            width: width,
            height: height,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    Widget _titleNumber() {
      return Column(
        children: <Widget>[
          Text(
            "We have sent an OTP to",
            style: TextStyle(
                color: AppColors.DarkGray,
                fontSize: tablet ? hp(2.8) : hp(2.2),
                fontWeight: FontWeight.w600),
          ),
          Text(
            "+91 98675 43210",
            style: TextStyle(
                color: AppColors.PrimaryBlue,
                fontSize: tablet ? hp(3) : hp(2.4),
                fontWeight: FontWeight.w700),
          )
        ],
      );
    }

    List<Widget> _timeResend() {
      return [
        OtpFields(),
        SizedBox(
          height: hp(3),
        ),
        TimerButton(
          seconds: 10,
          onStart: () {},
          onFinish: () {
            setState(() {
              resendDisabled = false;
            });
          },
        ),
        SizedBox(
          height: hp(3),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: tablet ? wp(4.5) : wp(10)),
          child: ButtonGradient(
            disabled: resendDisabled,
            borderRadius: hp(3),
            fontSize: tablet ? hp(2.2) : hp(1.8),
            paddingVertical: tablet ? hp(2) : hp(1.8),
            title: "RESEND OTP",
          ),
        )
      ];
    }

    List<Widget> _formReset() {
      return [
        SizedBox(
          height: tablet ? hp(3) : hp(2),
        ),
        Text(
          "Insert New Password",
          style: TextStyle(
              color: AppColors.DarkGray,
              fontSize: tablet ? hp(2.5) : hp(2.2),
              fontWeight: FontWeight.w700,
              letterSpacing: 0.1),
        ),
        SizedBox(
          height: tablet ? hp(0.5) : hp(1),
        ),
        TextfieldPassword(
          fontSize: tablet ? hp(2.4) : hp(2.01),
          paddingBottomInput: hp(1),
          labelText: "Password",
        ),
        SizedBox(
          height: tablet ? hp(0.2) : hp(0.5),
        ),
        TextfieldPassword(
          fontSize: tablet ? hp(2.4) : hp(2.01),
          paddingBottomInput: hp(1),
          labelText: "Re-type Password",
        ),
        SizedBox(
          height: hp(3),
        ),
        ButtonGradient(
          disabled: true,
          borderRadius: hp(3),
          fontSize: tablet ? hp(2.2) : hp(1.8),
          paddingVertical: tablet ? hp(2) : hp(1.8),
          title: "RESET PASSWORD",
        ),
        SizedBox(
          height: hp(3),
        ),
      ];
    }

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
                  alignment: Alignment.topRight,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: tablet ? hp(2) : hp(1.3)),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: AppColors.LightGray, width: 2.5))),
                      alignment: Alignment.center,
                      width: (tablet ? wp(42) : wp(85)),
                      child: Text(
                        "Custom Fields",
                        style: TextStyle(
                            fontSize: tablet ? hp(3.1) : hp(2.2),
                            fontWeight: FontWeight.w700,
                            color: AppColors.DarkGray),
                      ),
                    ),
                    Positioned(
                        top: tablet ? hp(2.3) : hp(1.3),
                        right: hp(1.9),
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                showModal = false;
                              });
                              Navigator.of(context).pop();
                            },
                            child: Image.asset(
                              "assets/general_icons/xbutton.png",
                              height: tablet ? hp(2.8) : hp(2.2),
                            ))),
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
                    TextfieldClassic(
                      paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
                      fontSize: tablet ? hp(2.7) : hp(2.1),
                      labelText: "Part Number",
                    ),
                    SizedBox(
                      height: tablet ? hp(1) : hp(1),
                    ),
                    TextfieldClassic(
                      paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
                      fontSize: tablet ? hp(2.7) : hp(2.1),
                      labelText: "Invoice Number",
                    ),
                    SizedBox(
                      height: tablet ? hp(2) : hp(2),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: tablet ? wp(2) : wp(7)),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: ButtonBorder(
                      title: "SKIP",
                      fontSize: tablet ? hp(2.3) : hp(1.8),
                      paddingVertical: tablet ? hp(2.3) : hp(1.8),
                      borderRadius: tablet ? wp(1.8) : hp(2.3),
                      borderWidth: 2.5,
                    )),
                    SizedBox(
                      width: tablet ? wp(1.5) : wp(4),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          final checkoutScreen = PaymentsScreen(
                            isModal: tablet,
                            title: multilang.get('checkout'),
                            customAppBar: PaymentScreenAppBar(
                              hp: hp,
                              title: multilang.get('checkout').toUpperCase(),
                            ),
                            paymentBuilder: (double sHeight) => Checkout(
                              sHeight: 500,
                              onButtonPress: () {},
                            ),
                          );
                          if (tablet) {
                            return _showDialog(
                              context: context,
                              paymentScreen: checkoutScreen,
                              width: hp(70),
                              height: hp(90),
                            );
                          }
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) {
                                return checkoutScreen;
                              },
                            ),
                          );
                        },
                        child: ButtonGradient(
                          title: "CONFIRM",
                          fontSize: tablet ? hp(2.3) : hp(1.8),
                          paddingVertical: tablet ? hp(2.3) : hp(1.8),
                          borderRadius: tablet ? wp(1.8) : hp(2.3),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: tablet ? hp(2.5) : hp(2.7),
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
                                      tablet ? wp(1.5) : wp(3)),
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
