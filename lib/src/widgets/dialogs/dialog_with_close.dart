import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:flutter/material.dart';

class DialogWithClose extends StatelessWidget {
  final String message;
  final Function callback;
  DialogWithClose({this.message, this.callback});
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
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
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
                Container(
                    alignment: Alignment.center,
                    width: tablet ? hp(60) : wp(70),
                    padding: EdgeInsets.only(
                        left: wp(5), right: wp(5), top: hp(3), bottom: hp(2)),
                    decoration: BoxDecoration(
                        color: AppColors.PrimaryWhite,
                        borderRadius: BorderRadius.circular(10)),
                    // color: AppColors.PrimaryWhite,
                    child: Column(
                      children: <Widget>[
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: tablet ? wp(1.85) : hp(2.3),
                              color: AppColors.DisabledText,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: hp(2),
                        ),
                        Container(
                          width: wp(50),
                          child: ButtonGradient(
                              callback: () {
                                if (callback != null) {
                                  callback();
                                }
                                Navigator.of(context).pop();
                              },
                              paddingVertical: tablet ? hp(2.1) : hp(1.8),
                              title: "OK",
                              borderRadius: hp(2),
                              fontSize: hp(1.7)),
                        )
                      ],
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
