import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:flutter/material.dart';

class ItemProductRow extends StatelessWidget {
  final double scale;
  final bool tablet;
  final EdgeInsets margin;
  final BorderRadius borderRadius;
  final int selectedCount;
  ItemProductRow({
    this.scale = 0,
    this.tablet = false,
    this.margin,
    this.borderRadius,
    this.selectedCount = 0,
  });
  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    return Container(
        margin:
            margin != null ? margin : EdgeInsets.only(top: hp(1), left: wp(1)),
        padding: EdgeInsets.symmetric(vertical: hp(2)),
        decoration: BoxDecoration(
          borderRadius: borderRadius != null
              ? borderRadius
              : BorderRadius.circular(scale * 0.3),
          color: AppColors.PrimaryWhite,
          boxShadow: [
            new BoxShadow(
                color: AppColors.DarkGray.withOpacity(tablet ? 0.6 : 0.8),
                offset: new Offset(0.6, 1.0),
                blurRadius: 1.0)
          ],
        ),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: wp(3)),
              width: wp(20),
              child: Image.asset(
                'assets/manufacturerscreen/cocacola.png',
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(0),
                    child: Text(
                      "PARLE MARIE GOLD",
                      style: TextStyle(
                          color: AppColors.DarkGray,
                          fontWeight: FontWeight.w600,
                          fontSize: hp(1.5),
                          letterSpacing: 0.2),
                    )),
                Padding(
                    padding: EdgeInsets.only(top: hp(0.5)),
                    child: Text("${multilang.get('in_stock')}: 33",
                        style: TextStyle(
                            color: AppColors.DisabledText,
                            fontWeight: FontWeight.w600,
                            fontSize: hp(1.35),
                            letterSpacing: 0.2))),
              ],
            )),
            Container(
                padding: EdgeInsets.only(right: hp(1.5)),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          selectedCount > 0
                              ? 'x$selectedCount.00 Pcs'
                              : "₹ 100.00", //list[index],
                          style: TextStyle(
                              color: selectedCount > 0
                                  ? Color(0xFF417505)
                                  : AppColors.DarkGray,
                              fontWeight: FontWeight.w700,
                              fontSize: hp(2.1),
                              letterSpacing: 0.5),
                        )),
                  ],
                )),
          ],
        ));
  }
}
