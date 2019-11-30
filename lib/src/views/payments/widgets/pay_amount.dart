import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:flutter/material.dart';

class PayAmount extends StatelessWidget {
  final double paddingTop;
  final String value;
  final String bottomText;
  const PayAmount(
      {Key key, this.paddingTop, this.bottomText, this.value = '0.00'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hp = ScreenUtils.of(context).hp;
    final wp = ScreenUtils.of(context).wp;
    final tablet = ScreenUtils.of(context).isTablet;
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: hp(1)),
          height: hp(8),
          margin: EdgeInsets.only(top: paddingTop ?? hp(2), bottom: hp(1)),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: const Offset(-2, -2),
                  ),
                  BoxShadow(
                    color: Colors.black26,
                    offset: const Offset(1, 1),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            eptxt('pay_amount').toUpperCase(),
                            style: TextStyle(
                              color: AppColors.BackPrimaryGray,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              fontSize: tablet ? 16 : wp(3.4),
                            ),
                          ),
                          Text(
                            '₹ ${this.value}',
                            style: TextStyle(
                              color: AppColors.BackPrimaryGray,
                              fontWeight: FontWeight.w600,
                              fontSize: tablet ? 24 : wp(5.5),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ),
        Container(
          padding: EdgeInsets.only(right: 8),
          alignment: Alignment.centerRight,
          child: Text(
            bottomText != null
                ? bottomText
                : '₹0.00 ${eptxt('change_out_of')} ₹570.00 ',
            style: TextStyle(
              color: AppColors.ErrorText,
              fontWeight: FontWeight.w600,
              fontSize: tablet ? 14 : wp(3.2),
            ),
          ),
        )
      ],
    );
  }
}
