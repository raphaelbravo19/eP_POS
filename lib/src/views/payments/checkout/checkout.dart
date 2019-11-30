import 'dart:io';

import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/payment_button_names.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart' as prefix0;
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/payments/card_payment/card_payment.dart';
import 'package:epaisa_pos/src/views/payments/cash_payment/cash_payment.dart';
import 'package:epaisa_pos/src/views/payments/cheque_payment/cheque_payment.dart';
import 'package:epaisa_pos/src/views/payments/credit_payment/credit_payment.dart';
import 'package:epaisa_pos/src/views/payments/invoice_payment/invoice_payment.dart';
import 'package:epaisa_pos/src/views/payments/loyalty_payment/loyalty_payment.dart';
import 'package:epaisa_pos/src/views/payments/payments_screen.dart';
import 'package:epaisa_pos/src/views/payments/split_payment/split_payment.dart';
import 'package:epaisa_pos/src/views/payments/upi_payment/upi_payment.dart';
import 'package:epaisa_pos/src/views/payments/upi_qr_payment/upi_qr_payment.dart';
import 'package:epaisa_pos/src/views/payments/wallet_payment/wallet_payment.dart';
import 'package:epaisa_pos/src/views/payments/widgets/pay_amount.dart';
import 'package:epaisa_pos/src/views/receipt_screen/widgets/receipt_modal.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_card.dart';
import 'package:epaisa_pos/src/widgets/buttons/payment_method_button.dart';
import 'package:epaisa_pos/src/widgets/dialogs/dialog_positioned.dart';
import 'package:epaisa_pos/src/widgets/dialogs/screen_as_modal.dart';
import 'package:flutter/material.dart';

class Checkout extends StatelessWidget {
  const Checkout({
    @required this.sHeight,
    @required this.onButtonPress,
  });

  final double sHeight;
  final Function onButtonPress;

  @override
  Widget build(BuildContext context) {
    final tablet = isTablet(MediaQuery.of(context));
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    return Column(
      children: <Widget>[
        Container(
          // decoration: BoxDecoration(color: Colors.black),
          padding: EdgeInsets.all(8),
          // height: sHeight * 0.17,
          width: MediaQuery.of(context).size.width,
          child: tablet
              ? Column(
                  children: <Widget>[
                    PayAmount(),
                    Container(
                      margin: EdgeInsets.only(top: hp(2)),
                      child: ButonsLandscape(
                        onButtonPress: onButtonPress,
                        checkout: true,
                      ),
                    )
                  ],
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ButtonsScroll(
                    marginRight: hp(1.6),
                    fontSize: hp(1.8),
                    buttonSize: hp(8.2),
                    onButtonPress: onButtonPress,
                    tWidth: MediaQuery.of(context).size.width - 16,
                  ),
                ),
        )
      ],
    );
  }
}

class ButonsLandscape extends StatelessWidget {
  const ButonsLandscape({
    Key key,
    @required this.onButtonPress,
    this.checkout = false,
  }) : super(key: key);
  final Function onButtonPress;
  final bool checkout;

