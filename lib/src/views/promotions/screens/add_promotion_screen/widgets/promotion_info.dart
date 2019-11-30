import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_camera.dart';
import 'package:epaisa_pos/src/widgets/epaisa/epaisa_card_edit.dart';
import 'package:epaisa_pos/src/widgets/textfields/texfield_box.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:flutter/material.dart';

class PromotionInfo extends StatelessWidget {
  const PromotionInfo({
    Key key,
    @required this.tablet,
    @required this.hp,
    @required this.wp,
    @required this.fontSize,
    @required this.separator,
  }) : super(key: key);

  final bool tablet;
  final Function hp;
  final Function wp;
  final double fontSize;
  final double separator;

  @override
  Widget build(BuildContext context) {
    return EpaisaCardEdit(
      tablet: tablet,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              ButtonCamera(
                size: tablet ? hp(16) : wp(25),
              ),
              SizedBox(
                width: tablet ? hp(2) : wp(3),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: TextfieldClassic(
                    fontSize: fontSize,
                    paddingBottomInput: hp(1),
                    labelText: "Promotion Name",
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: separator,
          ),
          TextfieldBox(
            paddingBottomInput: hp(1),
            fontSize: fontSize,
            labelText: "Promotion Description",
          ),
          SizedBox(
            height: separator,
          ),
          TextfieldClassic(
              paddingBottomInput: hp(1),
              fontSize: fontSize,
              labelText: "Discount Code",
              animatedItem: (change) {
                return Container(
                  padding: EdgeInsets.only(top: hp(1.1)),
                  child: GestureDetector(
                    onTap: () {
                      change("DIWALI");
                    },
                    child: Text(
                      'Generate Code',
                      style: TextStyle(
                        fontSize: hp(1.6),
                        fontWeight: FontWeight.w600,
                        color: AppColors.PrimaryBlue,
                      ),
                    ),
                  ),
                );
              })
        ],
      ),
      hp: hp,
    );
  }
}
