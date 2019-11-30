import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/promotions/screens/add_promotion_screen/widgets/promotion_dates_from_to.dart';
import 'package:epaisa_pos/src/widgets/buttons/epaisa_button.dart';
import 'package:flutter/material.dart';

class AddPromotionDatesContent extends StatelessWidget {
  final bool portraitMode;
  AddPromotionDatesContent({this.portraitMode = false});
  @override
  Widget build(BuildContext context) {
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SingleChildScrollView(
          padding: tablet ? EdgeInsets.only(top: hp(1)) : EdgeInsets.all(0),
          child: Column(
            children: <Widget>[
              PromotionDatesFromTo(hp: hp, tablet: tablet),
            ],
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: hp(3)),
              child: tablet
                  ? EpaisaButton.big(
                      onPress: () {},
                      title: 'ADD PROMOTION',
                      borderRadius: BorderRadius.circular(hp(1.8)),
                    )
                  : EpaisaButton.medium(
                      onPress: () {},
                      title: 'ADD PROMOTION',
                      borderRadius: BorderRadius.circular(hp(1.6)),
                    ),
            ),
            SizedBox(
              height: hp(2),
            )
          ],
        )
      ],
    ) //ListView(children: <Widget>[],)
        ;
  }
}
