import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:flutter/material.dart';

class TotalAmount extends StatelessWidget {
  final BuildContext context;
  final String value;
  const TotalAmount({
    Key key,
    @required this.context,
    @required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    return Container(
      alignment: Alignment.center,
      height: hp(5.4),
      padding: EdgeInsets.symmetric(horizontal: wp(4)),
      decoration: BoxDecoration(
        color: AppColors.TextGray,
        boxShadow: [
          new BoxShadow(
            color: AppColors.DarkGray.withOpacity(tablet ? 0.6 : 0.6),
            offset: new Offset(0, 3),
            blurRadius: 3,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            eptxt('total_amount').toUpperCase(),
            style: TextStyle(
                fontSize: tablet ? hp(2.2) : wp(3.5),
                color: AppColors.DarkWhite,
                fontWeight: FontWeight.w600,
                letterSpacing: wp(0.3)),
          ),
          Text(
            "₹ ${value != null ? value : double.parse("1570").toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: tablet ? hp(2.2) : wp(3.5),
              color: AppColors.DarkWhite,
              fontWeight: FontWeight.w600,
              letterSpacing: wp(0.5),
            ),
          )
        ],
      ),
    );
  }
}
