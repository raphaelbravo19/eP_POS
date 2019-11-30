import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:flutter/material.dart';

class StackNumber extends StatelessWidget {
  final int number;
  final double size;
  final Color color;
  StackNumber({this.number, this.color = AppColors.DarkWhite, this.size = 10});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.center,
          children: <Widget>[
            Image.asset(
              "assets/header/stack.png",
              height: size,
              width: size,
            ),
            Container(
              alignment: Alignment.topLeft,
              height: size,
              width: size,
              child: Container(
                height: size * 0.75,
                width: size * 0.88,
                padding: EdgeInsets.all(size * (number > 9 ? 0.08 : 0.08)),
                child: FittedBox(
                  child: Text(
                    number.toString(),
                    style: TextStyle(
                      color: AppColors.DarkWhite,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
