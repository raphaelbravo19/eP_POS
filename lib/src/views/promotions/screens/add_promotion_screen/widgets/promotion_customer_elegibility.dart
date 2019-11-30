import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart' as prefix0;
import 'package:epaisa_pos/src/widgets/epaisa/epaisa_arrow_card.dart';
import 'package:epaisa_pos/src/widgets/epaisa/epaisa_card_edit.dart';
import 'package:epaisa_pos/src/widgets/general/check_with_label.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_tax_classic.dart';
import 'package:flutter/material.dart';

class PromotionCustomerElegibility extends StatelessWidget {
  const PromotionCustomerElegibility({
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
              'CUSTOMER ELIGIBILITY',
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
                  label: 'Everyone',
                ),
                CheckWithLabel(
                  hp: hp,
                  tablet: tablet,
                  checked: false,
                  label: 'Specific Customers',
                  margin: EdgeInsets.only(bottom: hp(1)),
                ),
                EpaisaArrowCard(
                  fontSize: tablet ? hp(2.2) : wp(3.6),
                  paddingHorizontal: hp(2.4),
                  paddingVertical: tablet ? hp(2) : wp(2.4),
                  description: "Select the Customers",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
