import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:flutter/material.dart';

class ButtonColor extends StatelessWidget {
  final double paddingVertical;
  final double paddingHorizontal;
  final double fontSize;
  final double borderRadius;
  final double letterSpacing;
  final FontWeight fontWeight;
  final Color primary;
  final Color secondary;
  final Color textColor;
  final String title;
  final Function callback;

  ButtonColor({
    this.fontWeight = FontWeight.w600,
    this.letterSpacing = 1,
    this.paddingVertical = 0,
    this.paddingHorizontal = 0,
    this.fontSize,
    this.borderRadius = 0,
    this.title,
    this.primary = AppColors.PrimaryBlue,
    this.secondary = AppColors.PrimaryBlue,
    this.textColor = AppColors.PrimaryWhite,
    this.callback,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: callback,
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 0),
          padding: EdgeInsets.symmetric(
              vertical: paddingVertical, horizontal: paddingHorizontal),
          child: Text(
            title,
            style: TextStyle(
                fontSize: fontSize,
                color: textColor,
                fontWeight: fontWeight,
                letterSpacing: letterSpacing),
          ),
          decoration: BoxDecoration(
            boxShadow: [
              new BoxShadow(
                  color: Colors.grey,
                  offset: new Offset(3.0, 3.0),
                  blurRadius: 5.0)
            ],
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              // Add one stop for each color. Stops should increase from 0 to 1
              colors: [
                // Colors are easy thanks to Flutter's Colors class.
                primary,
                secondary,
              ],
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
          ),
        ));
  }
}