  @override
  Widget build(BuildContext context) {
    // final tWidth = 600 - 80;
    bool isIOS = Platform.isIOS;
    final size = checkout ? tablet && isIOS ? wp(9.7) : wp(8.653) : hp(12.5);
    /*  print(hp(13));
    print(hp(11)); */
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              PaymentMethodButton(
                fontSize: hp(2),
                paymentName: PaymentButtonNames.Cash,
                title: eptxt('payment_button_cash'),
                size: size,
                marginRight: 0,
                onPress: () {
                  print("hola");
                  // if (onButtonPress != null) {
                  //   return onButtonPress(
                  //     paymentBuilder: (double sHeight) => CashPayment(
                  //       sHeight: sHeight,
                  //     ),
                  //   );
                  // }
                  navigateToPayment(
                    context: context,
                    paymentScreen: PaymentsScreen(
                      customAppBar: PaymentScreenAppBar(
                        hp: hp,
                        title: multilang.get('payment_button_cash'),
                      ),
                      isModal: isTablet(MediaQuery.of(context)),
                      title: multilang.get('payment_button_cash'),
                      paymentBuilder: (double sHeight) => CashPayment(
                        sHeight: sHeight,
                      ),
                    ),
                  );
                },
              ),
              PaymentMethodButton(
                fontSize: hp(2),
                paymentName: PaymentButtonNames.Card,
                title: eptxt('payment_button_card'),
                size: size,
                marginRight: 0,
                onPress: () {
                  navigateToPayment(
                    context: context,
                    paymentScreen: PaymentsScreen(
                      customAppBar: PaymentScreenAppBar(
                        hp: hp,
                        title: multilang.get('card_payment'),
                      ),
                      isModal: isTablet(MediaQuery.of(context)),
                      title: multilang.get('card_payment'),
                      paymentBuilder: (double sHeight) => CardPayment(
                        sHeight: sHeight,
                      ),
                    ),
                  );
                },
              ),
              PaymentMethodButton(
                fontSize: hp(2),
                paymentName: PaymentButtonNames.WalletPayments,
                title: eptxt('payment_button_wallet'),
                size: size * 0.98,
                marginRight: 0,
                onPress: onButtonPress,
                dropdown: true,
              ),
              PaymentMethodButton(
                fontSize: hp(2),
                paymentName: PaymentButtonNames.CashPos,
                title: eptxt('payment_button_cash_pos'),
                size: size,
                onPress: onButtonPress,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            PaymentMethodButton(
              fontSize: hp(2),
              paymentName: PaymentButtonNames.UpiPayments,
              title: eptxt('payment_button_upi'),
              size: size,
              onPress: onButtonPress,
            ),
            PaymentMethodButton(
              fontSize: hp(2),
              paymentName: PaymentButtonNames.Cheque,
              title: eptxt('payment_button_cheque'),
              size: size,
              marginRight: 0,
              onPress: () {
                navigateToPayment(
                  context: context,
                  paymentScreen: PaymentsScreen(
                    customAppBar: PaymentScreenAppBar(
                      hp: hp,
                      title: multilang.get('payment_button_cheque'),
                    ),
                    isModal: isTablet(MediaQuery.of(context)),
                    title: multilang.get('payment_button_cheque'),
                    paymentBuilder: (double sHeight) => ChequePayment(
                      sHeight: sHeight,
                    ),
                  ),
                );
              },
            ),
            PaymentMethodButton(
              fontSize: hp(2),
              onPress: onButtonPress,
              paymentName: PaymentButtonNames.Emi,
              title: eptxt('payment_button_emi'),
              size: size,
              marginRight: 0,
            ),
            PaymentMethodButton(
              fontSize: hp(2),
              onPress: onButtonPress,
              paymentName: PaymentButtonNames.Loyalty,
              title: eptxt('payment_button_loyalty'),
              size: size,
              marginRight: 0,
            ),
          ],
        )
      ],
    );
  }
}

final Map<String, GlobalKey> keys = {
  'wallet': GlobalKey(),
  'upi': GlobalKey(),
};

