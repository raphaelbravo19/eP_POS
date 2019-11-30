import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:flutter/material.dart';

class CartNumber extends StatelessWidget {
  final int number;
  final double size;
  final Color color;
  CartNumber({this.number, this.color = AppColors.DarkWhite, this.size = 10});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.center,
          children: <Widget>[
            Icon(
              Icons.shopping_cart,
              color: color,
              size: size,
            ),
            Positioned(
              //right: 0,
              top: -size * 0.2,
              child: Container(
                alignment: Alignment.centerRight,
                height: size * 0.53,
                width: size * 1.3,
                child: Container(
                  height: size * 0.53,
                  width: size * 0.53,
                  padding: EdgeInsets.all(size * (number > 9 ? 0.06 : 0.03)),
                  child: FittedBox(
                    //fit: BoxFit.fitWidth,
                    child: Text(
                      '$number',
                      style: TextStyle(
                        color: AppColors.DarkWhite,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: AppColors.TextGray, shape: BoxShape.circle),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
