import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/dashboard/dashboard_screen.dart';
import 'package:epaisa_pos/src/views/left_drawer/widgets/tab_option_side.dart';
import 'package:epaisa_pos/src/views/left_drawer/widgets/tab_sub_options.dart';
import 'package:flutter/material.dart';
import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:epaisa_pos/data/models/currentcompanys_dao.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:io';

class LeftDrawerScreen extends StatefulWidget {
  final Function onTap;
  final Function changeTab;
  final int tabIndex;
  LeftDrawerScreen({this.onTap, this.changeTab, this.tabIndex = 0});

  @override
  _LeftDrawerScreenState createState() => _LeftDrawerScreenState();
}

class _LeftDrawerScreenState extends State<LeftDrawerScreen> {
  var _username = 'User';
  var _userImage = 'http://via.placeholder.com/100x100/';
  int stateView;
  BehaviorSubject<int> streamCompany = BehaviorSubject<int>();

  @override
  void initState() {
    stateView = widget.tabIndex;
    super.initState();
  }

  Future<List<CurrentCompany>> getCompanies() async {
    CurrentCompanysDao companyDao = CurrentCompanysDao(db);
    var companies = await companyDao.getAll();
    return companies;
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));

    return Scaffold(
      backgroundColor: AppColors.BackPrimaryGray,
      body: SafeArea(
        bottom: false,
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => DashboardScreen(),
                    ),
                  );
                },
                child: Container(
                  //width: wp(87),
                  color: AppColors.BackPrimaryGray,
                  height: hp(27),
                  alignment: Alignment.center,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: hp(2.5),
                          ),
                          Container(
                              width: wp(87),
                              child: Container(
                                width: hp(9),
                                height: hp(9),
                                decoration: BoxDecoration(
                                    color: AppColors.BackPrimaryGray,
                                    shape: BoxShape.circle),
                                child: FutureBuilder<List<CurrentCompany>>(
                                    future: getCompanies(),
                                    builder: (context, snapshot) {
                                      if (snapshot.data != null) {
                                        return StreamBuilder<int>(
                                            stream: streamCompany,
                                            builder: (context, snap) {
                                              if (snap.data == null) {
                                                streamCompany.sink.add(0);
                                              }
                                              if (snap.data != null) {
                                                print(
                                                    "IMAGE ${snapshot.data[snap.data]}");
                                                return Picture(
                                                    userImage: snapshot
                                                        .data[snap.data].image);
                                              } else {
                                                return Picture(
                                                    userImage: _userImage);
                                              }
                                            });
                                      } else {
                                        return Picture(userImage: _userImage);
                                      }
                                    }),
                              )),
                          SizedBox(
                            height: hp(2.7),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              color: AppColors.PrimaryWhite,
                                              width: 2))),
                                  child: Text(
                                    "Abheer Kaushik ",
                                    style: TextStyle(
                                        color: AppColors.PrimaryWhite,
                                        fontSize: hp(2),
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Text(
                                  " Partner",
                                  style: TextStyle(
                                      color: AppColors.PrimaryWhite,
                                      fontSize: hp(2),
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: hp(1.5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              color: AppColors.PrimaryWhite,
                                              width: 2))),
                                  child: Text(
                                    "Espresso Café ",
                                    style: TextStyle(
                                        color: AppColors.PrimaryWhite,
                                        fontSize: hp(2),
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Text(
                                  " Bandra West",
                                  style: TextStyle(
                                      color: AppColors.PrimaryWhite,
                                      fontSize: hp(2),
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: hp(2.5), top: hp(3)),
                        child: Stack(
                          overflow: Overflow.visible,
                          alignment: Alignment.topRight,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                widget.onTap(15);
                              },
                              child: Image.asset(
                                  "assets/leftdrawer/notification.png",
                                  width: hp(3.4)),
                            ),
                            Positioned(
                                right: -hp(1),
                                top: -hp(1.2),
                                child: Container(
                                  padding: EdgeInsets.all(hp(.1)),
                                  width: hp(2.6),
                                  height: hp(2.6),
                                  decoration: BoxDecoration(
                                      color: AppColors.NotificationGreen,
                                      shape: BoxShape.circle),
                                  child: FittedBox(
                                    child: Text(
                                      "7",
                                      style: TextStyle(
                                          color: AppColors.PrimaryWhite,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: hp(0.4)),
                  color: AppColors.BackSecondGray,
                  child: Row(
                    children: <Widget>[
                      Container(
                        //color: AppColors.BackPrimaryGray,
                        width: tablet ? wp(7) : wp(20),
                        child: TabVerticalSide(
                          tabIndex: stateView,
                          onTap: (val) {
                            print(val);
                            setState(() {
                              stateView = val;
                            });
                            widget.changeTab(val);
                          },
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: AppColors.BackSecondGray,
                          child: TabSubOptions(
                            onTap: widget.onTap,
                            stateView: stateView,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Picture extends StatelessWidget {
  final String userImage;
  final bool isTablet;
  Picture({
    this.isTablet = false,
    @required this.userImage,
  });

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final double size = isTablet ? hp(9) : hp(9);
    return Container(
      alignment: Alignment.center,
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size),
          child: userImage != null
              ? userImage.indexOf("files") != -1|| userImage.indexOf("Application") != -1 
                  ? ClipOval(
                      child: Image.file(
                      File(userImage.substring(7, userImage.length - 1)),
                      fit: BoxFit.cover,
                      width: size,
                      height: size,
                      //color: AppColors.Gray,
                    ))
                  : ClipOval(
                      child: Image.network(
                      userImage,
                      fit: BoxFit.cover,
                      width: size,
                      height: size,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      },
                      //color: AppColors.Gray,
                    ))
              : Container(
                  width: size,
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                        color: AppColors.Gray, shape: BoxShape.circle),
                  ),
                ),
        ),
      ),
    );
  }
}
