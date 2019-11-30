import 'dart:convert';
import 'dart:io';

import 'package:epaisa_pos/data/initial/countries/api_service.dart';
import 'package:epaisa_pos/src/bloc/bloc.dart';
import 'package:epaisa_pos/src/bloc/login_bloc.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/login/login_screen.dart';
import 'package:epaisa_pos/src/views/main_view/main_view_screen.dart';
import 'package:epaisa_pos/src/widgets/dialogs/loyalty.dart';
import 'package:epaisa_pos/src/widgets/dialogs/upgrade.dart';
import 'package:epaisa_pos/src/widgets/utils/dialogs_helper.dart';
import 'package:epaisa_pos/src/widgets/utils/request_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import './widgets/dashboard_dropdowns.dart';
import './widgets/dashboard_header.dart';
import './widgets/dashboard_icons_grid.dart';
import './widgets/notifications_icon.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({this.navigate});
  final Function navigate;

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  BuildContext context;
  BehaviorSubject<int> streamCompany = BehaviorSubject<int>();
  BehaviorSubject<String> streamCompanyId = BehaviorSubject<String>();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      logged();
    });
  }

  Future logged() async {
    var logged = await isLogged();

    if (logged) {
      try {
        var authkey = await getauthkey();

        var res = await ApiService.create().getCompany(authKey: authkey);
        print(res.body);
        //print(res.body);
      } catch (e) {
        print(e);
        if (e.body != null) {
          showDialogMessage(context, json.decode(e.body)["message"], () {
            /* if (!tablet)
              Navigator.pop(context);
            else if (callback != null) callback(); */
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    final bool tablet = isTablet(MediaQuery.of(context));
    final mediaQuery = MediaQuery.of(context);
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;

    final List<Map<String, dynamic>> items = [
      {
        'image': 'payment',
        'title': eptxt('quick_payment'),
        'lnbr': true,
        'lnbb': true,
        'psbr': true,
        'psbb': true,
        'size': 6.0,
        'tsize': 9.0,
        'onTap': () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MainViewScreen(
                    defaultIndex: 8,
                  )));
        }
      },
      {
        'image': 'billing',
        'title': eptxt('point_of_sale'),
        'lnbr': true,
        'lnbb': true,
        'psbr': false,
        'psbb': true,
        'size': 7.0,
        'tsize': 11.0,
        'badge': {
          'color': Colors.green,
          'text': eptxt('dashboard_upgrade').toUpperCase()
        },
        'onTap': () {
          Navigator.pushReplacement(
              // context, MaterialPageRoute(builder: (context) => LoginScreen()));
              context,
              MaterialPageRoute(builder: (context) => MainViewScreen()));
        }
      },
      {
        'image': 'inventory',
        'title': eptxt('inventory_management'),
        'lnbr': false,
        'lnbb': true,
        'psbr': true,
        'psbb': true,
        'size': 8.0,
        'tsize': 13.0,
        'badge': {
          'color': Colors.green,
          'text': eptxt('dashboard_upgrade').toUpperCase()
        },
        'onTap': () {
          _showDialog('upgrade');
        }
      },
      {
        'image': 'loyalty',
        'title': eptxt('loyalty'),
        'lnbr': true,
        'lnbb': true,
        'psbr': false,
        'psbb': true,
        'size': 6.0,
        'tsize': 9.0,
        'commingSoon': true,
        'badge': {
          'color': AppColors.DarkGray,
          'text': eptxt('dashboard_comming_soon').toUpperCase()
        },
        'onTap': () {
          _showDialog('loyalty');
        }
      },
      {
        'image': 'customer',
        'title': eptxt('customers'),
        'lnbr': true,
        'lnbb': true,
        'psbr': true,
        'psbb': true,
        'size': 6.0,
        'tsize': 9.0,
        'onTap': () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MainViewScreen(
                    defaultIndex: 9,
                  )));
        }
      },
      {
        'image': 'vas',
        'title': eptxt('vas'),
        'lnbr': false,
        'lnbb': true,
        'psbr': false,
        'psbb': true,
        'size': 8.0,
        'tsize': 11.0,
        'commingSoon': true,
        'badge': {
          'color': AppColors.DarkGray,
          'text': eptxt('dashboard_comming_soon').toUpperCase()
        },
        'onTap': () {}
      },
      {
        'image': 'analytics',
        'title': eptxt('analytics'),
        'lnbr': true,
        'lnbb': false,
        'psbr': true,
        'size': 7.0,
        'tsize': 10.5,
        'psbb': false,
        'onTap': () {},
      },
      {
        'image': 'profile',
        'title': eptxt('profile'),
        'lnbr': true,
        'lnbb': false,
        'psbr': false,
        'psbb': false,
        'size': 7.0,
        'tsize': 10.5,
        'onTap': () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MainViewScreen(
                    defaultIndex: 16,
                  )));
        },
      },
      {
        'image': 'settings',
        'title': eptxt('settings'),
        'size': 6.0,
        'tsize': 10.5,
        'lnbr': false,
        'lnbb': false,
        'psbr': false,
        'psbb': false,
        //'badge': {'color': Colors.grey, 'text': 'COMING SOON'},
        'onTap': () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MainViewScreen(
                    defaultIndex: 13,
                  )));
        }
      },
    ];

    var bgImage = AssetImage(
        "assets/splashscreen/background${tablet ? "_landscape" : ""}.png");

    // UserDao userdb = UserDao();
    // userdb.getAll().then((res) => {print(jsonEncode(res))});

    Widget _buildContent() {
      return Scaffold(
        backgroundColor: AppColors.PrimaryWhite,
        body: Container(
          padding: EdgeInsets.only(top: hp(2)),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: bgImage,
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        top: 8, right: 8, left: 8, bottom: tablet ? 0 : hp(1)),
                    child: DashboardHeader(
                      notificationsCount: 19,
                      streamCompany: streamCompany,
                      // userName: 'Abheer Kaushik | Partner',
                      // userImage: 'http://via.placeholder.com/100x100/',
                    ),
                  ),
                  DashboardDropdowns(
                      streamCompany: streamCompany,
                      streamCompanyId: streamCompanyId,
                      width: tablet ? wp(65) : wp(83),
                      isTablet: tablet),
                  Expanded(
                    child: Container(
                      width: tablet ? wp(70) : wp(83),
                      alignment: Alignment.topCenter,
                      child: DashboardIconsGrid(
                        items: items,
                        columns: tablet ? 3 : 4,
                        rows: tablet ? 3 : 2,
                        isTablet: tablet,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: tablet ? hp(3) : hp(5),
                  )
                ],
              ),
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(tablet ? 32 : 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MainViewScreen(
                                defaultIndex: 15,
                              ),
                            ),
                          );
                        },
                        child: NotificationsIcon(
                          count: 7,
                          isTablet: tablet,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          loginBloc.signOut();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: hp(1)),
                          child: Image.asset(
                            'assets/dashboard/exit.png',
                            width: tablet ? hp(5) : wp(9),
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
      );
    }

    bool isIOS = Platform.isIOS;
    if (isIOS) {
      return Scaffold(
        backgroundColor: AppColors.PrimaryWhite,
        body: SafeArea(
          child: _buildContent(),
        ),
      );
    } else {
      return WillPopScope(
        onWillPop: () async => false,
        child: _buildContent(),
      );
    }
  }

  void _showDialog(String type) {
    // flutter defined function
    Navigator.of(context).push(new PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        switch (type) {
          case 'loyalty':
            return LoyaltyDialog(
                title: eptxt('loyalty_title'), width: 85, height: 85);
          case 'upgrade':
            return UpgradeToPOS(
                title: eptxt('upgrade_title'), width: 85, height: 85);
        }
      },
    ));
  }
}
