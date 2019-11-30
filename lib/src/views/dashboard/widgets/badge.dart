import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final bool isTablet;

  Badge(
      {this.text,
      this.backgroundColor,
      this.textColor = Colors.white,
      this.isTablet = false});
  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      width:
          isTablet ? backgroundColor != Colors.green ? wp(9) : wp(7) : wp(15),
      height: isTablet ? hp(3.6) : 16,
      padding: EdgeInsets.all(4),
      child: isTablet
          ? Center(
              child: Text(
                text,
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: isTablet ? wp(1) : hp(1.5)),
              ),
            )
          : FittedBox(
              child: Text(
                text,
                style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
              ),
            ),
    );
  }
}
