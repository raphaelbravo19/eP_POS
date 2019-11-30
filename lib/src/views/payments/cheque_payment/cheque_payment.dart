import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/invoice/invoice_screen.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_card.dart';
import 'package:epaisa_pos/src/views/transactions/transactions_screen.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_camera.dart';
import 'package:epaisa_pos/src/widgets/buttons/epaisa_button.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:flutter/material.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:intl/intl.dart';

class ChequePayment extends StatefulWidget {
  const ChequePayment({
    Key key,
    @required this.sHeight,
  }) : super(key: key);

  final double sHeight;

  @override
  _ChequePaymentState createState() => _ChequePaymentState();
}

class _ChequePaymentState extends State<ChequePayment> {
  GlobalKey<TextfieldClassicState> akey = GlobalKey<TextfieldClassicState>();
  @override
  Widget build(BuildContext context) {
    final tablet = isTablet(MediaQuery.of(context));
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final inputFontSize = hp(tablet ? 3 : 2.6);

    return Container(
      // color: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Center(
            child: EpaisaCard(
              margin: EdgeInsets.symmetric(horizontal: hp(1)),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: hp(4),
                  vertical: hp(2),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        ButtonCamera(
                          size: hp(tablet ? 14 : 14),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: hp(tablet ? 3 : 1)),
                          child: Text(
                            eptxt('cheque_payment_scan'),
                            style: TextStyle(
                              fontSize: hp(tablet ? 2 : 2),
                              fontWeight: FontWeight.w600,
                              color: AppColors.PrimaryBlue,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextfieldClassic(
                      paddingBottomInput: hp(1),
                      fontSize: inputFontSize * 0.95,
                      labelText: eptxt('cheque_number'),
                    ),
                    SizedBox(
                      height: hp(1),
                    ),
                    TextfieldClassic(
                      paddingBottomInput: hp(1),
                      fontSize: inputFontSize * 0.95,
                      labelText: eptxt('cheque_bank_name'),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextfieldClassic(
                      disabled: true,
                      key: akey,
                      calendar: true,
                      firstDate: 1955,
                      lastDate: 2020,

                      customIconBuilder: (hasFocus, empty) {
                        return GestureDetector(
                          onTap: () async {
                            final DateTime picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1955),
                                lastDate: DateTime(2020),
                                footerBuilder: datePickerFooter,
                                width: tablet ? wp(45) : wp(80),
                                headerBuilder: datePickerHeader,
                                builder: (ct, child) {
                                  return child;
                                });
                            if (picked != null) {
                              akey.currentState
                                  .changeText(DateFormat.yMd().format(picked));
                            }
                          },
                          child: Container(
                              child: Image.asset(
                            'assets/general_icons/calendar.png',
                            height: (tablet ? hp(2.7) : hp(2.1)) * 1.4,
                            colorBlendMode: BlendMode.srcIn,
                            color: !empty
                                ? AppColors.PrimaryBlue
                                : AppColors.BackPrimaryGray,
                          )),
                        );
                      },
                      noClear: true,
                      fontSize: tablet ? hp(2.7) : hp(2.1),
                      paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
                      labelText: eptxt('date'),
                      alwaysFocus: false,
                      //alwaysBlue: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
