import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/widgets/dialogs/dialog_positioned.dart';
import 'package:flutter/material.dart';

class PaymentMethodButton extends StatelessWidget {
  final String title;
  final String paymentName;
  final bool isLast;
  final double size;
  final double marginRight;
  final double fontSize;
  final FontWeight fontWeight;
  final Function onPress;
  final bool dropdown;
  final double spacing;
  const PaymentMethodButton(
      {Key key,
      this.title,
      @required this.paymentName,
      this.isLast = false,
      this.size = 70,
      this.marginRight = 0,
      @required this.fontSize,
      this.fontWeight,
      this.dropdown = false,
      @required this.onPress,
      this.spacing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(right: marginRight),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/payments/icons/${paymentName}_main.png',
              width: size * 0.9,
            ),
            if (spacing != null) SizedBox(height: spacing),
            if (title != null)
              Container(
                height: fontSize * 1.2,
                margin: EdgeInsets.only(right: 0),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    title,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight:
                          fontWeight != null ? fontWeight : FontWeight.w600,
                      color: AppColors.BackPrimaryGray,
                      fontSize: fontSize,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
