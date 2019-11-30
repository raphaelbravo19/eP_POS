import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_card.dart';
import 'package:epaisa_pos/src/widgets/textfields/texfield_number.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:flutter/material.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    Key key,
    @required this.hp,
    @required this.wp,
    this.isTablet = false,
  }) : super(key: key);

  final Function hp;
  final Function wp;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    return EpaisaCard(
      margin: EdgeInsets.all(8),
      header: Container(
        padding: EdgeInsets.symmetric(
          horizontal: hp(4),
        ),
        height: hp(9),
        child: Row(
          children: <Widget>[
            Text(
              eptxt('credit_balance'),
              style: TextStyle(
                color: AppColors.BackPrimaryGray,
                fontWeight: FontWeight.bold,
                fontSize: hp(2.8),
              ),
            ),
          ],
        ),
      ),
      child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: hp(4),
            vertical: hp(2),
          ),
          // height: hp(11),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  TextfieldClassic(
                    keyType: TextInputType.number,
                    alwaysBlue: true,
                    alwaysFocus: true,

                    paddingLeft: isTablet ? hp(3) : wp(5.5),
                    iconLeft: (focus, value) {
                      return Container(
                        margin: EdgeInsets.only(bottom: wp(0.15)),
                        child: Text(
                          '₹',
                          style: TextStyle(
                            color: focus
                                ? AppColors.PrimaryBlue
                                : AppColors.DisabledText,
                            fontWeight: FontWeight.w600,
                            fontSize: isTablet ? hp(2.5) : wp(4.5),
                          ),
                        ),
                      );
                    },
                    paddingBottomInput: hp(1),
                    fontSize: isTablet ? hp(2.5) : wp(4.5),
                    labelText: eptxt('credit_amount'),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: hp(0.2)),

                child: Text(
                  eptxt('credit_amount_description'),
                  style: TextStyle(
                    color: AppColors.BackPrimaryGray,
                    fontWeight: FontWeight.w600,
                    fontSize: isTablet ? hp(1.8) : wp(2.8),
                  ),
                ),
              )
            ],
          )),
    );
  }
}

class TextValueBox extends StatelessWidget {
  const TextValueBox({
    Key key,
    @required this.wp,
    @required this.hp,
    @required this.title,
    @required this.value,
    this.isTablet = false,
  }) : super(key: key);

  final Function wp;
  final bool isTablet;
  final Function hp;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: AppColors.BackPrimaryGray,
            fontWeight: FontWeight.w600,
            fontSize: wp(3),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: TextStyle(
                color: AppColors.BackPrimaryGray,
                fontWeight: FontWeight.bold,
                fontSize: wp(4.5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
