import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/views/receipt_screen/widgets/receipt_modal.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_card.dart';
import 'package:epaisa_pos/src/widgets/buttons/epaisa_button.dart';
import 'package:epaisa_pos/src/widgets/dialogs/dialog_select_printers.dart';
import 'package:epaisa_pos/src/widgets/textfields/texfield_number.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:flutter/material.dart';

class SendReceipt extends StatelessWidget {
  final bool isTablet;
  const SendReceipt({Key key, this.isTablet = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Function hp = ScreenUtils.of(context).hp;
    final Function wp = ScreenUtils.of(context).wp;
    return EpaisaCard(
      borderRadius: BorderRadius.circular(hp(0.35)),
      margin: EdgeInsets.only(bottom: hp(1.2)),
      child: Container(
        padding: EdgeInsets.only(
          top: hp(2),
          left: hp(3),
          right: hp(3),
          bottom: hp(1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (isTablet)
              FittedBox(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    eptxt('receipt'),
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(71, 82, 93, 1),
                    ),
                  ),
                ),
              ),
            Container(
              margin: EdgeInsets.only(bottom: hp(1)),
              child: FittedBox(
                child: Text(
                  eptxt('how_receive_receipt'),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: isTablet ? 18 : wp(3.6),
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(71, 82, 93, 1),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: hp(1)),
              child: TextfieldClassic(
                paddingBottomInput: hp(1),
                fontSize: isTablet ? 18 : wp(4),
                labelText: eptxt('email'),
              ),
            ),
            TextfieldNumber(
              paddingBottomInput: hp(1),
              fontSize: isTablet ? 18 : wp(4),
              labelText: eptxt('mobile_number'),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: hp(2)),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: hp(2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: EpaisaButton.withBorder(
                              leftIcon: Container(
                                margin: EdgeInsets.only(right: hp(0.5)),
                                child: Icon(
                                  Icons.not_interested,
                                  color: AppColors.ErrorText,
                                  size: hp(2.8),
                                ),
                              ),
                              onPress: () {},
                              title: eptxt('no_thanks').toUpperCase(),
                              borderColor: AppColors.ErrorText,
                              // height: 50,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 10),
                            child: EpaisaButton.medium(
                              onPress: () {},
                              title: eptxt('send').toUpperCase(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: EpaisaButton.withBorder(
                              onPress: () {
                                Navigator.of(context).push(new PageRouteBuilder(
                                  opaque: false,
                                  pageBuilder: (BuildContext context, _, __) {
                                    return ReceiptModal();
                                  },
                                ));
                              },
                              borderColor: AppColors.PrimaryBlue,
                              title:
                                  eptxt('view_receipt').toUpperCase(),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          child: EpaisaButton.medium(
                            onPress: () => _showPayment(context),
                            title: eptxt('print').toUpperCase(),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Text(
              eptxt('send_receipt_note'),
              style: TextStyle(
                fontSize: isTablet ? 14 : wp(2.8),
                fontWeight: FontWeight.w600,
                color: AppColors.BackPrimaryGray,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

void _showPayment(BuildContext context) {
  Navigator.of(context).push(new PageRouteBuilder(
    opaque: false,
    pageBuilder: (BuildContext context, _, __) {
      return DialogSelectPrinter(
        close: () => Navigator.of(context).pop(),
      );
    },
  ));
}
