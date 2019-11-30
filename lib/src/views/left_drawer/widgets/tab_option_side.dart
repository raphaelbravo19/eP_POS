import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:flutter/material.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';

class TabVerticalSide extends StatefulWidget {
  const TabVerticalSide({Key key, this.onTap,this.changeTab,this.tabIndex}) : super(key: key);
  final Function onTap;
  final Function changeTab;
  final int tabIndex;
  @override
  _TabVerticalSideState createState() => _TabVerticalSideState();
}

class _TabVerticalSideState extends State<TabVerticalSide> {
  int selected;

  @override
  void initState() {
    
    selected=widget.tabIndex;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));

    return Column(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                selected = 0;
              });
              widget.onTap(0);
            },
            child: Container(
              color: selected == 0
                  ? AppColors.BackSecondGray
                  : AppColors.BackPrimaryGray,
              alignment: Alignment.centerLeft,
              child: Stack(
                alignment: Alignment.centerLeft,
                fit: StackFit.loose,
                children: <Widget>[
                  selected == 0
                      ? Container(
                          width: tablet ? wp(0.3) : wp(1),
                          color: AppColors.FocusBoxBlue,
                        )
                      : Container(),
                  Container(
                    //alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: hp(0.8)),
                          alignment: Alignment.center,
                          child: Image.asset("assets/leftdrawer/quick.png"),
                          height: hp(4),
                        ),
                        Text(
                          eptxt('ld_quick_payment'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: hp(1.3),
                              fontWeight: FontWeight.w600,
                              //font
                              color: AppColors.PrimaryWhite),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: hp(0.25),
        ),
        Expanded(
            child: GestureDetector(
          onTap: () {
            setState(() {
              selected = 1;
            });
            widget.onTap(1);
          },
          child: Container(
            color: selected == 1
                ? AppColors.BackSecondGray
                : AppColors.BackPrimaryGray,
            alignment: Alignment.centerLeft,
            child: Stack(
              alignment: Alignment.centerLeft,
              fit: StackFit.loose,
              children: <Widget>[
                selected == 1
                    ? Container(
                        width: tablet ? wp(0.3) : wp(1),
                        color: AppColors.FocusBoxBlue,
                      )
                    : Container(),
                Container(
                  //alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: hp(0.8)),
                        alignment: Alignment.center,
                        child: Image.asset("assets/leftdrawer/pos.png"),
                        height: hp(5),
                      ),
                      Text(
                        eptxt('ld_point_of_sale'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: hp(1.3),
                            fontWeight: FontWeight.w600,
                            //font
                            color: AppColors.PrimaryWhite),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )),
        SizedBox(
          height: hp(0.25),
        ),
        Expanded(
            child: GestureDetector(
          onTap: () {
            setState(() {
              selected = 2;
            });
            widget.onTap(2);
          },
          child: Container(
            color: selected == 2
                ? AppColors.BackSecondGray
                : AppColors.BackPrimaryGray,
            alignment: Alignment.centerLeft,
            child: Stack(
              alignment: Alignment.centerLeft,
              fit: StackFit.loose,
              children: <Widget>[
                selected == 2
                    ? Container(
                        width: tablet ? wp(0.3) : wp(1),
                        color: AppColors.FocusBoxBlue,
                      )
                    : Container(),
                Container(
                  //alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: hp(0.8)),
                        alignment: Alignment.center,
                        child: Image.asset("assets/leftdrawer/inventory.png"),
                        height: hp(5),
                      ),
                      Text(
                        eptxt('ld_inventory_management'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: hp(1.3),
                            fontWeight: FontWeight.w600,
                            //font
                            color: AppColors.PrimaryWhite),
                      ), ],
                  ),
                )
              ],
            ),
          ),
        )),
        SizedBox(
          height: hp(0.25),
        ),
        Expanded(
            child: GestureDetector(
          onTap: () {
            setState(() {
              selected = 3;
            });
            widget.onTap(3);
          },
          child: Container(
            color: selected == 3
                ? AppColors.BackSecondGray
                : AppColors.BackPrimaryGray,
            alignment: Alignment.centerLeft,
            child: Stack(
              alignment: Alignment.centerLeft,
              fit: StackFit.loose,
              children: <Widget>[
                selected == 3
                    ? Container(
                        width: tablet ? wp(0.3) : wp(1),
                        color: AppColors.FocusBoxBlue,
                      )
                    : Container(),
                Container(
                  //alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: hp(0.8)),
                        alignment: Alignment.center,
                        child: Image.asset("assets/leftdrawer/loyalty.png"),
                        height: hp(4),
                      ),
                      Text(
                        eptxt('loyalty'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: hp(1.3),
                            fontWeight: FontWeight.w600,
                            //font
                            color: AppColors.PrimaryWhite),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )),
        SizedBox(
          height: hp(0.25),
        ),
        Expanded(
            child: GestureDetector(
          onTap: () {
            setState(() {
              selected = 4;
            });
            widget.onTap(4);
          },
          child: Container(
            color: selected == 4
                ? AppColors.BackSecondGray
                : AppColors.BackPrimaryGray,
            alignment: Alignment.centerLeft,
            child: Stack(
              alignment: Alignment.centerLeft,
              fit: StackFit.loose,
              children: <Widget>[
                selected == 4
                    ? Container(
                        width: tablet ? wp(0.3) : wp(1),
                        color: AppColors.FocusBoxBlue,
                      )
                    : Container(),
                Container(
                  //alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: hp(0.8)),
                        alignment: Alignment.center,
                        child: Image.asset("assets/leftdrawer/vas.png"),
                        height: hp(5),
                      ),
                      Text(
                        eptxt('vas'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: hp(1.3),
                            fontWeight: FontWeight.w600,
                            //font
                            color: AppColors.PrimaryWhite),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ))
      ],
    );
  }
}
