import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:flutter/material.dart';

class PaymentOptionsWidget extends StatefulWidget {
  @override
  _PaymentOptionsWidgetState createState() => _PaymentOptionsWidgetState();
}

class _PaymentOptionsWidgetState extends State<PaymentOptionsWidget> {
  var options = {
    "card": {
      "rupay": {"selected": false},
      "visa": {"selected": false},
      "mastercard": {"selected": false},
      "discover": {"selected": false},
      "dinersclub": {"selected": false},
      "maestro": {"selected": false},
    },
    "wallet": {
      "citrus": {"selected": false},
      "freecharge": {"selected": false},
      "mpesa": {"selected": false},
      "mobikwik": {"selected": false},
      "olamoney": {"selected": false},
      "pockets": {"selected": false},
    },
    "upi": {
      "upi": {"selected": false},
      "upiqr": {"selected": false},
    },
    "cash": {
      "cash": {"selected": false},
      "tendering": {"selected": true},
    },
    "emi": {
      "emi": {"selected": false},
    },
    "other": {
      "split": {"selected": false},
      "cheque": {"selected": false},
    },
    "cashpos": {
      "one": {"selected": false},
      "two": {"selected": false},
      "three": {"selected": false},
    },
  };
  @override
  Widget build(BuildContext context) {
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final bool tablet = isTablet(MediaQuery.of(context));

    Widget buildDivider() {
      return Container(
        height: 0.4,
        padding: EdgeInsets.all(tablet ? hp(0.9) : wp(0.9)),
        color: AppColors.BorderGray,
      );
    }

    Widget buildPaymentNameLogoStructure(
        {String paymentTypeIcons = '',
        String paymentTypeName = '',
        Function onTap}) {
      return GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap();
          }
        },
        child: Row(
          children: <Widget>[
            Image.asset(
              paymentTypeIcons,
              height: tablet ? hp(7) : wp(12),
            ),
            SizedBox(
              width: tablet ? hp(1.2) : wp(3),
            ),
            Text(
              paymentTypeName,
              style: TextStyle(
                fontSize: tablet ? hp(2.7) : wp(4.5),
                color: AppColors.DarkGray,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      );
    }

    Widget paymentNameIconStructure(
        {String paymentIcons, String cardName, Function onTap}) {
      return GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap();
          }
        },
        child: Container(
          width: tablet ? wp(8.5) : wp(20),
          child: Column(
            children: <Widget>[
              Image.asset(
                paymentIcons,
                height: tablet ? hp(7) : wp(12),
              ),
              SizedBox(
                height: hp(0.3),
              ),
              FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  cardName,
                  style: TextStyle(
                    color: AppColors.DarkGray,
                    fontWeight: FontWeight.bold,
                    fontSize: tablet ? hp(1.6) : wp(2.6),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget buildPaymentOptionsStructure(
        {String paymentTypeIcons = '',
        String paymentTypeName = '',
        List<Widget> row1 = const [],
        List<Widget> row2 = const [],
        onTap}) {
      Widget mobTabView() {
        var mobView = Column(
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: row1),
            if (!(!tablet && row2.length == 0))
              SizedBox(
                height: tablet ? hp(5) : wp(5),
              ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: row2)
          ],
        );
        if (row2.length == 0 && row1.length == 3)
          row2 = [
            SizedBox(width: wp(8.5)),
            SizedBox(width: wp(8.5)),
            SizedBox(
              width: wp(8.5),
            )
          ];

        if (row2.length == 0 && row1.length == 2) {
          row1.add(SizedBox(width: tablet ? wp(8.5) : wp(20)));
          row2 = [
            SizedBox(width: wp(8.5)),
            SizedBox(width: wp(8.5)),
            SizedBox(
              width: wp(8.5),
            )
          ];
        }
        List<Widget> list = row1 + row2;

        var tabView = Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, children: list);

        return tablet ? tabView : mobView;
      }

      return GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap();
          }
        },
        child: Padding(
          padding: EdgeInsets.only(
            right: tablet ? hp(2) : wp(3),
            left: tablet ? hp(4) : wp(3),
            top: tablet ? hp(2) : wp(2.4),
            bottom: tablet ? hp(1) : wp(0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: tablet ? 0 : wp(2)),
                child: buildPaymentNameLogoStructure(
                  paymentTypeIcons: paymentTypeIcons,
                  paymentTypeName: paymentTypeName,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    right: tablet ? hp(2) : wp(5),
                    left: tablet ? hp(0.7) : wp(5),
                    top: tablet ? hp(2) : wp(3),
                    bottom: tablet ? hp(2) : wp(2)),
                child: mobTabView(),
              )
            ],
          ),
        ),
      );
    }

    Widget buildCardPaymentOptions({
      String paymentTypeIcons = '',
      String paymentTypeName = '',
      List<Widget> row1 = const [SizedBox()],
      List<Widget> row2 = const [SizedBox()],
    }) {
      Widget mobTabView() {
        var mobView = Column(
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  paymentNameIconStructure(
                    cardName: "RuPay",
                    paymentIcons:
                        "assets/payments/icons/rupay${options['card']['rupay']['selected'] ? '' : '_disabled'}.png",
                    onTap: () {
                      setState(() {
                        bool current = options['card']['rupay']['selected'];
                        options['card']['rupay']['selected'] = !current;
                      });
                    },
                  ),
                  paymentNameIconStructure(
                    cardName: "Visa",
                    paymentIcons:
                        "assets/payments/icons/visa${options['card']['visa']['selected'] ? '' : '_disabled'}.png",
                    onTap: () {
                      setState(() {
                        bool current = options['card']['visa']['selected'];
                        options['card']['visa']['selected'] = !current;
                      });
                    },
                  ),
                  paymentNameIconStructure(
                    cardName: "MasterCard",
                    paymentIcons:
                        "assets/payments/icons/mastercard${options['card']['mastercard']['selected'] ? '' : '_disabled'}.png",
                    onTap: () {
                      setState(() {
                        bool current =
                            options['card']['mastercard']['selected'];
                        options['card']['mastercard']['selected'] = !current;
                      });
                    },
                  ),
                ]),
            SizedBox(
              height: tablet ? hp(5) : wp(5),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  paymentNameIconStructure(
                    cardName: "Discover",
                    paymentIcons:
                        "assets/payments/icons/discover${options['card']['discover']['selected'] ? '' : '_disabled'}.png",
                    onTap: () {
                      setState(() {
                        bool current = options['card']['discover']['selected'];
                        options['card']['discover']['selected'] = !current;
                      });
                    },
                  ),
                  paymentNameIconStructure(
                    cardName: "Diner's Club",
                    paymentIcons:
                        "assets/payments/icons/diners${options['card']['dinersclub']['selected'] ? '' : '_disabled'}.png",
                    onTap: () {
                      setState(() {
                        bool current =
                            options['card']['dinersclub']['selected'];
                        options['card']['dinersclub']['selected'] = !current;
                      });
                    },
                  ),
                  paymentNameIconStructure(
                    cardName: "Maestro",
                    paymentIcons:
                        "assets/payments/icons/maestro${options['card']['maestro']['selected'] ? '' : '_disabled'}.png",
                    onTap: () {
                      setState(() {
                        bool current = options['card']['maestro']['selected'];
                        options['card']['maestro']['selected'] = !current;
                      });
                    },
                  ),
                ])
          ],
        );

        List<Widget> list = row1 + row2;

        var tabView = Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, children: list);

        return tablet ? tabView : mobView;
      }

      return Padding(
        padding: EdgeInsets.only(
            right: tablet ? hp(2) : wp(3),
            left: tablet ? hp() : wp(3),
            top: tablet ? hp(2) : wp(4),
            bottom: tablet ? hp(2) : wp(0)),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: tablet ? 0 : wp(2)),
              child: buildPaymentNameLogoStructure(
                paymentTypeName: "Card Payments",
                paymentTypeIcons: "assets/payments/icons/card_main.png",
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: tablet ? hp(2) : wp(5),
                  left: tablet ? hp(4) : wp(5),
                  top: tablet ? hp(2) : wp(3),
                  bottom: tablet ? hp(2) : wp(2)),
              child: mobTabView(),
            )
          ],
        ),
      );
    }

    Widget buildCardPayment() {
      return buildPaymentOptionsStructure(
          paymentTypeName: "Card Payments",
          paymentTypeIcons: "assets/payments/icons/card_main.png",
          row1: [
            paymentNameIconStructure(
              cardName: "RuPay",
              paymentIcons: "assets/payments/icons/rupay.png",
            ),
            //SizedBox(width: wp(20),),
            paymentNameIconStructure(
              cardName: "Visa",
              paymentIcons: "assets/payments/icons/visa.png",
            ),
            //SizedBox(width: wp(18),),
            paymentNameIconStructure(
              cardName: "MasterCard",
              paymentIcons: "assets/payments/icons/mastercard.png",
            ),
          ],
          row2: [
            paymentNameIconStructure(
              cardName: "Discover",
              paymentIcons: "assets/payments/icons/discover.png",
            ),
            paymentNameIconStructure(
              cardName: "Diner's Club",
              paymentIcons: "assets/payments/icons/diners.png",
            ),
            paymentNameIconStructure(
              cardName: "Maestro",
              paymentIcons: "assets/payments/icons/maestro.png",
            ),
          ]);
    }

    Widget buildCashTendering() {
      var mobView = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          buildPaymentNameLogoStructure(
            paymentTypeName: "Cash",
            paymentTypeIcons:
                "assets/payments/icons/cash${options['cash']['cash']['selected'] ? '_main' : '_disabled'}.png",
            onTap: () {
              setState(() {
                bool current = options['cash']['cash']['selected'];
                options['cash']['cash']['selected'] = !current;
              });
            },
          ),
          Container(
            child: buildPaymentNameLogoStructure(
              paymentTypeName: "Tendering",
              paymentTypeIcons:
                  "assets/payments/icons/Tendering${options['cash']['tendering']['selected'] ? 'On' : 'On'}.png",
              onTap: () {
                setState(() {
                  bool current = options['cash']['tendering']['selected'];
                  options['cash']['tendering']['selected'] = !current;
                });
              },
            ),
          ),
        ],
      );

      var tabView = buildPaymentOptionsStructure(
          paymentTypeName: "Cash",
          paymentTypeIcons: "assets/payments/icons/cash_main.png",
          row1: [
            Container(
              margin: EdgeInsets.only(left: hp(7)),
              child: paymentNameIconStructure(
                cardName: "Tendering",
                paymentIcons: "assets/payments/icons/TenderingOn.png",
              ),
            ),
          ]);

      return Padding(
          padding: EdgeInsets.only(
              right: tablet ? hp(0) : wp(8),
              left: tablet ? hp(0) : wp(5),
              top: tablet ? hp(0) : wp(2.5),
              bottom: tablet ? hp(0) : wp(2.5)),
          child: tablet ? tabView : mobView);
    }

    Widget buildEMI() {
      var mobEMIView = buildPaymentNameLogoStructure(
        paymentTypeName: "EMI",
        paymentTypeIcons:
            "assets/payments/icons/emi${options['emi']['emi']['selected'] ? '' : '_disabled'}.png",
        onTap: () {
          setState(() {
            bool current = options['emi']['emi']['selected'];
            options['emi']['emi']['selected'] = !current;
          });
        },
      );

      var tabEMIView = buildPaymentOptionsStructure(
          paymentTypeName: "EMI",
          paymentTypeIcons:
              "assets/payments/icons/emi${options['emi']['emi']['selected'] ? '' : '_disabled'}.png",
          onTap: () {
            setState(() {
              bool current = options['emi']['emi']['selected'];
              options['emi']['emi']['selected'] = !current;
            });
          },
          row1: [
            Container(
              margin: EdgeInsets.only(left: hp(7)),
              child: paymentNameIconStructure(
                cardName: "EMI",
                paymentIcons:
                    "assets/payments/icons/emi${options['emi']['emi']['selected'] ? '' : '_disabled'}.png",
                onTap: () {
                  setState(() {
                    bool current = options['emi']['emi']['selected'];
                    options['emi']['emi']['selected'] = !current;
                  });
                },
              ),
            )
          ]);

      return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: tablet ? hp(0) : wp(5), vertical: hp(1.2)),
          child: tablet ? tabEMIView : mobEMIView);
    }

    Widget buildCashEmiWidgetForTablet() {
      return Row(
        children: <Widget>[
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(child: Container(child: buildCashTendering())),
            ],
          )),
          Container(
              height: tablet ? hp(18) : wp(18),
              child: VerticalDivider(color: AppColors.Black)),
          Expanded(child: Container(child: buildEMI())),
          SizedBox(
            width: hp(3),
          )
        ],
      );
    }

    Widget buildCashPOS() {
      return buildPaymentOptionsStructure(
        paymentTypeName: "Cash@POS",
        paymentTypeIcons: "assets/payments/icons/cashpos.png",
        row1: [
          paymentNameIconStructure(
            cardName: "RuPay",
            paymentIcons:
                "assets/payments/icons/rupay${options['cashpos']['one']['selected'] ? '' : '_disabled'}.png",
            onTap: () {
              setState(() {
                bool current = options['cashpos']['one']['selected'];
                options['cashpos']['one']['selected'] = !current;
              });
            },
          ),
          paymentNameIconStructure(
            cardName: "Visa",
            paymentIcons:
                "assets/payments/icons/visa${options['cashpos']['two']['selected'] ? '' : '_disabled'}.png",
            onTap: () {
              setState(() {
                bool current = options['cashpos']['two']['selected'];
                options['cashpos']['two']['selected'] = !current;
              });
            },
          ),
          paymentNameIconStructure(
            cardName: "MasterCard",
            paymentIcons:
                "assets/payments/icons/mastercard${options['cashpos']['three']['selected'] ? '' : '_disabled'}.png",
            onTap: () {
              setState(() {
                bool current = options['cashpos']['three']['selected'];
                options['cashpos']['three']['selected'] = !current;
              });
            },
          ),
        ],
      );
      //return tablet ? tabCashPOSView : mobCashPOSView;
    }

    Widget buildDigitalWallet() {
      return buildPaymentOptionsStructure(
          paymentTypeName: "Digital Wallet",
          paymentTypeIcons: "assets/payments/icons/wallets.png",
          row1: [
            paymentNameIconStructure(
              cardName: "Citrus",
              paymentIcons:
                  "assets/payments/icons/citrus${options['wallet']['citrus']['selected'] ? '' : '_disabled'}.png",
              onTap: () {
                setState(() {
                  bool current = options['wallet']['citrus']['selected'];
                  options['wallet']['citrus']['selected'] = !current;
                });
              },
            ),
            paymentNameIconStructure(
              cardName: "Freecharge",
              paymentIcons:
                  "assets/payments/icons/freecharge${options['wallet']['freecharge']['selected'] ? '' : '_disabled'}.png",
              onTap: () {
                setState(() {
                  bool current = options['wallet']['freecharge']['selected'];
                  options['wallet']['freecharge']['selected'] = !current;
                });
              },
            ),
            paymentNameIconStructure(
              cardName: "m-Pesa",
              paymentIcons:
                  "assets/payments/icons/mpesa${options['wallet']['mpesa']['selected'] ? '' : '_disabled'}.png",
              onTap: () {
                setState(() {
                  bool current = options['wallet']['mpesa']['selected'];
                  options['wallet']['mpesa']['selected'] = !current;
                });
              },
            ),
          ],
          row2: [
            paymentNameIconStructure(
              cardName: "Mobikwik",
              paymentIcons:
                  "assets/payments/icons/mobikwik${options['wallet']['mobikwik']['selected'] ? '' : '_disabled'}.png",
              onTap: () {
                setState(() {
                  bool current = options['wallet']['mobikwik']['selected'];
                  options['wallet']['mobikwik']['selected'] = !current;
                });
              },
            ),
            paymentNameIconStructure(
              cardName: "OLA Money",
              paymentIcons:
                  "assets/payments/icons/olamoney${options['wallet']['olamoney']['selected'] ? '' : '_disabled'}.png",
              onTap: () {
                setState(() {
                  bool current = options['wallet']['olamoney']['selected'];
                  options['wallet']['olamoney']['selected'] = !current;
                });
              },
            ),
            paymentNameIconStructure(
              cardName: "Pockets",
              paymentIcons:
                  "assets/payments/icons/pockets${options['wallet']['pockets']['selected'] ? '' : '_disabled'}.png",
              onTap: () {
                setState(() {
                  bool current = options['wallet']['pockets']['selected'];
                  options['wallet']['pockets']['selected'] = !current;
                });
              },
            ),
          ]);
    }

    Widget buildCheque() {
      var mobCheckView = Padding(
        padding: EdgeInsets.symmetric(
            horizontal: tablet ? hp(5) : wp(5), vertical: hp(1.3)),
        child: buildPaymentNameLogoStructure(
          paymentTypeName: "Cheque",
          paymentTypeIcons:
              "assets/payments/icons/cheque${options['other']['cheque']['selected'] ? '' : '_disabled'}.png",
          onTap: () {
            setState(() {
              bool current = options['other']['cheque']['selected'];
              options['other']['cheque']['selected'] = !current;
            });
          },
        ),
      );

      var tabletCheckView = paymentNameIconStructure(
        cardName: "Cheque",
        paymentIcons:
            "assets/payments/icons/cheque${options['other']['cheque']['selected'] ? '' : '_disabled'}.png",
        onTap: () {
          setState(() {
            bool current = options['other']['cheque']['selected'];
            options['other']['cheque']['selected'] = !current;
          });
        },
      );

      return tablet ? tabletCheckView : mobCheckView;
    }

    Widget buildSplit() {
      var mobSplitView = Padding(
        padding: EdgeInsets.symmetric(
            horizontal: tablet ? hp(0) : wp(5), vertical: hp(1.2)),
        child: buildPaymentNameLogoStructure(
          paymentTypeName: "Split",
          paymentTypeIcons:
              "assets/payments/icons/split${options['other']['split']['selected'] ? '' : '_disabled'}.png",
          onTap: () {
            setState(() {
              bool current = options['other']['split']['selected'];
              options['other']['split']['selected'] = !current;
            });
          },
        ),
      );

      var tabletSplitView = paymentNameIconStructure(
        cardName: "Split",
        paymentIcons:
            "assets/payments/icons/split${options['other']['split']['selected'] ? '' : '_disabled'}.png",
        onTap: () {
          setState(() {
            bool current = options['other']['split']['selected'];
            options['other']['split']['selected'] = !current;
          });
        },
      );

      return tablet ? tabletSplitView : mobSplitView;
    }

    Widget buildUPI() {
      return buildPaymentOptionsStructure(
        paymentTypeName: "",
        paymentTypeIcons: "assets/payments/icons/upi_main.png",
        row1: [
          paymentNameIconStructure(
            cardName: "UPI",
            paymentIcons:
                "assets/payments/icons/upi_payments${options['upi']['upi']['selected'] ? '' : '_disabled'}.png",
            onTap: () {
              setState(() {
                bool current = options['upi']['upi']['selected'];
                options['upi']['upi']['selected'] = !current;
              });
            },
          ),
          paymentNameIconStructure(
            cardName: "UPI QR",
            paymentIcons:
                "assets/payments/icons/upiqr${options['upi']['upiqr']['selected'] ? '' : '_disabled'}.png",
            onTap: () {
              setState(() {
                bool current = options['upi']['upiqr']['selected'];
                options['upi']['upiqr']['selected'] = !current;
                print(options['upi']['upiqr']['selected']);
              });
            },
          ),
        ],
      );
      //return tablet ? tabUPIView : mobUPIView;
    }

    Widget buildOtherForTablet() {
      return buildPaymentOptionsStructure(
        paymentTypeName: "Others",
        paymentTypeIcons: "assets/payments/icons/others.png",
        row1: [
          paymentNameIconStructure(
            cardName: "Cheque",
            paymentIcons: "assets/payments/icons/cheque.png",
          ),
          paymentNameIconStructure(
            cardName: "Aadhaar Pay",
            paymentIcons: "assets/payments/icons/aadhaarpay_disabled.png",
          ),
          paymentNameIconStructure(
            cardName: "Split",
            paymentIcons: "assets/payments/icons/split_disabled.png",
          ),
        ],
      );
    }

    Widget buildPaymentOptions() {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            tablet ? buildCardPayment() : SizedBox(),
            tablet ? SizedBox() : buildCardPaymentOptions(),
            buildDivider(),
            tablet ? buildCashEmiWidgetForTablet() : buildCashTendering(),
            buildDivider(),
            buildCashPOS(),
            buildDivider(),
            tablet ? SizedBox() : buildCheque(),
            tablet ? SizedBox() : buildDivider(),
            buildDigitalWallet(),
            buildDivider(),
            tablet ? SizedBox() : buildEMI(),
            tablet ? SizedBox() : buildDivider(),
            tablet ? SizedBox() : buildSplit(),
            tablet ? SizedBox() : buildDivider(),
            buildUPI(),
            buildDivider(),
            tablet ? buildOtherForTablet() : SizedBox()
          ],
        ),
      );
    }

    return buildPaymentOptions();
  }
}
