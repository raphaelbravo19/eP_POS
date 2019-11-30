import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/promotions/screens/add_promotion_screen/widgets/promotion_info.dart';
import 'package:epaisa_pos/src/views/promotions/screens/add_promotion_screen/widgets/promotion_types.dart';
import 'package:epaisa_pos/src/views/promotions/screens/add_promotion_screen/widgets/promotion_values.dart';
import 'package:flutter/material.dart';

class AddPromotionInfoContent extends StatelessWidget {
  final bool portraitMode;
  AddPromotionInfoContent({this.portraitMode = false});
  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    double fontSize = tablet ? hp(2.8) : wp(4);
    double separator = tablet ? hp(0.5) : hp(1);

    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            padding: tablet ? EdgeInsets.only(top: hp(1)) : EdgeInsets.all(0),
            child: Column(
              children: <Widget>[
                PromotionInfo(
                  tablet: tablet,
                  hp: hp,
                  wp: wp,
                  fontSize: fontSize,
                  separator: separator,
                ),
                PromotionTypes(hp: hp, tablet: tablet),
                PromotionValues(hp: hp, tablet: tablet),
              ],
            ),
          ),
        ),
      ],
    ) //ListView(children: <Widget>[],)
        ;
  }
}
