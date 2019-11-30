import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:flutter/material.dart';

class MediumBoldWhiteText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  MediumBoldWhiteText(this.text, {this.textStyle});

  Widget build(context) {
    return new Text(
      text,
      style: this.textStyle != null
          ? this.textStyle
          : TextStyle(
              fontSize: ScreenUtils(MediaQuery.of(context).size).hp(2.0),
              color: Colors.white,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold),
    );
  }
}
