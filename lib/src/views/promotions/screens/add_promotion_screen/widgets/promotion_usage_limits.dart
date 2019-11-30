import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart' as prefix0;
import 'package:epaisa_pos/src/widgets/epaisa/epaisa_card_edit.dart';
import 'package:epaisa_pos/src/widgets/general/check_with_label.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_dropdown.dart';
import 'package:flutter/material.dart';

class PromotionUsageLimits extends StatelessWidget {
  const PromotionUsageLimits({
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
              'USAGE LIMITS',
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
                  label: 'Limit to one user per customer',
                ),
                CheckWithLabel(
                  hp: hp,
                  tablet: tablet,
                  checked: false,
                  label: 'Limit number of times this discount can',
                  label2: 'be used in total',
                  margin: EdgeInsets.only(bottom: hp(1)),
                ),
                Container(
                  child: tablet
                      ? Stack(
                          alignment: Alignment.bottomLeft,
                          children: <Widget>[
                            SizedBox(
                              child: Container(
                                alignment: Alignment.bottomLeft,
                                child: TextfieldDropdown(
                                  fontSize: fontSize,
                                  paddingLeft: fontSize * 1.3,
                                  paddingBottomInput: hp(1),

                                  showBlueDropdownColor: true,
                                  labelText: "Discount Value",
                                  alwaysBlue: true,
                                  defaultText: '%',
                                  //items: ["%", "₹"],
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              margin: EdgeInsets.only(
                                  left: tablet ? wp(7) : wp(23)),
                              child: TextfieldClassic(
                                fontSize: fontSize,
                                leftBorder: true,
                                alwaysBlue: true,
                                paddingLeft: tablet ? wp(1) : wp(3),
                                paddingBottomInput: hp(1),
                              ),
                            ),
                          ],
                        )
                      : TextfieldClassic(
                          fontSize: fontSize,
                          paddingBottomInput: hp(1),
                          labelText: "Number of uses",
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
