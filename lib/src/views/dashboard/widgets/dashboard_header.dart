import 'dart:io';

import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:epaisa_pos/data/models/currentcompanys_dao.dart';
import 'package:epaisa_pos/data/models/currentusers_dao.dart';
import 'package:epaisa_pos/helpers/user_merchant_package/user_lib.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import './notifications_icon.dart';

class DashboardHeader extends StatefulWidget {
  final int notificationsCount;
  final String userName;
  final String userImage;
  final BehaviorSubject<int> streamCompany;
  DashboardHeader(
      {this.notificationsCount,
      this.userName,
      this.userImage,
      this.streamCompany});

  @override
  _DashboardHeaderState createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends State<DashboardHeader> {
  var _username = 'User';
  var _userImage = 'http://via.placeholder.com/100x100/';

  @override
  void initState() {
    super.initState();
  }

  Future<List<CurrentCompany>> getCompanies() async {
    CurrentCompanysDao companyDao = CurrentCompanysDao(db);
    var companies = await companyDao.getAll();
    return companies;
  }

  @override
  Widget build(BuildContext context) {
    final tablet = isTablet(MediaQuery.of(context));
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    return Container(
      // decoration: BoxDecoration(color: Colors.blue),
      child: Container(
        padding: EdgeInsets.only(left: 40, right: 40),
        child: tablet
            ? Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FutureBuilder<List<CurrentCompany>>(
                          future: getCompanies(),
                          builder: (context, snapshot) {
                            if (snapshot.data != null) {
                              return StreamBuilder<int>(
                                  stream: widget.streamCompany,
                                  builder: (context, snap) {
                                    if (snap.data == null) {
                                      widget.streamCompany.sink.add(0);
                                    }
                                    if (snap.data != null) {
                                      return Picture(
                                          userImage:
                                              snapshot.data[snap.data].image);
                                    } else {
                                      return Picture(userImage: _userImage);
                                    }
                                  });
                            } else {
                              return Container();
                            }
                          }),
                      SizedBox(
                        width: hp(2),
                      ),
                      Username(
                        userName: _username,
                        isTablet: tablet,
                      ),
                    ],
                  ),
                  // Icon(
                  //   notificationsCount: notificationsCount,
                  //   isTablet: tablet,
                  // )
                ],
              )
            : Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      FutureBuilder<List<CurrentCompany>>(
                          future: getCompanies(),
                          builder: (context, snapshot) {
                            if (snapshot.data != null) {
                              return StreamBuilder<int>(
                                  stream: widget.streamCompany,
                                  builder: (context, snap) {
                                    if (snap.data == null) {
                                      widget.streamCompany.sink.add(0);
                                    }
                                    if (snap.data != null) {
                                      print(
                                          "IMAGE ${snapshot.data[snap.data]}");
                                      return Picture(
                                          userImage:
                                              snapshot.data[snap.data].image);
                                    } else {
                                      return Picture(userImage: _userImage);
                                    }
                                  });
                            } else {
                              return Picture(userImage: _userImage);
                            }
                          }),
                      // Icon(
                      //   notificationsCount: notificationsCount,
                      //   isTablet: tablet,
                      // )
                    ],
                  ),
                  Username(userName: _username),
                ],
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
    final double size = isTablet ? hp(9) : hp(7.5);
    return Container(
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.only(
            top: hp(1.5),
            bottom: isTablet ? hp(1.5) : hp(0.5),
            right: isTablet ? hp(2) : 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size),
          child: userImage != null
              ? userImage.indexOf("files") != -1 || userImage.indexOf("Application") != -1 
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

class Icon extends StatelessWidget {
  final int notificationsCount;
  final bool isTablet;
  Icon({
    @required this.notificationsCount,
    this.isTablet = false,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: NotificationsIcon(
        count: notificationsCount,
        isTablet: isTablet,
      ),
    );
  }
}

class Username extends StatelessWidget {
  final String userName;
  final bool isTablet;
  const Username({
    this.isTablet = false,
    @required this.userName,
  });

  Future<List<CurrentUser>> getUser() async {
    CurrentUsersDao userDao = CurrentUsersDao(db);
    var users = await userDao.getAll();
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: FutureBuilder<List<CurrentUser>>(
          future: getUser(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return Text(
                "${snapshot.data[0].firstName} ${snapshot.data[0].lastName} | Partner",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.BackPrimaryGray,
                  fontSize: isTablet ? 20 : 16,
                ),
              );
            } else {
              return Text(
                "",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.BackPrimaryGray,
                  fontSize: isTablet ? 20 : 16,
                ),
              );
            }
          }),
    );
  }
}
