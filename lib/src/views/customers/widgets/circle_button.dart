import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final double size;
  final String imagePath;
  final bool extraShadow;
  const CircleButton(
      {Key key, this.size = 30, this.imagePath = "", this.extraShadow = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(this.imagePath)),
        shape: BoxShape.circle,
        boxShadow: extraShadow
            ? [
                BoxShadow(
                  color: AppColors.BackPrimaryGray.withOpacity(0.8),
                  offset: new Offset(0.6, 1.2),
                  blurRadius: 1,
                )
              ]
            : [],
      ),
    );
  }
}
