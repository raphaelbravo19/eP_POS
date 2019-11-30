import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:flutter/material.dart';

class ButtonBorder extends StatelessWidget {
  final double paddingVertical;
  final double fontSize;
  final double borderRadius;
  final double borderWidth;
  final Color borderColor;
  final String title;
  final Function callback;
  final double elevation;
  final FontWeight fontWeight;
  final String shadowDirection;
  final Color textColor;
  ButtonBorder(
      {this.paddingVertical = 0,
      this.fontSize = 5,
      this.borderRadius = 0,
      this.title,
      this.borderColor = AppColors.PrimaryBlue,
      this.callback,
      this.borderWidth = 1.5,
      this.elevation = 2.0,
      this.fontWeight = FontWeight.w600,
      this.shadowDirection = "",
      this.textColor = AppColors.PrimaryBlue});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 0),
        padding: EdgeInsets.symmetric(
          vertical: paddingVertical,
        ),
        decoration: new BoxDecoration(
          color: AppColors.PrimaryWhite,
          boxShadow: [
            if (elevation != 0)
              BoxShadow(
                  color: Colors.grey,
                  offset: new Offset(
                      shadowDirection == "down" ? 0 : elevation, elevation),
                  blurRadius: elevation + 1)
          ],
          borderRadius: BorderRadius.circular(borderRadius),
          border: new Border.all(width: borderWidth, color: borderColor),
        ),
        child: Center(
            child: Text(
          title,
          style: TextStyle(
              fontSize: fontSize,
              color: textColor,
              fontWeight: this.fontWeight,
              letterSpacing: 1),
        )),
      ),
    );
  }
}
