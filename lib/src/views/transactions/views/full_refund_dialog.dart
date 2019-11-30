import 'package:epaisa_pos/src/models/OrderItem.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/remove_over_scroll_glow.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/payments/widgets/transaction_details.dart';
import 'package:epaisa_pos/src/views/transactions/views/credit_note_dialog.dart';
import 'package:epaisa_pos/src/views/transactions/views/partial_refund_dialog.dart';
import 'package:epaisa_pos/src/views/transactions/views/send_receipt_dialog.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/buttons/epaisa_button.dart';
import 'package:epaisa_pos/src/widgets/epaisa/epaisa_checkbox.dart';
import 'package:epaisa_pos/src/widgets/textfields/texfield_number.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:flutter/material.dart';

class FullRefundDialog extends StatefulWidget {
  FullRefundDialog({
    Key key,
  }) : super(key: key);

  @override
  FullRefundDialogState createState() => FullRefundDialogState();
}

class FullRefundDialogState extends State<FullRefundDialog> {
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

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    Widget header() {
      return Container(
          padding: EdgeInsets.symmetric(vertical: hp(2)),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: AppColors.LightGray, width: 2.5))),
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Container(
                      // color: Colors.red,
                      alignment: Alignment.center,
                      child: Text(
                        "Invoice No. 45612",
                        style: TextStyle(
                          fontSize: tablet ? hp(3) : wp(5.6),
                          fontWeight: FontWeight.w700,
                          color: AppColors.DarkGray,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: -hp(0.5),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: wp(2)),
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
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ));
    }

    Widget productdetails() {
      final List<OrderItem> products = [
        OrderItem(
          description: 'Heinz Ketchup',
          price: '145.00',
          quantity: '1',
        ),
        OrderItem(
          description: 'Custom Product 2',
          price: '145.00',
          quantity: '1',
          discount: Discount(calculated: '14.50', type: '%', value: '10'),
        ),
        OrderItem(
          description: 'Custom Product 3',
          price: '145.00',
          quantity: '3',
        ),
        OrderItem(
          description: 'Custom Product 3',
          price: '145.00',
          quantity: '3',
        ),
      ];

      return Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.only(top: hp(0.2)),
        padding: EdgeInsets.symmetric(horizontal: wp(4), vertical: hp(1.1)),
        height: wp(32),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(width: 1, color: AppColors.DisabledBorder),
        )),
        child: ScrollConfiguration(
          behavior: RemoveOverScrollGlow(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  // color: Colors.red,
                  padding: EdgeInsets.symmetric(
                    // horizontal: hp(2),
                    vertical: hp(0.5),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 15,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Qty',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: hp(1.9),
                                color: AppColors.BackPrimaryGray),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 50,
                        child: Text(
                          'Description',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: hp(1.9),
                              color: AppColors.BackPrimaryGray),
                        ),
                      ),
                      Expanded(
                        flex: 35,
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Price',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: hp(1.9),
                                color: AppColors.BackPrimaryGray),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ...products.map((i) {
                  return OrderTableItem(
                    hp: hp,
                    description: i.description,
                    price: i.price,
                    quantity: i.quantity,
                    discount: i.discount,
                    quantityLeft: true,
                    customOrder: {
                      "first": {"column": 'quantity', "flex": 15},
                      "second": {"column": 'description', "flex": 50},
                      "third": {"column": 'price', "flex": 35},
                    },
                  );
                }).toList()
              ],
            ),
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
              Container(
                child: Column(
                  children: <Widget>[
                    HeadingWithBorder(
                      hp: hp,
                      wp: wp,
                      title: 'Select product(s) for refund',
                    ),
                    productdetails(),
                    HeadingWithBorder(
                      hp: hp,
                      wp: wp,
                      title: 'Reason for Refund',
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: (hp(2)), vertical: hp(1)),
                      child: Column(
                        children: <Widget>[
                          SmallCheckWithLabel(
                            hp: hp,
                            tablet: tablet,
                            wp: wp,
                            label: 'Returned Goods',
                          ),
                          SmallCheckWithLabel(
                            hp: hp,
                            tablet: tablet,
                            wp: wp,
                            label: 'Accidental Charge',
                          ),
                          SmallCheckWithLabel(
                            hp: hp,
                            tablet: tablet,
                            wp: wp,
                            label: 'Cancelled Order',
                          ),
                          SmallCheckWithLabel(
                            hp: hp,
                            tablet: tablet,
                            wp: wp,
                            label: 'Other',
                          ),
                          Container(
                            padding: EdgeInsets.only(left: hp(4)),
                            height: hp(5),
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  gapPadding: 0,
                                ),
                                contentPadding: EdgeInsets.all(
                                  hp(1.5),
                                ),
                                hintText: 'Other reason',
                                hintStyle: TextStyle(
                                  color: AppColors.DisabledText,
                                  fontSize: wp(3.2),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: TextStyle(
                                color: AppColors.DisabledText,
                                fontSize: wp(3.2),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(hp(2)),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(right: hp(1)),
                              child: EpaisaButton.withBorder(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.PrimaryBlue,
                                  fontSize: tablet ? hp(1.8) : wp(3.2),
                                ),
                                title: 'CREDIT NOTE',
                                onPress: () {
                                  Navigator.of(context)
                                      .pushReplacement(PageRouteBuilder(
                                    opaque: false,
                                    pageBuilder: (BuildContext context, _, __) {
                                      return CreditNoteDialog();
                                    },
                                  ));
                                },
                                borderColor: AppColors.PrimaryBlue,
                                borderRadius: BorderRadius.circular(
                                  hp(1.5),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: hp(2)),
                              child: EpaisaButton.withBorder(
                                title: 'CASH',
                                onPress: () {},
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.PrimaryBlue,
                                  fontSize: tablet ? hp(1.8) : wp(3.2),
                                ),
                                borderColor: AppColors.PrimaryBlue,
                                borderRadius: BorderRadius.circular(
                                  hp(1.5),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
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

class HeadingWithBorder extends StatelessWidget {
  const HeadingWithBorder({
    Key key,
    @required this.hp,
    @required this.wp,
    @required this.title,
  }) : super(key: key);

  final Function hp;
  final Function wp;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: hp(4.8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFEBEBEB),
            width: 0.5,
          ),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.BackPrimaryGray,
          fontSize: wp(3.5),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
