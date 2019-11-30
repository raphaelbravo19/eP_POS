import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final String hintText;
  final double fontSize;
  final double paddingHorizontal;
  final FontWeight fontWeight;

  TextFieldContainer(
      {this.paddingHorizontal = 0,
      this.hintText = '',
      this.fontSize,
      this.fontWeight = FontWeight.w500});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
      decoration: BoxDecoration(
        //color: Colors.white,
        border: Border.all(
            color: Colors.black.withOpacity(0.1),
            width: 1.0,
            style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(9),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            offset: const Offset(0.0, 0.0),
          ),
          BoxShadow(
            color: Colors.white,
            offset: const Offset(1, 1),
            spreadRadius: -1.0,
            blurRadius: 2.0,
          ),
        ],
        /*image: new DecorationImage(
            image: new AssetImage('assets/images/JL-Logo-150.png'),
          )*/
      ),
      child: TextField(
        style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: AppColors.TextGray),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(
                fontSize: fontSize * 0.85,
                fontWeight: fontWeight,
                color: AppColors.DisabledText.withOpacity(0.7))),
      ),
    );
  }
}
