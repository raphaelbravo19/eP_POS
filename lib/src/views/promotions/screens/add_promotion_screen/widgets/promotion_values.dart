import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/widgets/epaisa/epaisa_arrow_card.dart';
import 'package:epaisa_pos/src/widgets/epaisa/epaisa_card_edit.dart';
import 'package:epaisa_pos/src/widgets/general/check_with_label.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_tax_classic.dart';
import 'package:flutter/material.dart';

class PromotionValues extends StatelessWidget {
  const PromotionValues({
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
              'VALUE',
              style: TextStyle(
                fontSize: tablet ? hp(2.3) : wp(4),
                fontWeight: FontWeight.bold,
                color: AppColors.BackPrimaryGray,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: hp(0.5),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: hp(3)),
                  child: TextfieldTaxClassic(
                    paddingBottomInput: hp(1),
                    fontSize: tablet ? hp(2.5) : wp(4),
                    labelText: "Discount Value",
                    flexLeft: 20,
                    flexRight: 80,
                  ),
                ),
                CheckWithLabel(
                  hp: hp,
                  tablet: tablet,
                  checked: false,
                  label: 'Entire Order',
                ),
                CheckWithLabel(
                  hp: hp,
                  tablet: tablet,
                  checked: false,
                  label: 'Specific Products',
                  margin: EdgeInsets.only(bottom: hp(1)),
                ),
                EpaisaArrowCard(
                  fontSize: tablet ? hp(2.2) : wp(3.6),
                  paddingHorizontal: hp(2.4),
                  paddingVertical: tablet ? hp(2) : wp(2.4),
                  description: "Select the Products",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
