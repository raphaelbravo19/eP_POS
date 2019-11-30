import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:flutter/material.dart';

class TextBlue extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  TextBlue(
      {this.title,
      this.fontSize,
      this.fontWeight = FontWeight.w600,
      this.textAlign});
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: AppColors.PrimaryBlue),
    );
  }
}
