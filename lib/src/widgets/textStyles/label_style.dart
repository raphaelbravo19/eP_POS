import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:flutter/material.dart';

class LabelStyle {
  static labelStyleGrey({double fontSize, FontWeight fontWeight}) {
    return TextStyle(
        fontSize: fontSize ?? null,
        color: AppColors.DisabledText,
        fontFamily: 'Montserrat',
        fontWeight: fontWeight ?? FontWeight.w700);
  }
}
