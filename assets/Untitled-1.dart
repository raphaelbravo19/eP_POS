import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:flutter/material.dart';

class EpaisaButton extends StatelessWidget {
  final double height;
  final String title;
  final Color leftColor;
  final Color rightColor;
  final Color textColor;
  final Border border;
  final Function onPress;
  final BorderRadius borderRadius;
  final Widget leftIcon;
  EpaisaButton({
    @required this.height,
    @required this.title,
    this.leftColor = AppColors.PrimaryBlue,
    this.rightColor = AppColors.SecondBlue,
    this.textColor,
    this.border,
    this.borderRadius,
    this.leftIcon,
    @required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    final Function hp = ScreenUtils.of(context).hp;
    final Function wp = ScreenUtils.of(context).wp;
    final bool isTablet = ScreenUtils.of(context).isTablet;

    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: new Offset(2.0, 2.0),
                blurRadius: 1.5,
              )
            ],
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              // Add one stop for each color. Stops should increase from 0 to 1
              colors: [
                // Colors are easy thanks to Flutter's Colors class.
                (leftColor != null) ? leftColor : AppColors.PrimaryBlue,
                (rightColor != null) ? rightColor : AppColors.SecondBlue,
              ],
            ),
            borderRadius: borderRadius != null
                ? borderRadius
                : BorderRadius.all(
                    Radius.circular(isTablet ? hp(height) : wp(height)),
                  ),
            border: border != null ? border : null),
        height: isTablet ? hp(height) : wp(height * 2),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (leftIcon != null) leftIcon,
            FittedBox(
              child: Text(
                title,
                style: TextStyle(
                  color: textColor != null ? textColor : Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: isTablet ? hp(height * 0.3) : wp(height * 0.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static big({@required title, leftColor, rightColor, @required onPress}) {
    return EpaisaButton(
      height: 6.5,
      title: title,
      leftColor: leftColor,
      rightColor: rightColor,
      onPress: onPress,
    );
  }

  static medium({
    @required title,
    @required onPress,
    leftColor,
    rightColor,
    BorderRadius borderRadius,
  }) {
    return EpaisaButton(
      height: 5.5,
      title: title,
      leftColor: leftColor,
      rightColor: rightColor,
      onPress: onPress,
      borderRadius: borderRadius,
    );
  }

  static withBorder({
    @required title,
    @required borderColor,
    @required onPress,
    borderRadius,
    leftIcon,
  }) {
    return EpaisaButton(
      leftIcon: leftIcon,
      borderRadius: borderRadius,
      height: 5.5,
      title: title,
      leftColor: Colors.white,
      rightColor: Colors.white,
      textColor: borderColor,
      border: Border.all(
        color: borderColor,
        width: 1,
      ),
      onPress: onPress,
    );
  }
}
