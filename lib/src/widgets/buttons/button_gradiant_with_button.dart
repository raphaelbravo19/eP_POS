import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:flutter/material.dart';

class ButtonGradiantWithArrowIcon extends StatelessWidget {
  final double height, width;
  final String text;
  final VoidCallback onPressed;
  final Color primaryColor;
  final Color secondaryColor;
  final Color textColor;

  ButtonGradiantWithArrowIcon(this.height, this.width, this.text,
      {this.onPressed,
      this.primaryColor = AppColors.PrimaryBlue,
      this.secondaryColor = AppColors.SecondBlue,
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
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
            Radius.circular(50),
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                text,
                style: TextStyle(
                    fontSize: 13,
                    color: textColor,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 15,
              ),
            ],
          ),
          /*child: */
        ),
      ),
    );
  }
}