class ButtonsScroll extends StatelessWidget {
  const ButtonsScroll({
    @required this.onButtonPress,
    @required this.tWidth,
    @required this.buttonSize,
    @required this.fontSize,
    @required this.marginRight,
    this.showSplit = true,
    Key key,
  }) : super(key: key);
  final Function onButtonPress;
  final double tWidth;
  final double buttonSize;
  final double fontSize;
  final double marginRight;
  final bool showSplit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        PaymentMethodButton(
          size: buttonSize,
          onPress: () {
            // if (onButtonPress != null) {
            //   return onButtonPress(
            //     paymentBuilder: (double sHeight) => CashPayment(
            //       sHeight: sHeight,
            //     ),
            //   );
            // }
            if (onButtonPress != null) {
              onButtonPress();
            }
            print("hola");
            navigateToPayment(
              context: context,
              width: wp(50),
              paymentScreen: PaymentsScreen(
                customAppBar: PaymentScreenAppBar(
                  hp: hp,
                  title: eptxt('payment_button_cash'),
                ),
                isModal: isTablet(MediaQuery.of(context)),
                title: eptxt('payment_button_cash'),
                paymentBuilder: (double sHeight) => CashPayment(
                  sHeight: sHeight,
                ),
              ),
            );
          },
          paymentName: PaymentButtonNames.Cash,
          title: eptxt('payment_button_cash'),
          fontSize: fontSize,
          marginRight: marginRight,
        ),
        PaymentMethodButton(
          size: buttonSize,
          onPress: () {
            navigateToPayment(
              context: context,
              paymentScreen: PaymentsScreen(
                shouldPay: false,
                customAppBar: PaymentScreenAppBar(
                  hp: hp,
                  title: eptxt('card_payment'),
                ),
                isModal: isTablet(MediaQuery.of(context)),
                title: eptxt('card_payment'),
                paymentBuilder: (double sHeight) => CardPayment(
                  sHeight: sHeight,
                ),
              ),
            );
          },
          paymentName: PaymentButtonNames.Card,
          title: eptxt('payment_button_card'),
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
                    height: hp(85),
                    context: context,
                    paymentScreen: PaymentsScreen(
                      customAppBar: PaymentScreenAppBar(
                        hp: hp,
                        title: "Wallet",
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
          title: eptxt('payment_button_wallet'),
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
                    height: hp(85),
                    width: wp(45),
                    context: context,
                    paymentScreen: PaymentsScreen(
                      customAppBar: PaymentScreenAppBar(
                        hp: hp,
                        title: "UPI",
                      ),
                      isModal: isTablet(MediaQuery.of(context)),
                      title: "UPI",
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
                      cancel: true,
                      customAppBar: PaymentScreenAppBar(
                        hp: hp,
                        title: 'UPI Scan to Pay',
                      ),
                      isModal: isTablet(MediaQuery.of(context)),
                      title: 'UPI Scan to Pay',
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
                  title: eptxt('payment_button_cheque'),
                ),
                isModal: isTablet(MediaQuery.of(context)),
                title: eptxt('payment_button_cheque'),
                paymentBuilder: (double sHeight) => ChequePayment(
                  sHeight: sHeight,
                ),
              ),
            );
          },
          paymentName: PaymentButtonNames.Cheque,
          title: eptxt('payment_button_cheque'),
          fontSize: fontSize,
          isLast: true,
          marginRight: marginRight,
        ),
        PaymentMethodButton(
          size: buttonSize,
          onPress: onButtonPress,
          paymentName: PaymentButtonNames.Emi,
          title: eptxt('payment_button_emi'),
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
                  title: eptxt('payment_button_loyalty'),
                ),
                isModal: isTablet(MediaQuery.of(context)),
                title: eptxt('payment_button_loyalty'),
                paymentBuilder: (double sHeight) => LoyaltyPayment(
                  sHeight: sHeight,
                ),
              ),
            );
          },
          paymentName: PaymentButtonNames.Loyalty,
          title: eptxt('payment_button_loyalty'),
          fontSize: fontSize,
          marginRight: marginRight,
        ),
        PaymentMethodButton(
          size: buttonSize,
          onPress: onButtonPress,
          paymentName: PaymentButtonNames.CashPos,
          title: eptxt('payment_button_cash_pos'),
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
                  title: eptxt('payment_button_credit'),
                ),
                isModal: isTablet(MediaQuery.of(context)),
                title: eptxt('payment_button_credit'),
                paymentBuilder: (double sHeight) => CreditPayment(
                  sHeight: sHeight,
                ),
              ),
            );
          },
          paymentName: PaymentButtonNames.CreditPayment,
          title: eptxt('payment_button_credit'),
          fontSize: fontSize,
          marginRight: marginRight,
        ),
        if (showSplit)
          PaymentMethodButton(
            size: buttonSize,
            onPress: () {
              navigateToPayment(
                width: wp(75),
                height: hp(70),
                context: context,
                paymentScreen: PaymentsScreen(
                  // transactionDetails: tablet ? false : true,
                  isSplit: tablet ? true : false,
                  customAppBar: PaymentScreenAppBar(
                    hp: hp,
                    title: eptxt('payment_button_split'),
                  ),
                  isModal: isTablet(MediaQuery.of(context)),
                  title: eptxt('payment_button_split').toUpperCase(),
                  paymentBuilder: (double sHeight) => SplitPayment(
                    sHeight: sHeight,
                  ),
                ),
              );
            },
            paymentName: PaymentButtonNames.Split,
            title: eptxt('payment_button_split'),
            fontSize: fontSize,
            marginRight: marginRight,
          ),
        PaymentMethodButton(
          size: buttonSize,
          onPress: () {
            navigateToPayment(
              height: hp(83),
              context: context,
              paymentScreen: PaymentsScreen(
                customAppBar: PaymentScreenAppBar(
                  hp: hp,
                  title: eptxt('payment_button_invoice'),
                ),
                isModal: isTablet(MediaQuery.of(context)),
                title: eptxt('payment_button_invoice'),
                paymentBuilder: (double sHeight) => InvoicePayment(
                  sHeight: sHeight,
                ),
              ),
            );
          },
          paymentName: PaymentButtonNames.InvoicePayment,
          title: eptxt('payment_button_invoice'),
          fontSize: fontSize,
          marginRight: marginRight,
          isLast: true,
        ),
      ],
    );
  }
}

