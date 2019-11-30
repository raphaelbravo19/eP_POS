import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:biometric_plugin/biometric_plugin.dart';
import 'package:epaisa_pos/data/initial/countries/api_service.dart';
import 'package:epaisa_pos/data/models/fingerprintuser_dao.dart';
import 'package:epaisa_pos/src/bloc/login_bloc.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/create_account/create_account_screen.dart';
import 'package:epaisa_pos/src/views/login/widgets/background_image.dart';
import 'package:epaisa_pos/src/views/login/widgets/learn_more.dart';
import 'package:epaisa_pos/src/views/login/widgets/logo.dart';
import 'package:epaisa_pos/src/views/reset_password/reset_password_screen.dart';
import 'package:epaisa_pos/src/widgets/textStyles/medium_bold_blue.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_password.dart';
import 'package:epaisa_pos/src/widgets/utils/dialogs_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instabug_flutter/Instabug.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FocusNode focusNodePass = FocusNode();

  bool hasFocus = false;
  int fingerprintstate = 0;
  BuildContext context;
  GlobalKey<TextfieldPasswordState> keyPass =
      GlobalKey<TextfieldPasswordState>();
  GlobalKey<TextfieldClassicState> keyUser = GlobalKey<TextfieldClassicState>();
  var object = [];

  FingerprintUserDao dao = FingerprintUserDao(db);
  LoginBloc bloc = new LoginBloc();

  Future LoadFingerprint() async {
    var fingers = await dao.getAll();
    return fingers.length;
  }

  @override
  void initState() {
    print("INIT");
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("MAS");
    this.context = context;
    tablet = isTablet(MediaQuery.of(context));
    var isIOS = Platform.isIOS;

    if (isIOS) {
      Instabug.start('0bf2e06c3290a2a5ce73be9c1b69bb11',
          <InvocationEvent>[InvocationEvent.floatingButton]);
    }

//    final bloc = Provider.of<LoginBloc>(context);
    if (tablet) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
    wp = ScreenUtils(MediaQuery.of(context).size).wp;
    hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var layoutwidth = tablet ? height * 0.65 : width * 0.85;
    var layoutHeight = tablet ? height : height * 0.8;

    Widget _buildContent() {
      return Scaffold(
          body: SingleChildScrollView(
        child: Container(
            decoration: BackgroundImage.buildBackgroundImage(tablet: tablet),
            height: hp(100),
            child: Column(children: <Widget>[
              Container(
                height: hp(100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        flex: 9,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            GestureDetector(
                                onTap: () {
                                  bloc.changePassword("Test@123");
                                  bloc.changeUsername(
                                      "raphael.bravo@eigital.com");
                                  keyPass.currentState.changeText("Test@123");
                                  keyUser.currentState
                                      .changeText("raphael.bravo@eigital.com");
                                },
                                child: Logo(tablet ? hp(7) : hp(5.5))),
                            SizedBox(
                              height: tablet ? hp(1.2) : hp(0.3),
                            ),
                            LearnMore(
                              wp(100),
                              tablet,
                              fontSize: tablet ? hp(2.3) : hp(1.88),
                            ),
                            SizedBox(
                              height: tablet ? hp(3) : hp(5),
                            ),
                          ],
                        )),
                    Container(
                      child: Card(
                        margin: new EdgeInsets.symmetric(
                            horizontal: tablet ? width * 0.29 : width * 0.09),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        elevation: 10.0,
                        child: Container(
                            padding: EdgeInsets.fromLTRB(
                                layoutwidth * 0.09,
                                tablet
                                    ? layoutHeight * 0.06
                                    : layoutHeight * 0.04,
                                layoutwidth * 0.09,
                                tablet
                                    ? layoutHeight * 0.06
                                    : layoutHeight * 0.045),
                            child: Center(
                                child: Column(
                              children: <Widget>[
                                TextfieldClassic(
                                  key: keyUser,
                                  stream: bloc.username,
                                  onChanged: bloc.changeUsername,
                                  fontSize: tablet ? hp(2.8) : hp(2.01),
                                  paddingBottomInput: hp(1),
                                  labelText: eptxt('email'),
                                  onSubmitted: (str, valid) {
                                    print("sdsd");
                                    keyPass.currentState.changeFocus();
                                  },
                                ),
                                SizedBox(
                                  height: hp(1.3),
                                ),
                                TextfieldPassword(
                                    key: keyPass,
                                    stream: bloc.password,
                                    onChanged: bloc.changePassword,
                                    fontSize: tablet ? hp(2.8) : hp(2.01),
                                    paddingBottomInput: hp(1),
                                    labelText: eptxt('password'),
                                    onSubmit: () {
                                      bloc.loginWithCredentials(
                                          context, true, null);
                                    }),
                                SizedBox(
                                  height: hp(0.5),
                                ),
                              ],
                            ))),
                      ),
                    ),
                    Expanded(
                        flex: tablet ? 12 : 9,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Column(
                                children: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      bloc.changeUsername("");
                                      keyUser.currentState.changeTextOut("");
                                      bloc.changePassword("");
                                      keyPass.currentState.changeTextOut("");
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ResetPassword()));
                                    },
                                    child: BoldBlueText(
                                        eptxt('forgot_your_password'),
                                        textStyle: TextStyle(
                                            fontSize: tablet
                                                ? layoutHeight * 0.025
                                                : layoutHeight * 0.025,
                                            color: AppColors.PrimaryBlue,
                                            fontWeight: FontWeight.w700)),
                                  ),
                                  SizedBox(
                                    height: tablet ? hp(1) : 0,
                                  ),
                                  Container(
                                      width: tablet ? wp(42) : wp(81),
                                      child: Row(
                                        children: <Widget>[
                                          FutureBuilder(
                                            future: LoadFingerprint(),
                                            builder: (context, isFingerPrint) {
                                              if (isFingerPrint.data != null) {
                                                if (isFingerPrint.data > 0) {
                                                  return buildFingerprint(
                                                      context, isIOS);
                                                } else {
                                                  return Container();
                                                }
                                              } else {
                                                return Container();
                                              }
                                            },
                                          ),
                                          Expanded(
                                            child: StreamBuilder<bool>(
                                                stream: bloc.loginValid,
                                                builder: (context, snapshot) {
                                                  bool valid =
                                                      snapshot.hasData &&
                                                          !snapshot.hasError;
                                                  return GestureDetector(
                                                    onTap: () async {
                                                      bloc.loginWithCredentials(
                                                          context, true, null);
                                                    },
                                                    child: Container(
                                                      height: tablet
                                                          ? hp(7.5)
                                                          : hp(7),
                                                      padding: EdgeInsets.only(
                                                          left: wp(6.67),
                                                          right: wp(6.67)),
                                                      decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: AppColors
                                                                      .DarkGray
                                                                  .withOpacity(
                                                                      0.35),
                                                              offset:
                                                                  Offset(2, 2),
                                                              blurRadius: 2)
                                                        ],
                                                        gradient:
                                                            LinearGradient(
                                                                begin: Alignment
                                                                    .topRight,
                                                                end: Alignment
                                                                    .bottomLeft,
                                                                colors: [
                                                              AppColors
                                                                  .SecondBlue,
                                                              AppColors
                                                                  .PrimaryBlue,
                                                            ]),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          multilang
                                                              .get('sign_in')
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontSize: tablet
                                                                  ? hp(2.5)
                                                                  : wp(3.4),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              letterSpacing:
                                                                  1.33),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                            Container(
                                width: tablet ? wp(42) : wp(81),
                                child: Column(children: <Widget>[
                                  GestureDetector(
                                    onTap: () async {
                                      bloc.changeUsername("");
                                      keyUser.currentState.changeTextOut("");
                                      bloc.changePassword("");
                                      keyPass.currentState.changeTextOut("");

                                      print("OK");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CreateAccountScreen(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: tablet ? hp(7.5) : hp(7),
                                      padding: EdgeInsets.only(
                                          left: wp(6.67), right: wp(6.67)),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2.0,
                                            color: Color(0xFF979797)),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            tablet ? 5 : hp(5)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          multilang
                                              .get('create_new_account')
                                              .toUpperCase(),
                                          style: TextStyle(
                                              color: Color(0xFF174285),
                                              letterSpacing: tablet ? 0 : 1,
                                              fontSize:
                                                  tablet ? hp(2.5) : wp(3.4),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: hp(5),
                                  )
                                ]))
                          ],
                        )),
                  ],
                ),
              ),
            ])),
      ));
    }

    if (isIOS) {
      return _buildContent();
    } else {
      return WillPopScope(
        onWillPop: () async => false,
        child: _buildContent(),
      );
    }
  }

  Widget buildFingerprint(BuildContext context, bool isIOS) {
    return Container(
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () async {
              var fuser = await dao.getAll();
              if (fuser.length > 0) {
                var map = await BiometricPlugin.isSensorAvailable();
                BiometricPlugin.createSignature('Sign in', fuser[0].name)
                    .then((response) {
                  if (response['status'] == 'success') {
                    setState(() {
                      fingerprintstate = 1;
                    });
                    var signature = response['signedSignature'];
                    showLoading(context);
                    ApiService.create().login({
                      "id": fuser[0].name,
                      "signature": signature,
                      "loginType": 3
                    }).then((res) {
                      print(res.body);
                      bloc.loginWithCredentials(context, false, res);
                    }).catchError((e) {
                      print(e.body);
                    });
                  } else {
                    var failureReason = response['reason'];
                    setState(() {
                      fingerprintstate = 2;
                    });
                  }
                  print(response);
                });
              } else {
                print("NOO");
                print(fuser);
                print(fuser.length);
              }
              //_showFingerFace();
              /**/
            },
            child: Container(
              height: tablet ? hp(7.5) : hp(7),
              width: tablet ? hp(7.5) : hp(7),
              decoration: BoxDecoration(
                color: fingerprintstate == 0
                    ? AppColors.IconLightGray
                    : fingerprintstate == 1
                        ? AppColors.SuccessText
                        : AppColors.ErrorText,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Container(
                padding: EdgeInsets.all(hp(1.7)),
                child: Image.asset(
                  "assets/fingerprint/${isIOS ? "faceid" : "finger"}.png",
                  color: AppColors.PrimaryWhite,
                ),
              ),
            ),
          ),
          SizedBox(
            width: hp(1.5),
          ),
        ],
      ),
    );
  }
}
