import 'dart:io';

import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/dashboard/dashboard_screen.dart';
import 'package:epaisa_pos/src/views/fingerprint/widgets/fingerprint_dialog.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_border.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:biometric_plugin/biometric_plugin.dart';
import 'package:epaisa_pos/data/initial/countries/api_service.dart';
import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:epaisa_pos/data/models/currentusers_dao.dart';
import 'package:epaisa_pos/data/models/fingerprintuser_dao.dart';
import 'package:epaisa_pos/src/widgets/utils/request_helper.dart';
import 'package:epaisa_pos/src/widgets/utils/dialogs_helper.dart';

class FingerprintScreen extends StatefulWidget {
  FingerprintScreen({Key key}) : super(key: key);
  @override
  FingerprintScreenState createState() => FingerprintScreenState();
}

class FingerprintScreenState extends State<FingerprintScreen> {
  bool link = false;
  int indexStatus = 0;
  FingerprintUserDao dao = FingerprintUserDao(db);
  CurrentUsersDao daoUser = CurrentUsersDao(db);
  @override
  void initState() {
    //createKey();
    super.initState();
  }

  Future createKey() {
    BiometricPlugin.createKeys('Confirm fingerprint').then((response) {
      if (response['status'] == 'success') {
        var key = response['publicKey'];
        setState(() {
          indexStatus = 1;
        });
        showLoading(context);
        getauthkey().then((val) {
          ApiService.create().registerFingerprint(
              authKey: val, body: {"fingerprint": key}).then((res) async {
            print(res.body);
            setState(() {
              indexStatus = 1;
            });
            var user = await daoUser.getAll();
            var fuser = await dao.getAll();
            if (fuser.length == 0) {
              dao.add(
                  FingerprintUserDao.fromMap({"id": "0", "name": user[0].id}));
            } else {
              var edituser = fuser[0].toJson();
              edituser["name"] = user[0].id;
              dao.edit(FingerprintUserDao.fromMap(edituser));
            }
            Navigator.pop(context);

            //closeModal();
            Future.delayed(Duration(milliseconds: 500), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardScreen(),
                ),
              );
            });
          }).catchError((err) {
            setState(() {
              indexStatus = 2;
            });
            print(err.body);
            Future.delayed(Duration(milliseconds: 1000), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardScreen(),
                ),
              );
            });
          });
        });
      } else {
        var failureReason = response['reason'];
        setState(() {
          indexStatus = 2;
        });
        print(failureReason);

        Future.delayed(Duration(milliseconds: 1000), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardScreen(),
            ),
          );
        });
      }
      print(response);
    });
  }

  void _showDialog() {
    // flutter defined function
    setState(() {
      link = true;
    });
    print(link);
    createKey();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    var isIOS = Platform.isIOS;

    if (!isIOS) {
      FlutterStatusbarManager.setColor(Colors.white.withOpacity(0),
          animated: false);

      FlutterStatusbarManager.setStyle(StatusBarStyle.LIGHT_CONTENT);
    }

    var content = EpaisaScaffold(
      white: true,
      noSafe: true,
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(hp(tablet ? 3.1 : 2.5)),
                    decoration: BoxDecoration(
                        color: indexStatus == 0
                            ? AppColors.DarkGray
                            : indexStatus == 1
                                ? AppColors.SuccessText
                                : AppColors.ErrorText,
                        shape: BoxShape.circle),
                    child: Image.asset(
                      "assets/fingerprint/${isIOS ? "faceid" : "finger"}.png",
                      height: tablet ? hp(9) : hp(4.1),
                    ),
                  ),
                  SizedBox(
                    height: tablet ? hp(5) : hp(5),
                  ),
                  link
                      ? Column(
                          children: <Widget>[
                            Text(
                              isIOS
                                  ? 'Face ID for Login'
                                  : 'Fingerprint for Login',
                              style: TextStyle(
                                  fontSize: tablet ? hp(3.5) : hp(2.8),
                                  color: AppColors.TextGray,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.4),
                            ),
                            SizedBox(
                              height: hp(1.6),
                            ),
                            Text(
                              indexStatus == 0
                                  ? eptxt(isIOS
                                      ? 'register_faceid'
                                      : 'register_fingerprint')
                                  : indexStatus == 1
                                      ? eptxt(isIOS
                                          ? 'faceid_registered'
                                          : 'fingerprint_registered')
                                      : eptxt(isIOS
                                          ? 'faceid_not_found'
                                          : 'fingerprint_not_found'),
                              style: TextStyle(
                                  fontSize: tablet ? hp(2.1) : hp(1.8),
                                  color: indexStatus == 0
                                      ? AppColors.TextGray
                                      : indexStatus == 1
                                          ? AppColors.SuccessText
                                          : AppColors.ErrorText,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.2),
                            ),
                            tablet
                                ? SizedBox(
                                    height: hp(10),
                                  )
                                : Container(),
                          ],
                        )
                      : Column(
                          children: <Widget>[
                            Text(
                              "${eptxt(isIOS ? "faceid_login_title" : "fingerprint_login_title")}",
                              style: TextStyle(
                                  fontSize: tablet ? hp(4) : hp(2.8),
                                  color: AppColors.TextGray,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.4),
                            ),
                            SizedBox(
                              height: hp(2),
                            ),
                            Text(
                              "${isIOS ? eptxt('fingerprint_login_description_ios') : eptxt('fingerprint_login_description_android')} ${tablet ? eptxt('your_epaisa_account') + "." : ""}",
                              style: TextStyle(
                                  fontSize: tablet ? hp(2.3) : hp(1.7),
                                  color: AppColors.TextGray.withOpacity(0.9),
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.2),
                            ),
                            tablet
                                ? SizedBox(
                                    height: hp(10),
                                  )
                                : Text(
                                    "${eptxt('your_epaisa_account')}.",
                                    style: TextStyle(
                                        fontSize: hp(1.7),
                                        color:
                                            AppColors.TextGray.withOpacity(0.9),
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: -0.2),
                                  ),
                          ],
                        ),
                ]),
            Column(
              children: <Widget>[
                Spacer(
                  flex: 1,
                ),
                Text(
                  "${isIOS ? eptxt('fingerprint_login_note_ios') : eptxt('fingerprint_login_note_android')} ${tablet ? eptxt('login_your_epaisa_account') + "." : ""}",
                  style: TextStyle(
                      fontSize: tablet ? hp(2) : hp(1.4),
                      color: AppColors.TextGray.withOpacity(0.9),
                      fontWeight: FontWeight.w600),
                ),
                if (!tablet)
                  Text(
                    "${eptxt('login_your_epaisa_account')}.",
                    style: TextStyle(
                        fontSize: hp(1.4),
                        color: AppColors.TextGray.withOpacity(0.9),
                        fontWeight: FontWeight.w600),
                  ),
                SizedBox(
                  height: hp(1.5),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                    tablet ? wp(23) : 0,
                    0,
                    tablet ? wp(23) : 0,
                    tablet ? hp(4) : 0,
                  ),
                  height: tablet ? hp(8.3) : hp(7),
                  child: Row(children: <Widget>[
                    Expanded(
                      child: ButtonBorder(
                        callback: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DashboardScreen(),
                            ),
                          );
                        },
                        borderRadius: tablet ? hp(4) : 0,
                        title: eptxt('not_now').toUpperCase(),
                        shadowDirection: 'down',
                        borderColor: tablet
                            ? AppColors.TextGray.withOpacity(0.2)
                            : AppColors.PrimaryBlue,
                        elevation: tablet ? 4 : 0,
                        fontSize: tablet ? hp(2.2) : hp(1.7),
                        borderWidth: 1,
                      ),
                    ),
                    SizedBox(
                      width: tablet ? wp(5) : 0,
                    ),
                    Expanded(
                      child: ButtonGradient(
                        callback: () {
                          _showDialog();
                        },
                        borderRadius: tablet ? hp(4) : 0,
                        paddingVertical: hp(1.4),
                        paddingHorizontal: tablet? wp(isIOS? 2 : 5) : wp(isIOS? 3 : 5),
                        title: multilang
                            .get(isIOS
                                ? 'link_your_faceid'
                                : 'link_your_fingerprint')
                            .toUpperCase(),
                        fontSize: tablet ? hp(2.2) : isIOS? wp(3.7) : hp(1.7),
                      ),
                    )
                  ]),
                )
              ],
            )
          ],
        ),
      ),
    );

    if (isIOS) {
      return Scaffold(
        backgroundColor: AppColors.PrimaryWhite,
        body: content,
      );
    } else {
      return WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardScreen(),
            ),
          );
        },
        child: content,
      );
    }
  }
}