void navigateToPayment(
    {BuildContext context, Widget paymentScreen, double width, double height}) {
  final tablet = isTablet(MediaQuery.of(context));
  if (!tablet) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) {
          return paymentScreen;
        },
      ),
    );
    return;
  } else {
    _showDialog(
      context: context,
      paymentScreen: paymentScreen,
      width: width != null ? width : 600,
      height: height != null ? height : hp(90),
    );
  }
}

void _showDialog(
    {BuildContext context, Widget paymentScreen, double width, double height}) {
  Navigator.of(context).push(
    new PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return ScreenAsModal(
          body: paymentScreen,
          width: width,
          height: height,
        );
      },
    ),
  );
}

class PaymentScreenAppBar extends StatelessWidget {
  const PaymentScreenAppBar({
    Key key,
    @required this.hp,
    @required this.title,
  }) : super(key: key);

  final Function hp;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hp(9),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: hp(0.5),
          ),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        child: Stack(
          // alignment: Alignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: hp(3.3),
                  color: AppColors.BackPrimaryGray,
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 8,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Image.asset(
                  'assets/general_icons/xbutton.png',
                  height: hp(2.9),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
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
        final RenderBox renderBoxRed = key.currentContext.findRenderObject();
        final size = renderBoxRed.size;
        final position = renderBoxRed.localToGlobal(Offset.zero);
        final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
        var center = position.dx + (size.width / 2) - (marginRight / 2);
        var aligned = center -
            ((tablet
                    ? hp(columns == 1 ? 6.9 : 6.1)
                    : hp(columns == 1 ? 5.5 : 5.5)) +
                (((buttonSize + marginRight) * columns) / 2));
        var heightBox = hp(4) + (columns * size.height);
        var topPosition = position.dy + size.height - hp(2);
        var isUP = topPosition + heightBox > hp(100);
        if (isUP) {
          topPosition = position.dy - heightBox - (hp(2));
        }
        return DialogPositioned(
          key: dialogActive,
          posx:
              aligned /*position
              .dx  -
              (((size.width - marginRight) * rows) / 2) +
              ((size.width - marginRight) / 2) -
              hp(columns) -
              hp(2)*/
          ,
          posy: topPosition,
          child: Stack(
            alignment: isUP ? Alignment.bottomCenter : Alignment.topCenter,
            children: <Widget>[
              Column(
                children: <Widget>[
                  if (!isUP)
                    SizedBox(
                      height: hp(2),
                    ),
                  EpaisaCard(
                    borderRadius: BorderRadius.circular(hp(1.6)),
                    child: Container(
                      padding: EdgeInsets.all(hp(2)),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(hp(1.6)),
                          color: Color(0xFFFCFCFC),
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/splashscreen/background.png"),
                              fit: BoxFit.cover)),
                      child: Column(
                        children: data.toList(),
                      ),
                    ),
                  ),
                  if (isUP && Platform.isAndroid)
                    SizedBox(
                      height: hp(1.75),
                    ),
                ],
              ),
              Stack(
                alignment: isUP ? Alignment.topCenter : Alignment.bottomCenter,
                children: <Widget>[
                  ClipPath(
                    child: Container(
                      width: isUP ? hp(3.5) : hp(3.3),
                      height: isUP ? hp(1.8) : hp(2),
                      decoration: BoxDecoration(
                        color: Colors.black45.withOpacity(0.2),
                        //border: Border.all(width: 2),
                      ),
                    ),
                    clipper: isUP ? TriangleDownClipper() : TriangleUpClipper(),
                  ),
                  ClipPath(
                    child: Container(
                      width: hp(3),
                      height: hp(1.6),
                      decoration: BoxDecoration(
                        color: Color(0xFFFCFCFC),
                        //border: Border.all(width: 2),
                      ),
                    ),
                    clipper: isUP ? TriangleDownClipper() : TriangleUpClipper(),
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
