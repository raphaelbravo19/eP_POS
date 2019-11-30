import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:flutter/material.dart';

class BoldBlueText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  BoldBlueText(this.text, {this.textStyle});

  Widget build(context) {
    return new Text(
      text,
      style: this.textStyle != null
          ? this.textStyle
          : TextStyle(
              fontSize: ScreenUtils(MediaQuery.of(context).size).hp(1.8),
              color: AppColors.PrimaryBlue,
              fontWeight: FontWeight.w700),
    );
  }
}

class BoldBlueTextSpacing extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  BoldBlueTextSpacing(this.text, {this.textStyle});

  Widget build(context) {
    return new Text(
      text,
      style: this.textStyle != null
          ? this.textStyle
          : TextStyle(
              fontSize: ScreenUtils(MediaQuery.of(context).size).hp(1.6),
              color: AppColors.PrimaryBlue,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.33),
    );
  }
}
