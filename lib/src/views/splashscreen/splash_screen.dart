import 'dart:async';
import 'dart:io';

import 'package:epaisa_pos/src/bloc/login_bloc.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/dashboard/dashboard_screen.dart';
import 'package:epaisa_pos/src/views/magic_link/magic_link_screen.dart';
import 'package:epaisa_pos/src/views/main_view/main_view_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_responsive_screen/flutter_responsive_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({this.logged = false, this.magic});
  final logged;
  final magic;
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () async {
      if (ScreenUtils.of(context).isTablet) {
        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft
        ]);
      } else {
        await SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp]);
      }
      if (widget.magic != null) {
        await loginBloc.getDataWithMagic(
            context, widget.magic.replaceAll("epaisapos://", ""));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardScreen(),
          ),
        );
      } else if (widget.logged) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardScreen(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MagicLinkScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    tablet = isTablet(MediaQuery.of(context));
    hp = ScreenUtils.of(context).hp;
    wp = ScreenUtils.of(context).wp;
    isIOS = Platform.isIOS;
    //final Function wp = Screen(MediaQuery.of(context).size).wp;
    var logoWidth = tablet ? wp(30) : wp(50);

    var bgImage = AssetImage(
        "assets/splashscreen/background${tablet ? "_landscape" : ""}.png");

    return Scaffold(
      backgroundColor: AppColors.PrimaryWhite,
      body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: bgImage,
              fit: BoxFit.fill,
            ),
          ),
          child: Container(
            width: logoWidth,
            height: logoWidth * 50 / 165,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/splashscreen/epaisa_logo.png"),
                fit: BoxFit.fill,
              ),
            ),
          )),
    );
  }
}
