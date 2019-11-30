import 'dart:io';

import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/help/help_screen.dart';
import 'package:epaisa_pos/src/views/help/live_chat/live_chat_screen.dart';
import 'package:epaisa_pos/src/views/main_view/main_view_screen.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_border.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UpgradeToPOS extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  UpgradeToPOS({this.width = 85, this.height = 85, this.title = ""});
  @override
  Widget build(BuildContext context) {
    var tablet = isTablet(MediaQuery.of(context));
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var iOS = Platform.isIOS;
    var words = '${eptxt('upgrade_to')} ${eptxt('point_of_sale')}';
    if (iOS) {
      words = 'Upgrade%20to%20Point%20of%20Sale';
    }
    List<String> description = [
      eptxt('upgrade_description'),
      eptxt('upgrade_cash_register'),
      eptxt('upgrade_inventory'),
      eptxt('upgrade_OMNI'),
      eptxt('upgrade_business'),
    ];
    final descriptionFontSize = tablet ? hp(2.2) : wp(3.6);
    List<Widget> buildDescription() {
      List<Widget> list = new List<Widget>();
      if (description != null) {
        //description.forEach((x) {
        if (tablet) {
          list.add(Padding(
              padding:
                  EdgeInsets.symmetric(vertical: tablet ? hp(0.8) : hp(0.25)),
              child: Text(
                description[0],
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: AppColors.DarkGray,
                    fontSize: tablet ? hp(2.2) : wp(1.4),
                    fontWeight: FontWeight.w600),
              )));
          list.add(Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: tablet ? hp(0.8) : hp(0.25)),
                        child: Text(
                          description[1],
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: AppColors.DarkGray,
                              fontSize: descriptionFontSize,
                              fontWeight: FontWeight.w600),
                        )),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: tablet ? hp(0.8) : hp(0.25)),
                        child: Text(
                          description[2],
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: AppColors.DarkGray,
                              fontSize: descriptionFontSize,
                              fontWeight: FontWeight.w600),
                        ))
                  ],
                ),
                SizedBox(
                  width: hp(2),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: tablet ? hp(0.8) : hp(0.25)),
                        child: Text(
                          description[3],
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: AppColors.DarkGray,
                              fontSize: descriptionFontSize,
                              fontWeight: FontWeight.w600),
                        )),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: tablet ? hp(0.8) : hp(0.25)),
                        child: Text(
                          description[4],
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: AppColors.DarkGray,
                              fontSize: descriptionFontSize,
                              fontWeight: FontWeight.w600),
                        ))
                  ],
                )
              ],
            ),
          ));
        } else {
          description.forEach((x) {
            list.add(Padding(
                padding: EdgeInsets.symmetric(vertical: hp(0.25)),
                child: Text(
                  x,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: AppColors.DarkGray,
                      fontSize: descriptionFontSize,
                      fontWeight: FontWeight.w600),
                )));
          });
        }
        /*list.add(Padding(
            padding: EdgeInsets.symmetric(vertical: hp(0.25)),
            child: Text(
              description[0],
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: AppColors.DarkGray,
                  fontSize: tablet ? wp(1.45) : hp(1.55),
                  fontWeight: FontWeight.w600),
            )));
*/
        // });
      } else {
        list.add(Container());
      }
      return list;
    }

    _launchURL(String toMailId, String subject, String body) async {
      var url =
          'mailto:support@epaisa.com?subject=Upgrade%20to%20Point%20of%20Sale';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

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
                print("IsPressed");
              },
              child: Container(
                width: wp(100),
                height: hp(100),
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            Container(
                width: width != null ? tablet ? hp(height) : wp(width) : null,
                height: height != null ? hp(height) : null,
                decoration: BoxDecoration(
                    color: AppColors.PrimaryWhite,
                    borderRadius: BorderRadius.circular(hp(2))),
                // color: AppColors.PrimaryWhite,
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.centerRight,
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(top: hp(1)),
                              alignment: Alignment.center,
                              child: Text(
                                title,
                                style: TextStyle(
                                    fontSize: tablet ? wp(1.85) : hp(2.3),
                                    color: AppColors.DarkGray,
                                    fontWeight: FontWeight.w700),
                              )),
                          Container(
                              child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: hp(1.6), horizontal: wp(2)),
                                child: Image.asset(
                                  "assets/general_icons/xbutton.png",
                                  height: hp(2),
                                )),
                          ))
                        ],
                      ),
                      //content
                      Expanded(
                          child: Container(
                              alignment: Alignment.centerRight,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/dashboardscreen/upgrade${tablet ? '_landscape' : ''}.png'),
                                  fit: BoxFit.contain,
                                ),
                              ))),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: wp(5)),
                        width: width != null ? wp(width) : null,
                        child: Column(
                          crossAxisAlignment: tablet
                              ? CrossAxisAlignment.center
                              : CrossAxisAlignment.start,
                          children: buildDescription(),
                        ),
                      ),
                      Padding(
                          padding: tablet
                              ? EdgeInsets.only(top: hp(1))
                              : EdgeInsets.symmetric(vertical: hp(0.6)),
                          child: Text(
                            eptxt('upgrade_want'),
                            style: TextStyle(
                                fontSize: tablet ? wp(1.8) : hp(2.1),
                                color: AppColors.DarkGray,
                                fontWeight: FontWeight.w700),
                          )),
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: wp(5),
                              vertical: tablet ? hp(3) : hp(1.5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                  flex: 10,
                                  child: ButtonBorder(
                                    callback: () =>
                                        launch("tel://+919810001234"),
                                    paddingVertical: tablet ? hp(2.1) : hp(1.8),
                                    title: multilang
                                        .get('upgrade_call')
                                        .toUpperCase(),
                                    borderRadius: hp(2),
                                    fontSize: hp(1.7),
                                  )),
                              Spacer(
                                flex: 1,
                              ),
                              Expanded(
                                  flex: 10,
                                  child: ButtonGradient(
                                    callback: () => _launchURL(
                                        'support@epaisa.com', words, ''),
                                    paddingVertical: tablet ? hp(2.1) : hp(1.8),
                                    title: multilang
                                        .get('upgrade_email')
                                        .toUpperCase(),
                                    borderRadius: hp(2),
                                    fontSize: hp(1.7),
                                  )),
                              tablet
                                  ? Spacer(
                                      flex: 1,
                                    )
                                  : Container(),
                              tablet
                                  ? Expanded(
                                      flex: 10,
                                      child: ButtonGradient(
                                        callback: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MainViewScreen(
                                                        defaultIndex: 10,
                                                      ) /*HelpScreen(
                                                        index: 1,*/
                                                  ));
                                        },
                                        paddingVertical:
                                            tablet ? hp(2.1) : hp(1.8),
                                        title: multilang
                                            .get('upgrade_live_chat')
                                            .toUpperCase(),
                                        borderRadius: hp(2),
                                        fontSize: hp(1.7),
                                      ))
                                  : Container()
                            ],
                          )),
                      tablet
                          ? Container()
                          : Container(
                              padding:
                                  EdgeInsets.fromLTRB(wp(5), 0, wp(5), hp(2)),
                              child: ButtonGradient(
                                  callback: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LiveChatScreen()));
                                  },
                                  paddingVertical: hp(1.8),
                                  title: multilang
                                      .get('upgrade_live_chat')
                                      .toUpperCase(),
                                  borderRadius: hp(2),
                                  fontSize: hp(1.7)))
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
