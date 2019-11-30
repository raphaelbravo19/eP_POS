import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_color.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:flutter/material.dart';

class EmployeeItem extends StatelessWidget {
  List<String> list = new List<String>();
  EmployeeItem({this.list});
  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    return Container(
      child: ListView.builder(
          itemCount: list.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
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
                            padding: EdgeInsets.only(top: hp(0.5)),
                            child: Text("Cashier",
                                style: TextStyle(
                                    color:
                                        AppColors.DisabledText.withOpacity(0.5),
                                    fontWeight: FontWeight.w700,
                                    fontSize: tablet ? hp(1.8) : hp(1.5),
                                    letterSpacing: 1))),
                      ],
                    )),
                    !tablet
                        ? SizedBox(width: 0)
                        : Container(
                            margin: EdgeInsets.only(right: wp(2.8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ButtonColor(
                                    title: 'CLOCK IN',
                                    paddingHorizontal: hp(2),
                                    borderRadius: hp(1.3),
                                    paddingVertical: hp(1.3),
                                    fontSize: hp(1.6),
                                    primary: AppColors.TabletClockinPrimary,
                                    secondary:
                                        AppColors.TabletClockinSecondary),
                                SizedBox(
                                  width: wp(3),
                                ),
                                ButtonColor(
                                  title: 'CLOCK OUT',
                                  paddingHorizontal: hp(2),
                                  borderRadius: hp(1.3),
                                  paddingVertical: hp(1.3),
                                  fontSize: hp(1.6),
                                  primary: AppColors.ClockOutPrimary,
                                  secondary: AppColors.ClockOutSecondary,
                                ),
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
                                  "2.55", //list[index],
                                  style: TextStyle(
                                      color: AppColors.DarkGray,
                                      fontWeight: FontWeight.w700,
                                      fontSize: hp(2.1),
                                      letterSpacing: 0.5),
                                )),
                            Padding(
                                padding: EdgeInsets.only(top: hp(0.5)),
                                child: Text("Hours",
                                    style: TextStyle(
                                        color:
                                            AppColors.DisabledText.withOpacity(
                                                0.5),
                                        fontWeight: FontWeight.w700,
                                        fontSize: tablet ? hp(1.8) : hp(1.5),
                                        letterSpacing: 1))),
                          ],
                        )),
                  ],
                ));
          }),
    );
  }
}
