import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_card.dart';
import 'package:epaisa_pos/src/widgets/buttons/epaisa_button.dart';
import 'package:epaisa_pos/src/widgets/textfields/texfield_number.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:flutter/material.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';

class InvoicePayment extends StatelessWidget {
  const InvoicePayment({
    @required this.sHeight,
  });

  final double sHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Center(
            child: EpaisaCard(
              margin: EdgeInsets.all(8),
              header: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(
                  horizontal: tablet ? hp(4) : wp(6),
                  vertical: tablet ? hp(3) : wp(5),
                ),
                child: Text(
                  eptxt('invoice_send'),
                  style: TextStyle(
                    color: AppColors.BackPrimaryGray,
                    fontWeight: FontWeight.bold,
                    fontSize: tablet ? hp(2.8) : wp(4.5),
                  ),
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: hp(4),
                  vertical: hp(3),
                ),
                child: Column(
                  children: <Widget>[
                    TextfieldNumber(
                      paddingBottomInput: hp(1),
                      fontSize: tablet ? hp(2.6) : wp(4),
                      labelText: eptxt('mobile_number'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextfieldClassic(
                      paddingBottomInput: hp(1),
                      fontSize: tablet ? hp(2.6) : wp(4),
                      labelText: eptxt('email') + " Address",
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: hp(7),)
        ],
      ),
    );
  }
}
