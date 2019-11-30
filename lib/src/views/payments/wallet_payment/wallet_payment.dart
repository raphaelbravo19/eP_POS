import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/payment_button_names.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/invoice/invoice_screen.dart';
import 'package:epaisa_pos/src/views/reset_password/widgets/otp_fields.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_card.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_camera.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/buttons/epaisa_button.dart';
import 'package:epaisa_pos/src/widgets/buttons/payment_method_button.dart';
import 'package:epaisa_pos/src/widgets/textfields/texfield_number.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:flutter/material.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';

class WalletPayment extends StatelessWidget {
  const WalletPayment({
    Key key,
    @required this.sHeight,
  }) : super(key: key);

  final double sHeight;

  @override
  Widget build(BuildContext context) {
    final tablet = isTablet(MediaQuery.of(context));
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final inputFontSize = hp(tablet ? 3 : 2.6);

    return Container(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: EpaisaCard(
                margin: EdgeInsets.all(8),
                header: Container(
                    // alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(
                      horizontal: hp(1.5),
                      // vertical: hp(3),
                    ),
                    height: hp(9),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: hp(6.5),
                          alignment: Alignment.bottomCenter,
                          child: PaymentMethodButton(
                            onPress: () {},
                            marginRight: hp(2),
                            paymentName: PaymentButtonNames.WalletMobikwik,
                            size: hp(6.5),
                          ),
                        ),
                        Text(
                          'Mobikwik Wallet',
                          style: TextStyle(
                            color: AppColors.BackPrimaryGray,
                            fontWeight: FontWeight.bold,
                            fontSize: hp(2.8),
                          ),
                        ),
                      ],
                    )),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: hp(4),
                    vertical: hp(3),
                  ),
                  child: Column(
                    children: <Widget>[
                      TextfieldNumber(
                        paddingBottomInput: hp(1),
                        fontSize: hp(2.6),
                        labelText: eptxt('mobile_number'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: EpaisaCard(
                margin: EdgeInsets.all(8),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: hp(4),
                    vertical: hp(3),
                  ),
                  child: Column(
                    children: <Widget>[
                      OtpFields(
                        cant: 6,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
