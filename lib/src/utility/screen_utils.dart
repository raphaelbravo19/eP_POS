import 'dart:io';
import 'dart:math';

import 'package:epaisa_pos/src/widgets/dialogs/dialog_with_close.dart';
import 'package:flutter/material.dart';

export 'package:epaisa_pos/src/utility/multilanguage.dart';

double deviceHeight = 0.0;
bool isIOS;
bool tablet;
var hp;
var wp;

class ScreenUtils {
  Size screenSize;

  ScreenUtils(this.screenSize) {
    deviceHeight = screenSize.height;
  }

  double wp(percentage) {
    double result = (percentage * screenSize.width) / 100;
    return result;
  }

  double hp(percentage) {
    double result = (percentage * deviceHeight) / 100;
    return result;
  }

  showCustomDialog(String message, BuildContext context) {
    // flutter defined function

    Navigator.of(context).push(new PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return DialogWithClose(
          message: message,
        );
      },
    ));
  }

  static ResponsiveScreen of(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final insetBottom = MediaQuery.of(context).padding.bottom;
    final insetTop = MediaQuery.of(context).padding.top;
    final windowHeight = height - insetBottom - insetTop;
    final Function hp = (percentage) {
      return (percentage * windowHeight) / 100;
    };

    final Function wp = (percentage) {
      double result = (percentage * width) / 100;
      return result;
    };

    // IS TABLET
    var diagonal = sqrt((width * width) + (height * height));

    var isTablet = diagonal > 1100.0;

    var isIOS = Platform.isIOS;

    return ResponsiveScreen(
      hp: hp,
      wp: wp,
      isTablet: isTablet,
      isIOS: isIOS,
    );
  }
}

class ResponsiveScreen {
  final Function hp;
  final Function wp;
  final bool isTablet;
  final bool isIOS;
  ResponsiveScreen({
    this.hp,
    this.wp,
    this.isTablet,
    this.isIOS,
  });
}
