import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/widgets/epaisa/epaisa_card_edit.dart';
import 'package:epaisa_pos/src/widgets/general/check_with_label.dart';
import 'package:flutter/material.dart';

class PromotionTypes extends StatelessWidget {
  const PromotionTypes({
    Key key,
    @required this.hp,
    @required this.tablet,
  }) : super(key: key);

  final Function hp;
  final bool tablet;

  @override
  Widget build(BuildContext context) {
    final wp = ScreenUtils.of(context).wp;
    return EpaisaCardEdit(
      hp: hp,
      tablet: tablet,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: hp(2)),
            child: Text(
              'TYPES',
              style: TextStyle(
                fontSize: tablet ? hp(2.3) : wp(4),
                fontWeight: FontWeight.bold,
                color: AppColors.BackPrimaryGray,
              ),
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                CheckWithLabel(
                  radio: true,
                  hp: hp,
                  tablet: tablet,
                  checked: true,
                  label: 'Percentage (%)',
                ),
                CheckWithLabel(
                  hp: hp,
                  radio: true,
                  tablet: tablet,
                  checked: false,
                  label: 'Fixed Amount (₹)',
                ),
                CheckWithLabel(
                  hp: hp,
                  radio: true,
                  tablet: tablet,
                  checked: false,
                  label: 'Free Shipping',
                ),
                CheckWithLabel(
                  hp: hp,
                  radio: true,
                  tablet: tablet,
                  checked: false,
                  label: 'Buy X Get Y',
                  margin: EdgeInsets.all(0),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
