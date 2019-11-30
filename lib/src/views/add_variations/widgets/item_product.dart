import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:flutter/material.dart';

class ItemProduct extends StatelessWidget {
  final double scale;
  final bool tablet;
  ItemProduct({this.scale = 0, this.tablet = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2),
      decoration: BoxDecoration(
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
            flex: 8,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: scale),
              child: Container(
                child: Image.asset(
                  'assets/manufacturerscreen/cocacola.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
                padding: EdgeInsets.all(scale * 0.4),
                alignment: Alignment.topLeft,
                child: Text("LOTTE INTERNATIONAL",
                    style: TextStyle(
                        fontSize: scale * 0.9,
                        fontWeight: tablet ? FontWeight.w600 : FontWeight.w700,
                        color: AppColors.DisabledText))),
          ),
        ],
      ),
    );
  }
}
