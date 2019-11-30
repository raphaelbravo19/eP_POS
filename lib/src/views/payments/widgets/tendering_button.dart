import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/buttons/epaisa_button.dart';
import 'package:flutter/material.dart';

class TenderingButton extends StatelessWidget {
  final String title;
  final Color buttonColor;
  final Color iconColor;
  final Widget iconLeft;
  final Widget iconRight;
  final Function onTap;
  final Function iconLeftTap;
  const TenderingButton({
    this.buttonColor,
    this.title,
    this.iconColor,
    this.iconLeft,
    this.iconRight,
    this.onTap,
    this.iconLeftTap,
  });

  @override
  Widget build(BuildContext context) {
    final hp = ScreenUtils.of(context).hp;
    final wp = ScreenUtils.of(context).wp;
    final tablet = ScreenUtils.of(context).isTablet;
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Container(
          child: ButtonGradient(
            callback: onTap,
            title: title,
            primaryColor: buttonColor,
            secondaryColor: buttonColor,
            borderRadius: hp(5),
            fontSize: tablet?hp(2.3):wp(4.5),
            // tablet: tablet,
            // fontSize: tablet ? hp(2.2) : wp(3.6),
          ),
        ),
        if (iconLeft != null)
          Positioned(
            top: tablet ? -hp(1.2) : -wp(1.8),
            left: tablet ? -hp(1) : -wp(1.2),
            child: GestureDetector(
              onTap: iconLeftTap,
              child: CornerButton(
                child: iconLeft,
                color: iconColor,
              ),
            ),
          ),
        if (iconRight != null)
          Positioned(
            top: tablet ? -hp(1.2) : -wp(1.8),
            right: tablet ? -hp(1) : -wp(1.2),
            child: CornerButton(
              color: iconColor,
              child: iconRight,
            ),
          )
      ],
    );
  }
}

class CornerButton extends StatelessWidget {
  final Color color;
  final Widget child;

  const CornerButton({
    Key key,
    this.color,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final tablet = ScreenUtils.of(context).isTablet;
    final hp = ScreenUtils.of(context).hp;
    final wp = ScreenUtils.of(context).wp;
    return Container(
      height: tablet ? hp(3.6) : wp(6.5),
      width: tablet ? hp(3.6) : wp(6.5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black87,
            offset: Offset.fromDirection(45),
            blurRadius: 1.2,
          )
        ],
      ),
      padding: EdgeInsets.all(2),
      child: child,
    );
  }
}
