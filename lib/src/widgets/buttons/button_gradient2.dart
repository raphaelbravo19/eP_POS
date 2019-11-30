import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:flutter/material.dart';

class ButtonGradient extends StatelessWidget {
  final double paddingVertical;
  final double paddingHorizontal;
  final double fontSize;
  final double borderRadius;
  final double letterSpacing;
  final FontWeight fontWeight;
  final bool filled;
  final String title;
  final Function callback;
  final Color textColor;
  final bool disabled;
  final Color fillColor;
  final Color primaryColor;
  final Color secondaryColor;
  final bool darkShadow;
  final double shadowLevel;
  ButtonGradient(
      {this.fontWeight = FontWeight.w600,
      this.paddingHorizontal = 0,
      this.letterSpacing = 1,
      this.paddingVertical = 0,
      this.fontSize,
      this.borderRadius = 0,
      this.title,
      this.callback,
      this.filled = false,
      this.disabled = false,
      this.textColor,
      this.darkShadow = false,
      this.shadowLevel = 3,
      this.fillColor,
      this.primaryColor,
      this.secondaryColor});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: callback,
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 0),
          padding: EdgeInsets.symmetric(
              vertical: paddingVertical, horizontal: paddingHorizontal),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: fontSize,
                  color: textColor != null
                      ? disabled ? AppColors.DarkGray : textColor
                      : disabled ? AppColors.DarkGray : AppColors.PrimaryWhite,
                  fontWeight: fontWeight,
                  letterSpacing: letterSpacing),
            ),
          ),
          decoration: BoxDecoration(
            boxShadow: [
              new BoxShadow(
                  color:
                      darkShadow ? Colors.black.withOpacity(0.7) : Colors.grey,
                  offset: new Offset(shadowLevel, shadowLevel),
                  blurRadius: shadowLevel * 5 / 3)
            ],
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              // Add one stop for each color. Stops should increase from 0 to 1
              colors: primaryColor != null && secondaryColor != null
                  ? [primaryColor, secondaryColor]
                  : fillColor != null
                      ? disabled
                          ? [AppColors.Gray, AppColors.Gray]
                          : [fillColor, fillColor]
                      : [
                          // Colors are easy thanks to Flutter's Colors class.
                          disabled ? AppColors.Gray : AppColors.PrimaryBlue,
                          disabled
                              ? AppColors.Gray
                              : filled
                                  ? AppColors.PrimaryBlue
                                  : AppColors.SecondBlue,
                        ],
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
          ),
        ));
  }
}
