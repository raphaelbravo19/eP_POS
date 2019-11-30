import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/widgets/texts/text_blue.dart';
import 'package:flutter/material.dart';

class ItemAdd extends StatelessWidget {
  final double scale;
  final bool tablet;
  ItemAdd({this.scale = 0, this.tablet = false});
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
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.symmetric(horizontal: scale),
              child: Container(
                child: Image.asset(
                  "assets/packages/plusicon.png",
                  height: scale * 2,
                  width: scale * 2,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          Expanded(
            flex: 1,
            child: Container(
                padding: EdgeInsets.all(scale * 0.4),
                alignment: Alignment.topCenter,
                child: TextBlue(
                  textAlign: TextAlign.center,
                  title: "Add Product",
                  fontSize: scale * 1.5,
                  fontWeight: tablet ? FontWeight.w700 : FontWeight.w700,
                )),
          ),
        ],
      ),
    );
  }
}
