import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';

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
  final double fontSize;
  final TextStyle textStyle;
  EpaisaButton({
    @required this.height,
    @required this.title,
    this.leftColor = AppColors.PrimaryBlue,
    this.rightColor = AppColors.SecondBlue,
    this.textColor,
    this.border,
    this.borderRadius,
    this.leftIcon,
    this.fontSize,
    this.textStyle,
    @required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    final bool tablet = ScreenUtils.of(context).isTablet;
    final Function hp = ScreenUtils.of(context).hp;
    final Function wp = ScreenUtils.of(context).wp;

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
                    Radius.circular(tablet ? hp(height) : wp(height)),
                  ),
            border: border != null ? border : null),
        height: tablet ? hp(height) : wp(height * 2),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (leftIcon != null) leftIcon,
            FittedBox(
              child: Text(
                title,
                style: textStyle ??
                    (TextStyle(
                      color: textColor != null ? textColor : Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: fontSize ??
                          (tablet ? hp(height * 0.3) : wp(height * 0.6)),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static big({
    @required title,
    leftColor,
    rightColor,
    @required onPress,
    BorderRadius borderRadius,
  }) {
    return EpaisaButton(
      height: tablet ? 7.5 : 6.5,
      title: title,
      leftColor: leftColor,
      rightColor: rightColor,
      onPress: onPress,
      borderRadius: borderRadius,
    );
  }

  static medium({
    @required title,
    @required onPress,
    tablet = false,
    fontSize,
    leftColor,
    rightColor,
    textColor,
    BorderRadius borderRadius,
  }) {
    return EpaisaButton(
      height: tablet ? 6 : 5.5,
      title: title,
      leftColor: leftColor,
      rightColor: rightColor,
      textColor: textColor,
      onPress: onPress,
      fontSize: fontSize,
      borderRadius: borderRadius,
    );
  }

  static withBorder(
      {@required String title,
      @required Color borderColor,
      @required Function onPress,
      BorderRadius borderRadius,
      Widget leftIcon,
      fontSize,
      TextStyle textStyle}) {
    return EpaisaButton(
      textStyle: textStyle,
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
      fontSize: fontSize,
      onPress: onPress,
    );
  }
}
