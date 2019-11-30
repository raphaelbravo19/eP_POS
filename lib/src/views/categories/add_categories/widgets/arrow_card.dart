import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:flutter/material.dart';

class ArrowCard extends StatelessWidget {
  final String description;
  final double paddingVertical;
  final double paddingHorizontal;
  final double fontSize;
  final double letterSpacing;
  ArrowCard(
      {this.description,
      this.letterSpacing,
      this.paddingHorizontal,
      this.paddingVertical,
      this.fontSize});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal, vertical: paddingVertical),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              description,
              style: TextStyle(
                  color: AppColors.DarkGray,
                  fontWeight: FontWeight.w700,
                  fontSize: fontSize,
                  letterSpacing: letterSpacing),
            ),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
