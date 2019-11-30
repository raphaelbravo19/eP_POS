import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:flutter/material.dart';

class ItemCategory extends StatelessWidget {
  final double scale;
  final bool tablet;
  final Color color;
  Function onTap;
  final String text;
  ItemCategory(
      {this.scale = 0,
      this.tablet = false,
      this.color,
      this.text = "",
      this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null ? () => onTap() : () {},
      child: Container(
        margin: EdgeInsets.only(top: 2),
        decoration: BoxDecoration(
          border: Border.all(
              color: color != null ? color : baseColors[0], width: 1.5),
          borderRadius: BorderRadius.circular(scale * 0.3),
          color: AppColors.PrimaryWhite,
          boxShadow: [
            new BoxShadow(
                color: AppColors.DarkGray.withOpacity(tablet ? 0.6 : 0.8),
                offset: new Offset(0.6, 1.0),
                blurRadius: 1.0)
          ],
        ),
        child: Column(
          children: <Widget>[
            Expanded(
                child: Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(
                        scale * 0.4,
                        tablet ? scale * 1.5 : scale * 0.7,
                        scale * 2,
                        scale * 0.7),
                    alignment: Alignment.topLeft,
                    child: Text(text != "" ? text : "Fruits & Vegetables",
                        style: TextStyle(
                            fontSize: tablet ? scale * 1.1 : scale * 0.9,
                            fontWeight:
                                tablet ? FontWeight.w800 : FontWeight.w700,
                            color: AppColors.DisabledText))),
                Positioned(
                  right: scale * 0.3,
                  bottom: scale * 0.3,
                  child: Container(
                    alignment: Alignment.center,
                    height: scale * 1.8,
                    width: scale * 1.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(scale * 0.3),
                        border:
                            Border.all(color: AppColors.LightGray, width: 0.9)),
                    child: Text(
                      '12',
                      style: TextStyle(
                          fontSize: tablet ? scale * 0.9 : scale * 0.85,
                          fontWeight:
                              tablet ? FontWeight.w600 : FontWeight.w700,
                          color: AppColors.DisabledText),
                    ),
                  ),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
