import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_toggle.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final double paddingVertical;
  final double paddingHorizontal;
  final double fontSize;
  final double letterSpacing;
  final double toggleSize;
  TransactionCard(
      {this.letterSpacing,
      this.paddingHorizontal,
      this.paddingVertical,
      this.fontSize,
      this.toggleSize = 10});
  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));

    return Expanded(
      child: Card(
        elevation: 2,
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: paddingHorizontal, vertical: paddingVertical),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: tablet ? hp(2) : wp(2),
              ),
              Image.asset(
                'assets/customers/Credit.png',
                height:
                    fontSize != null ? fontSize * 3.4 : tablet ? hp(7) : wp(14),
                width:
                    fontSize != null ? fontSize * 3.4 : tablet ? hp(7) : wp(14),
              ),
              SizedBox(
                width: tablet ? hp(1.5) : wp(3),
              ),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Credit",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.DarkGray,
                            fontSize: fontSize != null
                                ? fontSize
                                : tablet ? hp(2.2) : wp(4.5)),
                      ),
                      SizedBox(
                        height: hp(0.6),
                      ),
                      Text(
                        "Invoice No. 45612",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.NoPrinterText,
                            fontSize: fontSize != null
                                ? fontSize * 0.64
                                : tablet ? hp(1.5) : wp(2.7)),
                      )
                    ]),
              ),
              Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "₹ 3121.36",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.ErrorText,
                            fontSize: fontSize != null
                                ? fontSize
                                : tablet ? hp(2.1) : wp(4.5)),
                      ),
                      SizedBox(
                        height: hp(0.6),
                      ),
                      Text(
                        eptxt('pending'),
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.NoPrinterText,
                            fontSize: fontSize != null
                                ? fontSize * 0.8
                                : tablet ? hp(1.5) : wp(2.8)),
                      ),
                    ]),
              ),
              SizedBox(
                width: tablet ? hp(1.5) : wp(3),
              )
            ],
          ),
        ),
      ),
    );
  }
}
