import 'dart:io';

import 'package:epaisa_pos/src/models/OrderItem.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/cash_register/cash_register.dart';
import 'package:epaisa_pos/src/views/invoice/invoice_screen.dart';
import 'package:epaisa_pos/src/views/payments/widgets/transaction_details.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient.dart';
import 'package:epaisa_pos/src/widgets/dialogs/screen_as_modal.dart';
import 'package:epaisa_pos/src/widgets/utils/dialogs_helper.dart';
import 'package:flutter/material.dart';

class PaymentsScreen extends StatefulWidget {
  final customAppBar;
  final bool isModal;
  final Function paymentBuilder;
  final String title;
  // final bool transactionDetails;
  final bool isSplit;
  final bool shouldPay;
  final bool cancel;
  PaymentsScreen(
      {this.customAppBar,
      this.shouldPay = true,
      this.isModal = false,
      this.paymentBuilder,
      this.title,
      // this.transactionDetails = true,
      this.isSplit = false,
      this.cancel = false});

  @override
  _PaymentsScreenState createState() => _PaymentsScreenState();
}

void _showDialogNeedsFix(
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

class _PaymentsScreenState extends State<PaymentsScreen> {
  _PaymentsScreenState();
  var currentScreen = 'wallet';
  var orderItems = [
    OrderItem(
      description: 'Custom Product 1',
      price: (cashRegisterBloc.streamOrder.value["amount"] as double)
          .toStringAsFixed(2),
      quantity: '1',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final appBar = (widget.isModal)
        ? widget.customAppBar
        : EpaisaAppBar(
            back: true,
            title: widget.title.toUpperCase(),
          );
    final sHeight =
        MediaQuery.of(context).size.height - hp(9) - (widget.isModal ? 32 : 0);
    final tablet = isTablet(MediaQuery.of(context));
    final inputFontSize = hp(tablet ? 3 : 2.6);
    var definedHeight = (sHeight * (tablet ? 0.22 : 0.20)) - hp(4);
    Widget PaymentsTablet() {
      return Column(
        children: <Widget>[
          widget.isSplit
              ? Container()
              : Container(
                  padding:
                      EdgeInsets.symmetric(vertical: hp(2), horizontal: hp(1)),
                  child: TransactionDetails(
                    expandHeight: hp(),
                    height: definedHeight,
                    showMoreEnabled: !widget.isModal,
                    isTablet: widget.isModal,
                    items: orderItems,
                    subTotal: '548.50',
                  ),
                ),
          widget.paymentBuilder(sHeight),
          SizedBox(
            height: hp(3),
          ),
          Container(
            child: GestureDetector(
              onTap: () {
                if (tablet) {
                  Navigator.of(context).pushReplacement(
                    new PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (BuildContext context, _, __) {
                        return ScreenAsModal(
                          body: InvoiceScreen(),
                          height: hp(80),
                          width: wp(80),
                        );
                      },
                    ),
                  );
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => InvoiceScreen(),
                    ),
                  );
                }
              },
              child: !widget.shouldPay
                  ? Container()
                  : Container(
                      child: ButtonGradiant(
                        tablet ? hp(2.8) : hp(3),
                        tablet ? wp(38) : wp(90),
                        widget.cancel
                            ? "CANCEL"
                            : '${multilang.get('pay').toUpperCase()} ₹ 570.00',
                        textStyle: TextStyle(
                            fontSize: hp(2),
                            letterSpacing: tablet ? 2 : 1.5,
                            color: AppColors.PrimaryWhite,
                            fontWeight: FontWeight.w500),
                        borderRadius: hp(3.7),
                      ),
                    ),
            ),
          ),
        ],
      );
    }

    Widget PaymentsPortrait() {
      var isIOS = Platform.isIOS;

      return Container(
        height: isIOS ? hp(90) : hp(90),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    widget.isSplit
                        ? Container()
                        : Container(
                            padding: EdgeInsets.symmetric(
                                vertical: hp(2), horizontal: hp(1)),
                            child: TransactionDetails(
                              expandHeight: getExpandHeight(
                                  hp, orderItems, '12.50', null),
                              height:
                                  (sHeight * (tablet ? 0.22 : 0.20)) - hp(4),
                              showMoreEnabled: !widget.isModal,
                              isTablet: widget.isModal,
                              items: orderItems,
                              subTotal: (cashRegisterBloc.streamTotal.value)
                                  .toStringAsFixed(2),
                              discount: Discount(
                                calculated: '12.50',
                                value: '10',
                                type: '%',
                              ),
                            ),
                          ),
                    widget.paymentBuilder(sHeight),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: hp(2)),
                child: GestureDetector(
                  onTap: () async {
                    if (tablet) {
                      Navigator.of(context).pushReplacement(
                        new PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) {
                            return ScreenAsModal(
                              body: InvoiceScreen(),
                              height: hp(80),
                              width: wp(80),
                            );
                          },
                        ),
                      );
                    } else {
                      showLoading(context);
                      await cashRegisterBloc.processPayment(
                          cashRegisterBloc.streamOrder.value["amount"]);
                      await cashRegisterBloc.finalizePayment();

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => InvoiceScreen(),
                        ),
                      );
                    }
                  },
                  child: !widget.shouldPay
                      ? Container()
                      : Container(
                          child: ButtonGradiant(
                            tablet ? hp(2.8) : hp(2.4),
                            tablet ? wp(38) : wp(90),
                            widget.cancel
                                ? "CANCEL"
                                : '${multilang.get('pay').toUpperCase()} ₹ 570.00',
                            textStyle: TextStyle(
                                fontSize: tablet ? hp(1.8) : wp(3.6),
                                letterSpacing: tablet ? 2 : 1.5,
                                color: AppColors.PrimaryWhite,
                                fontWeight: FontWeight.w500),
                            borderRadius: hp(3.2),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return EpaisaScaffold(
      appBar: appBar,
      noImage: tablet,
      noSafe: tablet,
      body: Container(
        height: sHeight,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                    left: widget.isModal ? 32 : 0,
                    right: widget.isModal ? 32 : 0,
                    bottom: tablet ? hp(1) : hp(1)),
                child: tablet ? PaymentsTablet() : PaymentsPortrait()),
          ],
        ),
      ),
    );
  }

  double getExpandHeight(
    Function hp,
    List<OrderItem> orderItems,
    String subTotal,
    Discount discount,
  ) {
    var header = hp(3.6) + 0.6;
    var subTotalHeight = (subTotal != null) ? hp(3) : 0;
    var discountHeight = (discount != null) ? hp(3.2) : 0;

    final double totalItems = orderItems.map((i) {
      return i.discount != null ? (hp(3.6) + hp(2.3)) : hp(3.6);
    }).reduce((value, element) => value + element);

    return header + totalItems + subTotalHeight + discountHeight;
  }
}
