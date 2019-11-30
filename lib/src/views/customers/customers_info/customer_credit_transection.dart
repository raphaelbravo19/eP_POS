import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/payment_button_names.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/cash_register/cash_register.dart';
import 'package:epaisa_pos/src/views/help/widgets/card_item.dart';
import 'package:epaisa_pos/src/views/payments/card_payment/card_payment.dart';
import 'package:epaisa_pos/src/views/payments/cash_payment/cash_payment.dart';
import 'package:epaisa_pos/src/views/payments/checkout/checkout.dart';
import 'package:epaisa_pos/src/views/payments/cheque_payment/cheque_payment.dart';
import 'package:epaisa_pos/src/views/payments/loyalty_payment/loyalty_payment.dart';
import 'package:epaisa_pos/src/views/payments/payments_screen.dart';
import 'package:epaisa_pos/src/views/payments/upi_payment/upi_payment.dart';
import 'package:epaisa_pos/src/views/payments/upi_qr_payment/upi_qr_payment.dart';
import 'package:epaisa_pos/src/views/payments/wallet_payment/wallet_payment.dart';
import 'package:epaisa_pos/src/views/receipt_screen/widgets/receipt_modal.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_card.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_toggle.dart';
import 'package:epaisa_pos/src/widgets/buttons/payment_method_button.dart';
import 'package:epaisa_pos/src/widgets/cards/transaction_card.dart';
import 'package:epaisa_pos/src/widgets/dialogs/dialog_positioned.dart';
import 'package:epaisa_pos/src/widgets/general/check_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomerCreditTransactionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));

    Widget checkIcon() {
      return CheckIcon(
        size: tablet ? hp(5) : wp(8),
      );
    }

    void _showDropdown({
      BuildContext context,
      GlobalKey key,
      marginRight,
      buttonSize,
      fontSize,
      List<Map<String, dynamic>> items,
    }) {
      GlobalKey<DialogPositionedState> dialogActive =
          new GlobalKey<DialogPositionedState>();
      var columns = items.length > 2 ? 2 : 1;
      var rows = items.length > 2 ? 3 : items.length;
      final List data = <Row>[];
      for (var i = 0; i < columns; i++) {
        var num = 0;
        var children = items.sublist(i * rows, rows * (i + 1)).map((item) {
          num++;
          return PaymentMethodButton(
            size: buttonSize,
            onPress: () {
              // Navigator.of(context).pop();
              dialogActive.currentState.closeDialog();
              if (item['onPress'] != null) {
                item['onPress']();
              }
            },
            paymentName: item['paymentName'],
            title: item['title'],
            fontSize: fontSize,
            marginRight: num != rows ? marginRight : 0,
          );
        });
        num = 0;
        data.add(
          Row(
            children: children.toList(),
          ),
        );
      }

      Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) {
            final RenderBox renderBoxRed =
                key.currentContext.findRenderObject();
            final size = renderBoxRed.size;
            final position = renderBoxRed.localToGlobal(Offset.zero);
            final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;

            return DialogPositioned(
              key: dialogActive,
              posx: position.dx -
                  (((size.width - marginRight) * rows) / 2) +
                  ((size.width - marginRight) / 2) -
                  hp(columns) -
                  hp(2),
              posy: position.dy + size.height - hp(2),
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: hp(2),
                      ),
                      EpaisaCard(
                        margin: EdgeInsets.only(bottom: 8),
                        borderRadius: BorderRadius.circular(hp(1.6)),
                        child: Container(
                          padding: EdgeInsets.all(hp(2)),
                          child: Column(
                            children: data.toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      ClipPath(
                        child: Container(
                          width: hp(3),
                          height: hp(2),
                          decoration: BoxDecoration(
                            color: AppColors.PrimaryWhite,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black45,
                                offset: Offset.fromDirection(45),
                                blurRadius: 3,
                                spreadRadius: 0.5,
                              )
                            ],
                          ),
                        ),
                        clipper: TriangleUpClipper(),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    }

    Widget buildCardContainer() {
      return Padding(
        padding: EdgeInsets.only(
            left: wp(3),
            right: tablet ? hp(2) : wp(3),
            top: wp(0.2),
            bottom: wp(0.2)),
        child: Row(
          children: <Widget>[
            checkIcon(),
            SizedBox(
              width: wp(2),
            ),
            TransactionCard(
              toggleSize: hp(1.8),
              letterSpacing: hp(0.02),
              fontSize: tablet ? hp(2.55) : wp(4),
              paddingHorizontal: tablet ? hp(0.6) : hp(0.4),
              paddingVertical: tablet ? hp(0.6) : hp(1),
            ),
          ],
        ),
      );
    }

    _buildCreditCard() {
      return Column(
        children: List.generate(
          5,
          (i) {
            return buildCardContainer();
          },
        ),
      );
    }

    Widget _buildTotal() {
      return Padding(
        padding: EdgeInsets.only(
            left: tablet ? hp(13) : wp(20),
            right: tablet ? hp(7) : wp(7),
            top: tablet ? hp(4) : wp(4),
            bottom: tablet ? hp(0) : wp(0.2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Total",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.DarkGray,
                  fontSize: tablet ? hp(3) : wp(5)),
            ),
            Text(
              "₹ 5,243.65",
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.ErrorText,
                  fontSize: tablet ? hp(3) : wp(5)),
            ),
          ],
        ),
      );
    }

    Widget _buildPaymentOptions() {
      var gap = tablet ? wp(1.3) : hp(2.3);
      final buttonsCount = tablet ? 14 : 4.5;
      var buttonSize = (MediaQuery.of(context).size.width -
              (gap * 2) -
              (gap * buttonsCount - 1)) /
          buttonsCount;

      var fontSize = tablet ? hp(2) : wp(3);
      var marginRight = wp(3);

      final Map<String, GlobalKey> keys = {
        'wallet': GlobalKey(),
        'upi': GlobalKey(),
      };

      return Padding(
        padding: EdgeInsets.only(
            left: tablet ? hp(3) : wp(3),
            right: tablet ? hp(3) : wp(3),
            top: tablet ? hp(1) : wp(3),
            bottom: tablet ? 0 : wp(3)),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              PaymentMethodButton(
                size: buttonSize,
                onPress: () {
                  navigateToPayment(
                    context: context,
                    paymentScreen: PaymentsScreen(
                      customAppBar: PaymentScreenAppBar(
                        hp: hp,
                        title: 'Cash',
                      ),
                      isModal: isTablet(MediaQuery.of(context)),
                      title: 'Cash',
                      paymentBuilder: (double sHeight) => CashPayment(
                        sHeight: sHeight,
                      ),
                    ),
                  );
                },
                paymentName: PaymentButtonNames.Cash,
                title: 'Cash',
                fontSize: fontSize,
                marginRight: marginRight,
              ),
              PaymentMethodButton(
                size: buttonSize,
                onPress: () {
                  navigateToPayment(
                    context: context,
                    paymentScreen: PaymentsScreen(
                      customAppBar: PaymentScreenAppBar(
                        hp: hp,
                        title: 'Card',
                      ),
                      isModal: isTablet(MediaQuery.of(context)),
                      title: 'Card',
                      paymentBuilder: (double sHeight) => CardPayment(
                        sHeight: sHeight,
                      ),
                    ),
                  );
                },
                paymentName: PaymentButtonNames.Card,
                title: 'Card',
                fontSize: fontSize,
                marginRight: marginRight,
              ),
              PaymentMethodButton(
                key: keys['wallet'],
                size: buttonSize,
                onPress: () {
                  final List<Map<String, dynamic>> items = [
                    {
                      "paymentName": PaymentButtonNames.WalletCitrus,
                      "title": 'Citrus',
                    },
                    {
                      "paymentName": PaymentButtonNames.WalletFreecharge,
                      "title": 'Freecharge',
                    },
                    {
                      "paymentName": PaymentButtonNames.WalletMobikwik,
                      "title": 'Mobikwik',
                    },
                    {
                      "paymentName": PaymentButtonNames.WalletMPesa,
                      "title": 'm-Pesa',
                    },
                    {
                      "paymentName": PaymentButtonNames.WalletOlaMoney,
                      "title": 'Ola Money',
                      "onPress": () {
                        navigateToPayment(
                          context: context,
                          paymentScreen: PaymentsScreen(
                            customAppBar: PaymentScreenAppBar(
                              hp: hp,
                              title: 'Wallet',
                            ),
                            isModal: isTablet(MediaQuery.of(context)),
                            title: 'Ola Money Wallet',
                            paymentBuilder: (double sHeight) => WalletPayment(
                              sHeight: sHeight,
                            ),
                          ),
                        );
                      }
                    },
                    {
                      "paymentName": PaymentButtonNames.WalletPockets,
                      "title": 'Pockets',
                    }
                  ];
                  _showDropdown(
                    context: context,
                    key: keys['wallet'],
                    marginRight: marginRight,
                    buttonSize: buttonSize,
                    fontSize: hp(1.6),
                    items: items,
                  );
                },
                dropdown: true,
                paymentName: PaymentButtonNames.WalletPayments,
                title: 'Wallet',
                fontSize: fontSize,
                marginRight: marginRight,
              ),
              PaymentMethodButton(
                key: keys['upi'],
                size: buttonSize,
                onPress: () {
                  final List<Map<String, dynamic>> items = [
                    {
                      "paymentName": PaymentButtonNames.UpiPayments,
                      "title": eptxt('payment_button_upi'),
                      "onPress": () {
                        navigateToPayment(
                          context: context,
                          paymentScreen: PaymentsScreen(
                            customAppBar: PaymentScreenAppBar(
                              hp: hp,
                              title: eptxt('payment_button_upi'),
                            ),
                            isModal: isTablet(MediaQuery.of(context)),
                            title: eptxt('payment_button_upi'),
                            paymentBuilder: (double sHeight) => UpiPayment(
                              sHeight: sHeight,
                            ),
                          ),
                        );
                      },
                    },
                    {
                      "paymentName": PaymentButtonNames.UpiQr,
                      "title": eptxt('payment_button_upi_qr'),
                      "onPress": () {
                        navigateToPayment(
                          context: context,
                          paymentScreen: PaymentsScreen(
                            customAppBar: PaymentScreenAppBar(
                              hp: hp,
                              title: eptxt('payment_button_upi_qr'),
                            ),
                            isModal: isTablet(MediaQuery.of(context)),
                            title: eptxt('payment_button_upi_qr'),
                            paymentBuilder: (double sHeight) => UpiQrPayment(
                              sHeight: sHeight,
                            ),
                          ),
                        );
                      },
                    },
                  ];
                  _showDropdown(
                    context: context,
                    key: keys['upi'],
                    marginRight: marginRight,
                    buttonSize: buttonSize,
                    fontSize: hp(1.6),
                    items: items,
                  );
                },
                dropdown: true,
                paymentName: PaymentButtonNames.UpiPayments,
                title: eptxt('payment_button_upi'),
                fontSize: fontSize,
                marginRight: marginRight,
              ),
              PaymentMethodButton(
                size: buttonSize,
                onPress: () {
                  navigateToPayment(
                    context: context,
                    paymentScreen: PaymentsScreen(
                      customAppBar: PaymentScreenAppBar(
                        hp: hp,
                        title: 'Cheque',
                      ),
                      isModal: isTablet(MediaQuery.of(context)),
                      title: 'Cheque',
                      paymentBuilder: (double sHeight) => ChequePayment(
                        sHeight: sHeight,
                      ),
                    ),
                  );
                },
                paymentName: PaymentButtonNames.Cheque,
                title: 'Cheque',
                fontSize: fontSize,
                isLast: true,
                marginRight: marginRight,
              ),
              PaymentMethodButton(
                size: buttonSize,
                onPress: () {
                  navigateToPayment(
                    context: context,
                    paymentScreen: PaymentsScreen(
                      customAppBar: PaymentScreenAppBar(
                        hp: hp,
                        title: 'Loyalty',
                      ),
                      isModal: isTablet(MediaQuery.of(context)),
                      title: 'Loyalty',
                      paymentBuilder: (double sHeight) => LoyaltyPayment(
                        sHeight: sHeight,
                      ),
                    ),
                  );
                },
                paymentName: PaymentButtonNames.Card,
                title: 'Loyalty',
                fontSize: fontSize,
                marginRight: marginRight,
              ),
              PaymentMethodButton(
                size: buttonSize,
                onPress: () {},
                paymentName: PaymentButtonNames.InvoicePayment,
                title: 'Invoice',
                fontSize: fontSize,
                marginRight: 0,
                isLast: true,
              ),
            ],
          ),
        ),
      );
    }

    final buttonsCount = tablet ? 11 : 5;
    var gap = tablet ? wp(2) : wp(1.4);
    var buttonSize = ((wp(100) - gap) / buttonsCount) - gap;
    return Container(
      child: Column(
        //mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                left: wp(3),
                right: tablet ? hp(3) : wp(3),
                top: tablet ? hp(3) : wp(3),
                bottom: tablet ? hp(1) : wp(3)),
            child: checkIcon(),
          ),
          Expanded(
            child: SingleChildScrollView(
                padding: EdgeInsets.only(), child: _buildCreditCard()),
          ),
          _buildTotal(),
          SizedBox(
            height: hp(1),
          ),
          Buttons(
            gap: tablet ? wp(2.5) : wp(3.1),
            buttonSize: buttonSize,
            fontSize: tablet ? hp(2) : wp(2.8),
          ),
          SizedBox(
            height: tablet ? hp(7.7) : hp(6.5),
          ),
        ],
      ),
    );
  }
}
