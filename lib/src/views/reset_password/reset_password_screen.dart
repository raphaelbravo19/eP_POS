import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/login/widgets/background_image.dart';
import 'package:epaisa_pos/src/views/login/widgets/learn_more.dart';
import 'package:epaisa_pos/src/views/login/widgets/logo.dart';
import 'package:epaisa_pos/src/views/reset_password/widgets/reset_otp_dialog.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/textfields/texfield_number.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  Widget _buildCardbackground(
      double width, BuildContext context, double height) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));

    return Column(
      children: <Widget>[
        Logo(tablet ? hp(7) : hp(5.5)),
        SizedBox(
          height: hp(0.3),
        ),
        LearnMore(
          wp(100),
          tablet,
          fontSize: hp(1.88),
        ),
        SizedBox(
          height: hp(4),
        ),
        Container(
          child: Card(
            margin: new EdgeInsets.symmetric(
                horizontal: tablet ? width * 0.29 : width * 0.09),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 4.0,
            child: Container(
              padding: EdgeInsets.only(top: hp(5)),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      "Enter your mobile number or e-mail\naddress to reset your password. ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF5D6770),
                        fontSize: tablet ? hp(2.5) : wp(3.6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          tablet ? wp(3.5) : wp(8),
                          hp(1.2),
                          tablet ? wp(3.5) : wp(8),
                          tablet ? hp(5) : hp(4)),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: tablet ? hp(3) : hp(1),
                          ),
                          TextfieldClassic(
                            keyType: TextInputType.emailAddress,
                            fontSize: tablet ? hp(2.7) : hp(2.01),
                            paddingBottomInput: tablet ? hp(1.5) : hp(1),
                            labelText: eptxt('email'),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: hp(2)),
                            child: Text(
                              "OR",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF5D6770),
                                fontSize: tablet ? hp(4) : hp(3),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextfieldNumber(
                            fontSize: tablet ? hp(2.7) : hp(2.01),
                            paddingBottomInput: tablet ? hp(1.5) : hp(1),
                            labelText: eptxt('mobile_number'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        //BoldBlueText('Forgot your Password?'),
        SizedBox(
          height: hp(5),
        ),
        Container(
          margin: new EdgeInsets.symmetric(
              horizontal: tablet ? width * 0.29 : width * 0.09),
          child: ButtonGradient(
            paddingVertical: tablet ? hp(2.1) : hp(2.2),
            borderRadius: hp(3.5),
            fontSize: hp(1.8),
            title: "RESET PASSWORD",
            callback: () {
              _showDialog();
            },
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
              decoration: BackgroundImage.buildBackgroundImage(),
              height: hp(100),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: hp(5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Align(
                        alignment: FractionalOffset.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 20.0, left: 10),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: hp(tablet ? 5 : 4.65),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildCardbackground(width, context, height),
                    ],
                  ),
                ],
              )),
        ],
      ),
    ));
  }

  void _showDialog() {
    // flutter defined function
    Navigator.of(context).push(new PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return ResetOtpDialog();
      },
    ));
  }
}
