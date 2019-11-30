import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/promotions/screens/add_promotion_screen/widgets/promotion_customer_elegibility.dart';
import 'package:epaisa_pos/src/views/promotions/screens/add_promotion_screen/widgets/promotion_info.dart';
import 'package:epaisa_pos/src/views/promotions/screens/add_promotion_screen/widgets/promotion_minimum_requeriments.dart';
import 'package:epaisa_pos/src/views/promotions/screens/add_promotion_screen/widgets/promotion_types.dart';
import 'package:epaisa_pos/src/views/promotions/screens/add_promotion_screen/widgets/promotion_usage_limits.dart';
import 'package:epaisa_pos/src/views/promotions/screens/add_promotion_screen/widgets/promotion_values.dart';
import 'package:flutter/material.dart';

class AddPromotionRequerimentsContent extends StatelessWidget {
  final bool portraitMode;
  AddPromotionRequerimentsContent({this.portraitMode = false});
  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    double fontSize = tablet ? hp(2.8) : hp(2.20);
    double separator = tablet ? hp(0.5) : hp(1);

    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            padding: tablet ? EdgeInsets.only(top: hp(1)) : EdgeInsets.all(0),
            child: Column(
              children: <Widget>[
                PromotionMinimumRequeriments(hp: hp, tablet: tablet),
                PromotionCustomerElegibility(hp: hp, tablet: tablet),
                PromotionUsageLimits(hp: hp, tablet: tablet),
              ],
            ),
          ),
        )
      ],
    ) //ListView(children: <Widget>[],)
        ;
  }
}
