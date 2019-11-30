import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:flutter/material.dart';

class TextGray extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final double opacity;
  TextGray(
      {this.title,
      this.fontSize,
      this.fontWeight = FontWeight.w600,
      this.opacity = 1});
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: AppColors.DisabledText.withOpacity(opacity)),
    );
  }
}
