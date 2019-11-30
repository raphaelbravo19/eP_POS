import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:flutter/material.dart';

class DistributorItem extends StatelessWidget {
  List<String> list = new List<String>();
  DistributorItem({this.list});
  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    return Container(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
            children: List.generate(list.length, (index) {
          return Container(
              padding: EdgeInsets.only(right: tablet ? wp(3) : wp(6)),
              decoration: BoxDecoration(
                  color: AppColors.PrimaryWhite,
                  border: Border(
                      bottom: BorderSide(
                          color: AppColors.DisabledText.withOpacity(0.2),
                          width: 1))),
              child: Row(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.symmetric(
                          vertical: hp(1.7), horizontal: hp(1.8)),
                      alignment: Alignment.center,
                      child: Container(
                        width: hp(5.9),
                        height: hp(5.9),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/customers/personal2.png")),
                            shape: BoxShape.circle,
                            color: AppColors.DarkGray),
                      )),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(0),
                          child: Text(
                            list[index],
                            style: TextStyle(
                                color: AppColors.DarkGray,
                                fontWeight: FontWeight.w700,
                                fontSize: hp(2.1),
                                letterSpacing: 0.5),
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: hp(0.8)),
                          child: Text("+91 96334 99640",
                              style: TextStyle(
                                  color:
                                      AppColors.DisabledText.withOpacity(0.5),
                                  fontWeight: FontWeight.w700,
                                  fontSize: hp(1.5),
                                  letterSpacing: 1))),
                    ],
                  )),
                  Container(
                      padding: EdgeInsets.only(right: hp(1.5)),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(0),
                              child: Text(
                                "22", //list[index],
                                style: TextStyle(
                                    color: AppColors.DarkGray,
                                    fontWeight: FontWeight.w700,
                                    fontSize: hp(2.1),
                                    letterSpacing: 0.5),
                              )),
                          Padding(
                              padding: EdgeInsets.only(top: hp(0.5)),
                              child: Text(eptxt('points'),
                                  style: TextStyle(
                                      color: AppColors.DisabledText.withOpacity(
                                          0.5),
                                      fontWeight: FontWeight.w700,
                                      fontSize: hp(1.5),
                                      letterSpacing: 1))),
                        ],
                      )),
                ],
              ));
        })),
      ),
    );
  }
}
