import 'dart:io';

import 'package:biometric_plugin/biometric_plugin.dart';
import 'package:epaisa_pos/data/initial/countries/api_service.dart';
import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:epaisa_pos/data/models/currentusers_dao.dart';
import 'package:epaisa_pos/data/models/fingerprintuser_dao.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_border.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/utils/dialogs_helper.dart';
import 'package:epaisa_pos/src/widgets/utils/request_helper.dart';
import 'package:flutter/material.dart';

class FingerprintDialog extends StatefulWidget {
  FingerprintDialog({Key key, this.goto}) : super(key: key);
  final Function goto;
  @override
  FingerprintDialogState createState() => FingerprintDialogState();
}

class FingerprintDialogState extends State<FingerprintDialog> {
  bool showModal = true;
  bool resendDisabled = true;
  int indexStatus = 0;
  FingerprintUserDao dao = FingerprintUserDao(db);
  CurrentUsersDao daoUser = CurrentUsersDao(db);
  @override
  void initState() {
    createKey();
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
              widget.goto();
            });
          }).catchError((err) {
            setState(() {
              indexStatus = 2;
            });
            print(err.body);
            Future.delayed(Duration(milliseconds: 1000), () {
              widget.goto();
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
          widget.goto();
        });
      }
      print(response);
    });
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
    var isIOS = Platform.isIOS;
    Widget content() {
      return Container(
        width: (tablet ? wp(34) : wp(80)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: tablet ? wp(2) : wp(3)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: tablet ? hp(9) : hp(5),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          indexStatus = indexStatus == 2 ? 0 : indexStatus + 1;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(hp(2.5)),
                        decoration: BoxDecoration(
                            color: indexStatus == 0
                                ? AppColors.DarkGray
                                : indexStatus == 1
                                    ? AppColors.SuccessText
                                    : AppColors.ErrorText,
                            shape: BoxShape.circle),
                        child: Image.asset(
                          "assets/fingerprint/finger.png",
                          height: tablet ? hp(5) : hp(4.1),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: tablet ? hp(3) : hp(3),
                    ),
                    Text(
                      isIOS ? 'Face ID - Login' : 'Fingerprint - Login',
                      style: TextStyle(
                          fontSize: tablet ? hp(3.5) : hp(2.8),
                          color: AppColors.TextGray,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.4),
                    ),
                    SizedBox(
                      height: hp(5),
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
                    SizedBox(
                      height: tablet ? hp(5) : hp(3),
                    ),
                    indexStatus == 2
                        ? Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: tablet ? 0 : wp(2)),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: ButtonBorder(
                                    borderRadius: tablet ? hp(4) : hp(4),
                                    paddingVertical: hp(1.7),
                                    callback: () {
                                      closeModal();
                                    },
                                    title: eptxt('not_now').toUpperCase(),
                                    shadowDirection: 'down',
                                    borderColor:
                                        AppColors.TextGray.withOpacity(0.2),
                                    fontSize: tablet ? hp(2.2) : hp(1.8),
                                  ),
                                ),
                                SizedBox(
                                  width: tablet ? wp(1.5) : wp(3.5),
                                ),
                                Expanded(
                                  child: ButtonGradient(
                                    borderRadius: tablet ? hp(4) : hp(4),
                                    paddingVertical: hp(1.7),
                                    title: eptxt('settings').toUpperCase(),
                                    fontSize: tablet ? hp(2.2) : hp(1.8),
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: tablet ? wp(3) : wp(12)),
                            child: ButtonGradient(
                              callback: () {
                                closeModal();
                              },
                              borderRadius: tablet ? hp(4) : hp(4),
                              paddingVertical: hp(1.7),
                              title: eptxt('cancel').toUpperCase(),
                              fontSize: tablet ? hp(2.2) : hp(1.8),
                            ),
                          ),
                    SizedBox(
                      height: tablet ? hp(4) : hp(2.8),
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
                        width: (tablet ? wp(34) : wp(80)),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(),
                            ),
                            Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      tablet ? wp(1) : wp(2)),
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
