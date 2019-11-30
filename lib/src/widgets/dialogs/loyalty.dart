import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_container.dart';
import 'package:flutter/material.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';

class LoyaltyDialog extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  LoyaltyDialog({this.width = 85, this.height = 85, this.title = ""});
  @override
  Widget build(BuildContext context) {
    var tablet = isTablet(MediaQuery.of(context));
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.6),
      body: 
            Center(
              child: Container(
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
                          padding: EdgeInsets.symmetric(horizontal: wp(5)),
                          child: Container(
                              //width: wp(tablet ? width * 0.6 : width),
                              alignment: Alignment.centerRight,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/dashboardscreen/loyalty${tablet ? '_landscape' : ''}.png'),
                                  fit: BoxFit.fitWidth,
                                ),
                              )),
                        )),
                        Container(
                          padding: EdgeInsets.only(left: wp(5), right: wp(4)),
                          width: width != null ? wp(width) : null,
                          child: Column(
                            crossAxisAlignment: tablet
                                ? CrossAxisAlignment.center
                                : CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(0),
                                child: Text(
                                  eptxt('loyalty_description_1'),
                                  style: TextStyle(
                                      fontSize: tablet ? wp(1.2) : hp(1.62),
                                      fontWeight: FontWeight.w700,
                                      color:
                                          AppColors.DarkGray.withOpacity(0.85)),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: hp(tablet ? 2.3 : 1.3)),
                                child: Text(
                                  eptxt('loyalty_description_2'),
                                  style: TextStyle(
                                      fontSize: tablet ? wp(1.2) : hp(1.62),
                                      fontWeight: FontWeight.w700,
                                      color:
                                          AppColors.DarkGray.withOpacity(0.85)),
                                ),
                              ),
                              tablet
                                  ? Container()
                                  : Padding(
                                      padding: EdgeInsets.only(top: hp(1.3)),
                                      child: TextFieldContainer(
                                        paddingHorizontal: hp(1.2),
                                        fontWeight: FontWeight.w700,
                                        fontSize: hp(1.8),
                                        hintText: multilang
                                            .get('loyalty_email_address'),
                                      )),
                              tablet
                                  ? Container()
                                  : Padding(
                                      padding: EdgeInsets.only(top: hp(1.3)),
                                      child: TextFieldContainer(
                                        paddingHorizontal: hp(1.2),
                                        fontWeight: FontWeight.w700,
                                        fontSize: hp(1.8),
                                        hintText: multilang
                                            .get('loyalty_mobile_number'),
                                      ),
                                    )
                            ],
                          ),
                        ),
                        tablet
                            ? Container(
                                padding: EdgeInsets.only(
                                    left: wp(5), right: wp(5), top: hp(3.3)),
                                width: width != null ? wp(width) : null,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 12,
                                      child: Container(
                                          width: 100,
                                          //padding: EdgeInsets.only(top: hp(1.3)),
                                          child: TextFieldContainer(
                                            paddingHorizontal: hp(1.2),
                                            fontWeight: FontWeight.w700,
                                            fontSize: wp(1.4),
                                            hintText: multilang
                                                .get('loyalty_email_address'),
                                          )),
                                    ),
                                    Spacer(
                                      flex: 1,
                                    ),
                                    Expanded(
                                        flex: 12,
                                        child: Container(
                                            width: 100,
                                            // padding: EdgeInsets.only(top: hp(1.3)),
                                            child: TextFieldContainer(
                                              paddingHorizontal: hp(1.2),
                                              fontWeight: FontWeight.w700,
                                              fontSize: wp(1.4),
                                              hintText: multilang
                                                  .get('loyalty_mobile_number'),
                                            ))),
                                  ],
                                ),
                              )
                            : Container(),
                        Container(
                            padding:
                                EdgeInsets.fromLTRB(wp(5), hp(2), wp(5), hp(2)),
                            child: ButtonGradient(
                                fontWeight:
                                    tablet ? FontWeight.w600 : FontWeight.w700,
                                letterSpacing: 0.5,
                                paddingVertical: tablet ? hp(2) : hp(1.8),
                                title: eptxt('loyalty_subscribe').toUpperCase(),
                                borderRadius: hp(2),
                                fontSize: tablet ? wp(1.2) : hp(1.5)))
                      ],
                    ),
                  )),
            )
        
        
      
    );
  }
}
