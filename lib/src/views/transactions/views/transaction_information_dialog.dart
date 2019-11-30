import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/remove_over_scroll_glow.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/transactions/views/full_refund_dialog.dart';
import 'package:epaisa_pos/src/views/transactions/views/partial_refund_dialog.dart';
import 'package:epaisa_pos/src/views/transactions/views/send_receipt_dialog.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:flutter/material.dart';

class TransactionInformationDialog extends StatefulWidget {
  TransactionInformationDialog({
    Key key,
  }) : super(key: key);

  @override
  TransactionInformationDialogState createState() =>
      TransactionInformationDialogState();
}

class TransactionInformationDialogState
    extends State<TransactionInformationDialog> {
  bool showModal = true;
  bool resendDisabled = true;
  @override
  void initState() {
    super.initState();
  }

  void closeModal() {
    Navigator.of(context).pop();
    setState(() {
      showModal = false;
    });
  }

  void _showSendReceipt(BuildContext context) {
    // flutter defined function
    Navigator.of(context).push(new PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return SendReceiptDialog();
      },
    ));
  }

  void _showFullRefund(BuildContext context) {
    // flutter defined function
    Navigator.of(context).push(new PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return FullRefundDialog();
      },
    ));
  }

  void _showPartialRefund(BuildContext context) {
    // flutter defined function
    Navigator.of(context).push(new PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return PartialRefundDialog();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    Widget header() {
      return Container(
          padding: EdgeInsets.fromLTRB(wp(3), hp(0.5), 0, hp(1)),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: AppColors.LightGray, width: 2.5))),
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, hp(0.8), 0, 0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: hp(6),
                        width: hp(6),
                        child:
                            Image.asset("assets/payments/icons/card_main.png"),
                      ),
                      SizedBox(
                        width: wp(3),
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            eptxt('card_payment'),
                            style: TextStyle(
                                fontSize: tablet ? hp(3) : wp(5.6),
                                fontWeight: FontWeight.w700,
                                color: AppColors.DarkGray),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(wp(2)),
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showModal = false;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Image.asset(
                        "assets/general_icons/xbutton.png",
                        height: tablet ? hp(2.5) : wp(4.3),
                      ))),
            ],
          ));
    }

    Widget details() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: wp(3), vertical: hp(1.3)),
        alignment: Alignment.center,
        child: Row(
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Invoice No.",
                    style: TextStyle(
                        fontSize: tablet ? hp(3) : wp(3.6),
                        fontWeight: FontWeight.w700,
                        color: AppColors.DarkGray.withOpacity(0.95)),
                  ),
                  SizedBox(
                    height: hp(0.7),
                  ),
                  Text(
                    "Payment ID",
                    style: TextStyle(
                        fontSize: tablet ? hp(3) : wp(3.6),
                        fontWeight: FontWeight.w700,
                        color: AppColors.DarkGray.withOpacity(0.95)),
                  ),
                  SizedBox(
                    height: hp(0.7),
                  ),
                  Text(
                    eptxt('transaction_id'),
                    style: TextStyle(
                        fontSize: tablet ? hp(3) : wp(3.6),
                        fontWeight: FontWeight.w700,
                        color: AppColors.DarkGray.withOpacity(0.95)),
                  ),
                  SizedBox(
                    height: hp(0.7),
                  ),
                  Text(
                    "Card No.",
                    style: TextStyle(
                        fontSize: tablet ? hp(3) : wp(3.6),
                        fontWeight: FontWeight.w700,
                        color: AppColors.DarkGray.withOpacity(0.95)),
                  ),
                  SizedBox(
                    height: hp(0.7),
                  ),
                  Text(
                    "Date",
                    style: TextStyle(
                        fontSize: tablet ? hp(3) : wp(3.6),
                        fontWeight: FontWeight.w700,
                        color: AppColors.DarkGray.withOpacity(0.95)),
                  ),
                  SizedBox(
                    height: hp(0.7),
                  ),
                  Text(
                    "Time",
                    style: TextStyle(
                        fontSize: tablet ? hp(3) : wp(3.6),
                        fontWeight: FontWeight.w700,
                        color: AppColors.DarkGray.withOpacity(0.95)),
                  ),
                  SizedBox(
                    height: hp(0.7),
                  ),
                  Text(
                    "Status",
                    style: TextStyle(
                        fontSize: tablet ? hp(3) : wp(3.6),
                        fontWeight: FontWeight.w700,
                        color: AppColors.DarkGray.withOpacity(0.95)),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: wp(4),
            ),
            Container(
              child: Column(
                children: List.generate(7, (index) {
                  Widget data = Container(
                      margin: EdgeInsets.only(top: index == 0 ? 0 : hp(0.7)),
                      child: Text(
                        ":",
                        style: TextStyle(
                            fontSize: tablet ? hp(3) : wp(3.6),
                            fontWeight: FontWeight.w600,
                            color: AppColors.DarkGray),
                      ));
                  return data;
                }),
              ),
            ),
            SizedBox(
              width: wp(6),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "45612",
                    style: TextStyle(
                        fontSize: tablet ? hp(3) : wp(3.6),
                        fontWeight: FontWeight.w600,
                        color: AppColors.DarkGray.withOpacity(0.95)),
                  ),
                  SizedBox(
                    height: hp(0.7),
                  ),
                  Text(
                    "7984654",
                    style: TextStyle(
                        fontSize: tablet ? hp(3) : wp(3.6),
                        fontWeight: FontWeight.w600,
                        color: AppColors.DarkGray.withOpacity(0.95)),
                  ),
                  SizedBox(
                    height: hp(0.7),
                  ),
                  Text(
                    "11:05 AM",
                    style: TextStyle(
                        fontSize: tablet ? hp(3) : wp(3.6),
                        fontWeight: FontWeight.w600,
                        color: AppColors.DarkGray.withOpacity(0.95)),
                  ),
                  SizedBox(
                    height: hp(0.7),
                  ),
                  Text(
                    "XXXX XXXX XXXX 6544",
                    style: TextStyle(
                        fontSize: tablet ? hp(3) : wp(3.6),
                        fontWeight: FontWeight.w600,
                        color: AppColors.DarkGray.withOpacity(0.95)),
                  ),
                  SizedBox(
                    height: hp(0.7),
                  ),
                  Text(
                    "12 May 2018",
                    style: TextStyle(
                        fontSize: tablet ? hp(3) : wp(3.6),
                        fontWeight: FontWeight.w600,
                        color: AppColors.DarkGray.withOpacity(0.95)),
                  ),
                  SizedBox(
                    height: hp(0.7),
                  ),
                  Text(
                    "11:05 AM",
                    style: TextStyle(
                        fontSize: tablet ? hp(3) : wp(3.6),
                        fontWeight: FontWeight.w600,
                        color: AppColors.DarkGray.withOpacity(0.95)),
                  ),
                  SizedBox(
                    height: hp(0.7),
                  ),
                  Text("Approved",
                      style: TextStyle(
                        fontSize: tablet ? hp(3) : wp(3.6),
                        fontWeight: FontWeight.w600,
                        color: TransactionColors.Approved,
                      ))
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget amountpaid() {
      return Container(
        margin: EdgeInsets.only(top: hp(0.2)),
        padding: EdgeInsets.symmetric(horizontal: wp(4), vertical: hp(1.1)),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1, color: AppColors.DisabledBorder),
                top: BorderSide(width: 1, color: AppColors.DisabledBorder))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              eptxt('amount_paid'),
              style: TextStyle(
                  fontSize: tablet ? hp(3) : wp(4.7),
                  fontWeight: FontWeight.w700,
                  color: AppColors.DarkGray),
            ),
            Text(
              "₹570.00",
              style: TextStyle(
                  fontSize: tablet ? hp(3) : wp(4.7),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.1,
                  color: AppColors.PrimaryBlue),
            ),
          ],
        ),
      );
    }

    Widget saledetails() {
      return Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(top: hp(0.2)),
        padding: EdgeInsets.symmetric(horizontal: wp(3), vertical: hp(1.1)),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(width: 1, color: AppColors.DisabledBorder),
        )),
        child: Text(
          "Sale Details",
          style: TextStyle(
              fontSize: tablet ? hp(3) : wp(3.5),
              fontWeight: FontWeight.w700,
              color: AppColors.DarkGray.withOpacity(0.9)),
        ),
      );
    }

    Widget productdetails() {
      List<Map<String, dynamic>> products = [
        {
          "sale": "1",
          "name": "Heinz Ketchup",
          "total": "148.50",
        },
        {
          "sale": "1",
          "name": "Parle 50-50",
          "total": "100.50",
          "discount": "10"
        },
        {
          "sale": "3",
          "name": "Heinz Ketchup",
          "total": "275.50",
        },
      ];

      return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: hp(0.2)),
          padding: EdgeInsets.symmetric(horizontal: wp(4), vertical: hp(1.1)),
          height: wp(25.2),
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(width: 1, color: AppColors.DisabledBorder),
          )),
          child: ScrollConfiguration(
            behavior: RemoveOverScrollGlow(),
            child: SingleChildScrollView(
              child: Column(
                  children: List.generate(products.length, (index) {
                return Container(
                  margin: EdgeInsets.only(top: index == 0 ? 0 : hp(0.7)),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Text(products[index]["sale"],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: tablet ? hp(3) : wp(3.4),
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.DarkGray)),
                          ),
                          SizedBox(
                            width: wp(2.5),
                          ),
                          Expanded(
                            flex: 20,
                            child: Text(products[index]["name"],
                                style: TextStyle(
                                    fontSize: tablet ? hp(3) : wp(3.4),
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.DarkGray)),
                          ),
                          Expanded(
                            flex: 8,
                            child: Text("₹ ${products[index]["total"]}",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: tablet ? hp(3) : wp(3.4),
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.2,
                                    color: AppColors.PrimaryBlue)),
                          ),
                        ],
                      ),
                      products[index]["discount"] != null
                          ? Container(
                              margin: EdgeInsets.only(top: hp(0.7)),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Container(),
                                  ),
                                  SizedBox(
                                    width: wp(2.5),
                                  ),
                                  Expanded(
                                    flex: 20,
                                    child: Text(
                                        "— DISCOUNT @ ${products[index]["discount"]}",
                                        style: TextStyle(
                                            fontSize: tablet ? hp(3) : wp(3.2),
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.DiscountText)),
                                  ),
                                  Expanded(
                                    flex: 8,
                                    child: Text(
                                        "₹ ${double.parse(products[index]["discount"]) * double.parse(products[index]["total"]) / 100}%",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize: tablet ? hp(3) : wp(3.2),
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.2,
                                            color: AppColors.DiscountText)),
                                  ),
                                ],
                              ))
                          : Container(),
                    ],
                  ),
                );
              })),
            ),
          ));
    }

    Widget totaldetails() {
      return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: hp(0.2)),
        padding: EdgeInsets.symmetric(horizontal: wp(4), vertical: hp(0.5)),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(width: 1, color: AppColors.DisabledBorder),
        )),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: hp(0.4)),
              child: Row(
                children: <Widget>[
                  Spacer(
                    flex: 2,
                  ),
                  SizedBox(
                    width: wp(2),
                  ),
                  Expanded(
                    flex: 20,
                    child: Text("Sub Total",
                        style: TextStyle(
                            fontSize: tablet ? hp(3) : wp(3.3),
                            fontWeight: FontWeight.w700,
                            color: AppColors.DarkGray)),
                  ),
                  Expanded(
                    flex: 8,
                    child: Text("₹ 548.50",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: tablet ? hp(3) : wp(3.3),
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.2,
                            color: AppColors.PrimaryBlue)),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: hp(0.4)),
              child: Row(
                children: <Widget>[
                  Spacer(
                    flex: 2,
                  ),
                  SizedBox(
                    width: wp(2),
                  ),
                  Expanded(
                    flex: 20,
                    child: Text("Discount",
                        style: TextStyle(
                            fontSize: tablet ? hp(3) : wp(3.3),
                            fontWeight: FontWeight.w700,
                            color: AppColors.DiscountText)),
                  ),
                  Expanded(
                    flex: 8,
                    child: Text("₹ 12.50",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: tablet ? hp(3) : wp(3.3),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.2,
                            color: AppColors.DiscountText)),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: hp(0.4)),
              child: Row(
                children: <Widget>[
                  Spacer(
                    flex: 2,
                  ),
                  SizedBox(
                    width: wp(2),
                  ),
                  Expanded(
                    flex: 20,
                    child: Text("SGST @ 9%",
                        style: TextStyle(
                            fontSize: tablet ? hp(3) : wp(3.3),
                            fontWeight: FontWeight.w700,
                            color: AppColors.DarkGray)),
                  ),
                  Expanded(
                    flex: 8,
                    child: Text("₹ 55.00",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: tablet ? hp(3) : wp(3.3),
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.2,
                            color: AppColors.PrimaryBlue)),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: hp(0.4)),
              child: Row(
                children: <Widget>[
                  Spacer(
                    flex: 2,
                  ),
                  SizedBox(
                    width: wp(2),
                  ),
                  Expanded(
                    flex: 20,
                    child: Text("CGST @ 9%",
                        style: TextStyle(
                            fontSize: tablet ? hp(3) : wp(3.3),
                            fontWeight: FontWeight.w700,
                            color: AppColors.DarkGray)),
                  ),
                  Expanded(
                    flex: 8,
                    child: Text("₹ 55.00",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: tablet ? hp(3) : wp(3.3),
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.2,
                            color: AppColors.PrimaryBlue)),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: hp(0.4)),
              child: Row(
                children: <Widget>[
                  Spacer(
                    flex: 2,
                  ),
                  SizedBox(
                    width: wp(2),
                  ),
                  Expanded(
                    flex: 20,
                    child: Text(eptxt('total_amount'),
                        style: TextStyle(
                            fontSize: tablet ? hp(3) : wp(3.3),
                            fontWeight: FontWeight.w700,
                            color: AppColors.DarkGray)),
                  ),
                  Expanded(
                    flex: 8,
                    child: Text("₹ 570.00",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: tablet ? hp(3) : wp(3.3),
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.2,
                            color: AppColors.PrimaryBlue)),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget buttonContainer() {
      return Opacity(
        opacity: 0.9,
        child: Container(
          padding: EdgeInsets.fromLTRB(wp(4), hp(1.1), wp(4), hp(2)),
          child: Column(
            children: <Widget>[
              Row(children: <Widget>[
                Expanded(
                  child: ButtonGradient(
                    borderRadius: 7,
                    shadowLevel: 2,
                    disabled: true,
                    fontSize: wp(3.8),
                    paddingVertical: hp(1.5),
                    fontWeight: FontWeight.w700,
                    textColor: AppColors.DarkGray,
                    title: "PRINT",
                    letterSpacing: 0,
                  ),
                ),
                SizedBox(
                  width: wp(3),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _showSendReceipt(context);
                    },
                    child: ButtonGradient(
                      borderRadius: 7,
                      shadowLevel: 2,
                      disabled: true,
                      fontSize: wp(3.8),
                      paddingVertical: hp(1.5),
                      fontWeight: FontWeight.w700,
                      textColor: AppColors.DarkGray,
                      title: "SEND",
                      letterSpacing: 0,
                    ),
                  ),
                )
              ]),
              SizedBox(
                height: hp(1.3),
              ),
              Row(children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _showPartialRefund(context);
                    },
                    child: ButtonGradient(
                      borderRadius: 7,
                      shadowLevel: 2,
                      disabled: true,
                      fontSize: wp(3.8),
                      paddingVertical: hp(1.5),
                      fontWeight: FontWeight.w700,
                      textColor: AppColors.DarkGray,
                      title: "PARTIAL REFUND",
                      letterSpacing: 0,
                    ),
                  ),
                ),
                SizedBox(
                  width: wp(3),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _showFullRefund(context);
                    },
                    child: ButtonGradient(
                      borderRadius: 7,
                      shadowLevel: 2,
                      disabled: true,
                      fontSize: wp(3.8),
                      paddingVertical: hp(1.5),
                      fontWeight: FontWeight.w700,
                      textColor: AppColors.DarkGray,
                      title: "FULL REFUND",
                      letterSpacing: 0,
                    ),
                  ),
                )
              ]),
            ],
          ),
        ),
      );
    }

    Widget content() {
      return Container(
        width: (tablet ? wp(42) : wp(95)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              header(),
              details(),
              amountpaid(),
              saledetails(),
              productdetails(),
              totaldetails(),
              buttonContainer()
            ]),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0),
      body: Container(
        alignment: Alignment.center,
        width: wp(100),
        height: hp(100),
        child: !showModal
            ? Container()
            : Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showModal = false;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: wp(100),
                      height: hp(100),
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                        width: (tablet ? wp(42) : wp(95)),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(),
                            ),
                            Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      tablet ? wp(1) : wp(3)),
                                  color: AppColors.PrimaryWhite,
                                ),
                                child: content()),
                            Expanded(
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  )
                ],
              ),
      ),
    );
  }
}
