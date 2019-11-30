import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:flutter/material.dart';

class ButtonGradiant extends StatelessWidget {
  final double height, width;
  final double fontSize;
  final String text;
  final VoidCallback onPressed;
  final Color primaryColor;
  final Color secondaryColor;
  final Color textColor;
  final TextStyle textStyle;
  double borderRadius;

  ButtonGradiant(this.height, this.width, this.text,
      {this.onPressed,
      this.primaryColor = AppColors.PrimaryBlue,
      this.secondaryColor = AppColors.SecondBlue,
      this.textColor = Colors.white,
      this.borderRadius = 50,
      this.textStyle,
      this.fontSize = 13});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: height),
        //height: height,

        width: width,

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
              primaryColor,
              secondaryColor,
            ],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: textStyle != null
                ? this.textStyle
                : TextStyle(
                    fontSize: fontSize,
                    color: textColor,
                    fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
