import 'dart:io';

import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class EpaisaScaffold extends StatelessWidget {
  final Widget body;
  final bool noImage;
  final Widget appBar;
  final Color bottomColor;
  final bool noSafe;
  final bool white;
  EpaisaScaffold(
      {this.noSafe = false,
      this.body,
      this.appBar,
      this.white = false,
      this.noImage = false,
      this.bottomColor});
  @override
  Widget build(BuildContext context) {
    final tablet = isTablet(MediaQuery.of(context));
    var isIOS = Platform.isIOS;
    var bgImage = AssetImage(
        "assets/splashscreen/background${tablet ? "_landscape" : ""}.png");
    Widget _buildContent() {
      return Scaffold(
        //appBar: appBar,
        backgroundColor: white? Colors.white : noImage ? AppColors.PrimaryWhite : AppColors.PrimaryWhite,
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: noImage
                ? null
                : DecorationImage(
                    image: bgImage,
                    fit: BoxFit.fill,
                  ),
          ),
          child: Column(
            verticalDirection: VerticalDirection.up,
            children: <Widget>[
              Expanded(child: body),
              appBar ?? Container(),
            ],
          ),
        ),
      );
    }

    if (!isIOS) {
      return _buildContent();
    } else {
      return Container(
          child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: AppColors.PrimaryBlue,
                ),
              ),
              Expanded(
                child: Container(
                  color: bottomColor ?? AppColors.PrimaryWhite,
                ),
              )
            ],
          ),
          noSafe
              ? _buildContent()
              : SafeArea(bottom: bottomColor != null, child: _buildContent()),
        ],
      ));
    }
  }
}
