import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:flutter/material.dart';

class UnderLine {
  static underLine() {
    return new UnderlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.DarkGray,
        width: 3.0,
      ),
    );
  }
}
