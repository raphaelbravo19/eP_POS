import 'dart:ui';

import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/remove_over_scroll_glow.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/login/login_screen.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_border.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:flutter/material.dart';

class AccountCreatedDialog extends StatefulWidget {
  @override
  _AccountCreatedDialogState createState() => _AccountCreatedDialogState();
}

class _AccountCreatedDialogState extends State<AccountCreatedDialog> {
  bool showModal = true;

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
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                      child: Container(
                        width: wp(100),
                        height: hp(100),
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                        width: (tablet ? wp(42) : wp(90)),
                        height: tablet ? hp(96) : hp(82),
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                  width: (tablet ? wp(42) : wp(90)),
                                  height: tablet ? hp(74) : hp(64),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: tablet ? wp(2) : wp(4)),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(hp(1.5)),
                                    color: AppColors.PrimaryWhite,
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: tablet ? hp(32) : hp(27),
                                      ),
                                      Container(
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Hooray! Your Account",
                                              style: TextStyle(
                                                  fontSize: tablet
                                                      ? hp(3.6)
                                                      : hp(2.8),
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.DarkGray),
                                            ),
                                            Text(
                                              "has been created",
                                              style: TextStyle(
                                                  fontSize: tablet
                                                      ? hp(3.6)
                                                      : hp(2.8),
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.DarkGray),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: hp(2),
                                      ),
                                      Container(
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Just one more step! To complete the",
                                              style: TextStyle(
                                                  fontSize: tablet
                                                      ? hp(2.4)
                                                      : hp(1.9),
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.TextLightGray
                                                      .withOpacity(0.6)),
                                            ),
                                            SizedBox(
                                              height: hp(0.6),
                                            ),
                                            Text(
                                              "registration you need to validate your",
                                              style: TextStyle(
                                                  fontSize: tablet
                                                      ? hp(2.4)
                                                      : hp(1.9),
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.TextLightGray
                                                      .withOpacity(0.6)),
                                            ),
                                            SizedBox(
                                              height: hp(0.6),
                                            ),
                                            Text(
                                              "email address.",
                                              style: TextStyle(
                                                  fontSize: tablet
                                                      ? hp(2.4)
                                                      : hp(1.9),
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.TextLightGray
                                                      .withOpacity(0.6)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: tablet ? wp(2) : wp(4)),
                                        child: ButtonGradient(
                                          paddingVertical:
                                              tablet ? hp(3) : hp(2.5),
                                          borderRadius: hp(4),
                                          fontSize: tablet ? hp(2.2) : hp(1.6),
                                          letterSpacing: tablet ? 1.5 : 1.2,
                                          fontWeight: FontWeight.w600,
                                          title: "LOGIN TO YOUR ACCOUNT",
                                          callback: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginScreen()));
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: hp(4),
                                      ),
                                    ],
                                  )),
                            ),
                            Image.asset(
                              "assets/createaccount/rocket.png",
                              height: tablet ? hp(57) : hp(46),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: hp(2),
                      )
                    ],
                  )
                ],
              ),
      ),
    );
  }
}
