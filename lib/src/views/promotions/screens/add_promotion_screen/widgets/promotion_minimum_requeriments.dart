import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart' as prefix0;
import 'package:epaisa_pos/src/widgets/epaisa/epaisa_arrow_card.dart';
import 'package:epaisa_pos/src/widgets/epaisa/epaisa_card_edit.dart';
import 'package:epaisa_pos/src/widgets/general/check_with_label.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_tax_classic.dart';
import 'package:flutter/material.dart';

class PromotionMinimumRequeriments extends StatelessWidget {
  const PromotionMinimumRequeriments({
    Key key,
    @required this.hp,
    @required this.tablet,
  }) : super(key: key);

  final Function hp;
  final bool tablet;

  @override
  Widget build(BuildContext context) {
    final wp = prefix0.ScreenUtils.of(context).wp;
    final fontSize = tablet ? hp(2.8) : wp(4);
    return EpaisaCardEdit(
      hp: hp,
      tablet: tablet,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: hp(2)),
            child: Text(
              'MINIMUM REQUIREMENTS',
              style: TextStyle(
                fontSize: fontSize,
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
                CheckWithLabel(
                  hp: hp,
                  tablet: tablet,
                  checked: false,
                  label: 'None',
                ),
                CheckWithLabel(
                  hp: hp,
                  tablet: tablet,
                  checked: false,
                  label: 'Minimum Purchase Amount (₹)',
                  margin: EdgeInsets.only(bottom: hp(1.5)),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: hp(1.5)),
                  child: TextfieldClassic(
                    fontSize: fontSize,
                    paddingBottomInput: hp(1),
                    labelText: "Purchase Amount (₹)",
                  ),
                ),
                CheckWithLabel(
                  hp: hp,
                  tablet: tablet,
                  checked: false,
                  label: 'Minimum Quantity of Items',
                  margin: EdgeInsets.only(bottom: hp(1.5)),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: hp(0)),
                  child: TextfieldClassic(
                    fontSize: fontSize,
                    paddingBottomInput: hp(1),
                    labelText: "Quantity Value",
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
