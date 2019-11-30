import 'package:epaisa_pos/data/initial/countries/api_service.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/create_account/create_account_screen.dart';
import 'package:epaisa_pos/src/views/login/login_screen.dart';
import 'package:epaisa_pos/src/views/magic_link/bloc/magic_bloc.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/textfields/texfield_number.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:flutter/material.dart';

class MagicSignScreen extends StatefulWidget {
  @override
  _MagicSignScreenState createState() => _MagicSignScreenState();
}

class _MagicSignScreenState extends State<MagicSignScreen> {
  GlobalKey<TextfieldClassicState> emailKey =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldNumberState> numberKey =
      new GlobalKey<TextfieldNumberState>();
  MagicBloc bloc = new MagicBloc();
  var last = -1;
  var api;
  @override
  void initState() {
    api = ApiService.create();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: hp(100),
          decoration: BoxDecoration(
            color: AppColors.MagicColor,
          ),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.asset(
                "assets/splashscreen/background_landscape.png",
                color: Colors.white,
                fit: BoxFit.cover,
              ),
              SafeArea(
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: wp(3)),
                        margin: EdgeInsets.only(
                          bottom: hp(2),
                          top: tablet ? hp(2) : 0,
                        ),
                        width: wp(100),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: hp(13),
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: tablet ? wp(2.3) : wp(3)),
                                alignment: Alignment.bottomLeft,
                                child: Image.asset(
                                  "assets/magiclink/logo_magic.png",
                                  width: tablet ? hp(28) : wp(35),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding:
                                    EdgeInsets.symmetric(horizontal: wp(2.5)),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      width: wp(80),
                                      child: Text(
                                        multilang.get('where_send_magic_link'),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AppColors.DarkWhite,
                                          fontSize: tablet ? hp(5) : wp(4.2),
                                          fontWeight: tablet
                                              ? FontWeight.w600
                                              : FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: tablet ? hp(3) : hp(.5),
                                    ),
                                    Container(
                                      width: tablet ? hp(65) : wp(100),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        elevation: 4.0,
                                        child: Container(
                                          child: Center(
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                    tablet ? wp(3.5) : wp(8),
                                                    hp(2),
                                                    tablet ? wp(3.5) : wp(8),
                                                    hp(3),
                                                  ),
                                                  child: Column(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: tablet
                                                            ? hp(3)
                                                            : hp(1),
                                                      ),
                                                      StreamBuilder(
                                                        stream: bloc.mobile,
                                                        builder:
                                                            (context, snap) {
                                                          var mvalid = !snap
                                                                  .hasError &&
                                                              snap.hasData &&
                                                              snap.data != "";
                                                          return TextfieldClassic(
                                                            disabled: mvalid,
                                                            stream: bloc.email,
                                                            key: emailKey,
                                                            fontSize: tablet
                                                                ? hp(2.7)
                                                                : hp(2.01),
                                                            paddingBottomInput:
                                                                tablet
                                                                    ? hp(1.5)
                                                                    : hp(1),
                                                            labelText: multilang
                                                                .get('email'),
                                                            onChanged: (str) {
                                                              bloc.changeMail(
                                                                  str);
                                                            },
                                                            onFocusChange: (f) {
                                                              if (f) {
                                                                setState(() {
                                                                  last = 1;
                                                                });
                                                              }
                                                            },
                                                            onSubmitted: (str,
                                                                valid) async {
                                                              if (valid &&
                                                                  str != '') {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return Center(
                                                                        child:
                                                                            SizedBox(
                                                                          height:
                                                                              hp(6),
                                                                          width:
                                                                              hp(6),
                                                                          child:
                                                                              CircularProgressIndicator(
                                                                            strokeWidth:
                                                                                hp(1),
                                                                            backgroundColor:
                                                                                AppColors.PrimaryWhite,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    });
                                                                await bloc
                                                                    .sendEmail(
                                                                        str,
                                                                        context);
                                                              }
                                                            },
                                                          );
                                                        },
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical:
                                                                    hp(2)),
                                                        child: Text(
                                                          lang('or', u: true),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF5D6770),
                                                            fontSize: tablet
                                                                ? hp(4)
                                                                : hp(3),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      StreamBuilder(
                                                        stream: bloc.email,
                                                        builder:
                                                            (context, snap) {
                                                          var evalid = !snap
                                                                  .hasError &&
                                                              snap.hasData &&
                                                              snap.data != "";
                                                          return TextfieldNumber(
                                                            disable: evalid,
                                                            stream: bloc.mobile,
                                                            key: numberKey,
                                                            fontSize: tablet
                                                                ? hp(2.7)
                                                                : hp(2.01),
                                                            paddingBottomInput:
                                                                tablet
                                                                    ? hp(1.5)
                                                                    : hp(1),
                                                            labelText:
                                                                multilang.get(
                                                                    'mobile_number'),
                                                            onChanged: (str) {
                                                              bloc.changeMobile(
                                                                  str);
                                                            },
                                                            onFocusChange: (f) {
                                                              if (f) {
                                                                setState(() {
                                                                  last = 2;
                                                                });
                                                              }
                                                            },
                                                            onSubmitted: (str,
                                                                valid) async {
                                                              if (valid &&
                                                                  str.length >
                                                                      10) {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return Center(
                                                                        child:
                                                                            SizedBox(
                                                                          height:
                                                                              hp(6),
                                                                          width:
                                                                              hp(6),
                                                                          child:
                                                                              CircularProgressIndicator(
                                                                            strokeWidth:
                                                                                hp(1),
                                                                            backgroundColor:
                                                                                AppColors.PrimaryWhite,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    });
                                                                await bloc
                                                                    .sendMobile(
                                                                        str,
                                                                        context);
                                                              }
                                                            },
                                                          );
                                                        },
                                                      ),
                                                      SizedBox(
                                                        height: tablet
                                                            ? hp(3)
                                                            : hp(3),
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    tablet
                                                                        ? hp(1)
                                                                        : 0),
                                                        child: StreamBuilder(
                                                            stream: bloc.email,
                                                            builder: (context,
                                                                snap) {
                                                              return StreamBuilder(
                                                                  stream: bloc
                                                                      .mobile,
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    var evalid = !snap
                                                                            .hasError &&
                                                                        snap
                                                                            .hasData &&
                                                                        snap.data !=
                                                                            "";
                                                                    var mvalid = !snapshot.hasError &&
                                                                        snapshot
                                                                            .hasData &&
                                                                        snapshot.data !=
                                                                            "";

                                                                    return ButtonGradient(
                                                                      disabled:
                                                                          !(evalid ||
                                                                              mvalid),
                                                                      callback:
                                                                          () async {
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return Center(
                                                                                child: SizedBox(
                                                                                  height: hp(6),
                                                                                  width: hp(6),
                                                                                  child: CircularProgressIndicator(
                                                                                    strokeWidth: hp(1),
                                                                                    backgroundColor: AppColors.PrimaryWhite,
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            });
                                                                        try {
                                                                          if (evalid &&
                                                                              !(last == 2 && mvalid)) {
                                                                            bloc.sendEmail(emailKey.currentState.value,
                                                                                context);
                                                                          } else if (mvalid) {
                                                                            bloc.sendMobile(numberKey.currentState.getNumberString(),
                                                                                context);
                                                                          } else {
                                                                            Navigator.pop(context);
                                                                          }
                                                                        } catch (e) {
                                                                          print(
                                                                              e);
                                                                        }
                                                                      },
                                                                      darkShadow:
                                                                          true,
                                                                      shadowLevel:
                                                                          2,
                                                                      paddingVertical: tablet
                                                                          ? hp(
                                                                              2.4)
                                                                          : hp(
                                                                              1.85),
                                                                      fontSize: tablet
                                                                          ? hp(
                                                                              2.6)
                                                                          : wp(
                                                                              3.1),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      borderRadius:
                                                                          hp(5),
                                                                      filled:
                                                                          true,
                                                                      fillColor:
                                                                          AppColors
                                                                              .MagicColor,
                                                                      textColor:
                                                                          AppColors
                                                                              .PrimaryWhite,
                                                                      title: lang(
                                                                          'send',
                                                                          u: true),
                                                                    );
                                                                  });
                                                            }),
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
                                    SizedBox(
                                      height: tablet ? hp(8) : hp(9),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: wp(7)),
                              width: tablet ? hp(70) : wp(100),
                              child: ButtonGradient(
                                callback: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CreateAccountScreen()));
                                },
                                darkShadow: true,
                                shadowLevel: 2,
                                paddingVertical: tablet ? hp(2.4) : hp(1.85),
                                fontSize: tablet ? hp(2.6) : wp(3.1),
                                fontWeight: FontWeight.w700,
                                borderRadius: hp(5),
                                primaryColor: AppColors.LightPink,
                                secondaryColor: AppColors.PrimaryWhite,
                                textColor: AppColors.MagicColor,
                                title: lang('register', u: true),
                              ),
                            ),
                            // if (!tablet)
                            SizedBox(
                              height: hp(2),
                            ),
                            if (!tablet)
                              Opacity(
                                opacity: 0,
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: wp(7)),
                                  child: ButtonGradient(
                                      callback: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginScreen()));
                                      },
                                      darkShadow: true,
                                      shadowLevel: 2,
                                      paddingVertical: hp(1.85),
                                      fontSize: tablet ? hp(2.3) : wp(3.1),
                                      fontWeight: FontWeight.w600,
                                      borderRadius: hp(5),
                                      primaryColor: AppColors.LightPink,
                                      secondaryColor: AppColors.PrimaryWhite,
                                      textColor: AppColors.MagicColor,
                                      title: "I'LL SIGN IN MANUALLY"),
                                ),
                              ),
                            SizedBox(
                              height: hp(5),
                            ),
                          ],
                        )),
                    Positioned(
                      right: tablet ? wp(2.5) : wp(4),
                      top: tablet ? hp(5.2) : hp(3.5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: tablet
                            ? Image.asset(
                                "assets/general_icons/Rounded.png",
                                color: AppColors.PrimaryWhite,
                                height: hp(3.8),
                              )
                            : Image.asset(
                                "assets/general_icons/Rounded.png",
                                color: AppColors.PrimaryWhite,
                                height: hp(2.2),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
