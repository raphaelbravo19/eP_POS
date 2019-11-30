import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:flutter/material.dart';

class ItemProducts extends StatelessWidget {
  final double scale;

  final Color color;
  final Function onTap;
  final String text;
  final double price;
  final int quantity;
  final int gridLength;
  ItemProducts(
      {this.scale = 0,
      this.color,
      this.text = "",
      this.onTap,
      this.price = 25.0,
      this.quantity = 12,
      this.gridLength = 2});
  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    var tablet = isTablet(MediaQuery.of(context));
    var title = text != "" ? (text.toUpperCase()) : "Fruits & Vegetables";
    var maxLength =
        (((tablet ? wp(100) : wp(91)) / scale * 4) / gridLength).toInt() -
            (gridLength * 3);
    return GestureDetector(
      onTap: onTap != null ? () => onTap() : () {},
      child: Container(
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
              flex: 9,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: scale),
                    child: Container(
                      child: Image.asset(
                        'assets/manufacturerscreen/cocacola.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  /*Positioned(
                    left: scale * 0.1,
                    top: scale * 0.1,
                    child: Container(
                      alignment: Alignment.center,
                      height: tablet ? scale * 2.8 : scale * 2.3,
                      width: tablet ? scale * 2.8 : scale * 2.3,
                      padding: EdgeInsets.symmetric(
                          horizontal: scale * 0.1, vertical: scale * 0.4),
                      decoration: BoxDecoration(
                          color: AppColors.PrimaryBlue,
                          borderRadius: BorderRadius.circular(scale * 0.3),
                          border: Border.all(
                              color: AppColors.LightGray, width: 0.9)),
                      child: Image.asset(
                        "assets/leftdrawer/packages.png",
                        color: AppColors.DarkWhite.withOpacity(0.8),
                      ),
                    ),
                  )*/
                ],
              ),
            ),
            Expanded(
                flex: 4,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                              padding: EdgeInsets.fromLTRB(
                                  scale * 0.4,
                                  0, //tablet ? scale * 1.5 : scale * 0.7,
                                  scale * 0.2, //scale * 2,
                                  0),
                              alignment: Alignment.topLeft,
                              child: Text(
                                  title.length > maxLength
                                      ? title.substring(0, maxLength) + '...'
                                      : title,
                                  style: TextStyle(
                                      fontSize:
                                          tablet ? scale * 0.77 : scale * 0.725,
                                      fontWeight: tablet
                                          ? FontWeight.w600
                                          : FontWeight.w700,
                                      color: AppColors.DisabledText))),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              scale * 0.4,
                              0, //tablet ? scale * 1.5 : scale * 0.7,
                              scale * 0.2, //scale * 2,
                              scale * 0.2),
                          alignment: Alignment.centerLeft,
                          child: Text("₹ ${price.toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontSize:
                                      tablet ? scale * 0.75 : scale * 0.72,
                                  fontWeight: tablet
                                      ? FontWeight.w700
                                      : FontWeight.w700,
                                  color: AppColors.DisabledText)),
                        )
                      ],
                    ),
                    Positioned(
                      right: scale * 0.3,
                      bottom: scale * 0.3,
                      child: Container(
                        alignment: Alignment.center,
                        height: tablet ? scale * 1.7 : scale * 1.6,
                        padding: EdgeInsets.symmetric(
                            horizontal: scale * 0.08, vertical: scale * 0.28),
                        width: tablet ? scale * 1.7 : scale * 1.6,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(scale * 0.3),
                            border: Border.all(
                                color: quantity < 10
                                    ? AppColors.ErrorText
                                    : AppColors.LightGray,
                                width: 0.9)),
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            quantity.toString(),
                            style: TextStyle(
                                //fontSize: tablet ? scale * 0.9 : scale * 0.85,
                                fontWeight:
                                    tablet ? FontWeight.w600 : FontWeight.w800,
                                color: quantity < 10
                                    ? AppColors.ErrorText
                                    : AppColors.DisabledText),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
