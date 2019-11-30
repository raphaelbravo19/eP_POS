import 'package:epaisa_pos/src/models/OrderItem.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/remove_over_scroll_glow.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/payments/widgets/transaction_details.dart';
import 'package:epaisa_pos/src/views/transactions/views/credit_note_dialog.dart';
import 'package:epaisa_pos/src/views/transactions/views/exchange_dialog.dart';
import 'package:epaisa_pos/src/views/transactions/views/send_receipt_dialog.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/buttons/epaisa_button.dart';
import 'package:epaisa_pos/src/widgets/epaisa/epaisa_checkbox.dart';
import 'package:epaisa_pos/src/widgets/textfields/texfield_number.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:flutter/material.dart';

class PartialRefundDialog extends StatefulWidget {
  PartialRefundDialog({
    Key key,
  }) : super(key: key);

  @override
  PartialRefundDialogState createState() => PartialRefundDialogState();
}

class PartialRefundDialogState extends State<PartialRefundDialog> {
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
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Invoice No. 45612",
                    style: TextStyle(
                        fontSize: tablet ? hp(3) : wp(5.6),
                        fontWeight: FontWeight.w700,
                        color: AppColors.DarkGray),
                  ),
                ),
              ),
              Padding(
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
                      ))),
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
          // discount: Discount(calculated: '14.50', type: '%', value: '10'),
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
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: hp(0.2)),
        padding: EdgeInsets.symmetric(horizontal: wp(4), vertical: hp(1.1)),
        height: wp(34),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            width: 1,
            color: AppColors.DisabledBorder,
          ),
        )),
        child: ScrollConfiguration(
          behavior: RemoveOverScrollGlow(),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    // horizontal: hp(2),
                    vertical: hp(0.5),
                  ),
                  child: Row(
                    children: <Widget>[
                      // Expanded(
                      //   flex: 0,
                      //   child: Container(),
                      // ),

                      Expanded(
                        flex: 20,
                        child: Container(
                          // color: Colors.yellow,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: hp(2)),
                          // color: Colors.red,
                          child: Text(
                            'Qty',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: hp(1.9),
                              color: AppColors.BackPrimaryGray,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 45,
                        child: Container(
                          // color: Colors.blue,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Description',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: hp(1.9),
                                color: AppColors.BackPrimaryGray),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 35,
                        child: Container(
                          // color: Colors.red,
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Price',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: hp(1.9),
                              color: AppColors.BackPrimaryGray,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ...products.map((i) {
                  var quantity = int.parse(i.quantity);
                  return Row(
                    children: <Widget>[
                      Expanded(
                        flex: 20,
                        child: Container(
                          // color: Colors.yellow,
                          // width: hp(2),
                          //height: hp(2.6),
                          padding: EdgeInsets.only(top: hp(0.5)),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: quantity > 1
                                      ? EpaisaButtonBox(
                                          size: hp(2.2),
                                          hp: hp,
                                          icon: Icons.remove,
                                        )
                                      : EpaisaCheckBox(
                                          size: hp(2.2),
                                          hp: hp,
                                        ),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      i.quantity,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: hp(1.9),
                                        color: AppColors.BackPrimaryGray,
                                      ),
                                    ),
                                  ),
                                ),
                                if (quantity > 1)
                                  Container(
                                    margin: EdgeInsets.only(right: hp(1)),
                                    child: EpaisaButtonBox(
                                      size: hp(2.2),
                                      hp: hp,
                                      icon: Icons.add,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 80,
                        child: OrderTableItem(
                          hp: hp,
                          description: i.description,
                          price: i.price,
                          quantity: i.quantity,
                          discount: i.discount,
                          customOrder: {
                            // "first": {"column": 'quantity', "flex": 10},
                            "second": {"column": 'description', "flex": 45},
                            "third": {"column": 'price', "flex": 35},
                          },
                        ),
                      )
                    ],
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
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFEBEBEB),
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(vertical: hp(1)),
                            child: Text(
                              eptxt('total_refund'),
                              style: TextStyle(
                                color: AppColors.BackPrimaryGray,
                                fontSize: wp(3.5),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: hp(2)),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(hp(0.8)),
                              border: Border.all(
                                color: AppColors.BackPrimaryGray,
                                width: 0.5,
                              ),
                            ),
                            child: Text(
                              '₹ 300.30',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: AppColors.PrimaryBlue,
                                fontSize: wp(8),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: hp(1)),
                            child: Text(
                              'Reason for Refund',
                              style: TextStyle(
                                color: AppColors.BackPrimaryGray,
                                fontSize: wp(3.5),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
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
                            child: new OutlineInput(hp: hp, wp: wp),
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
                                title: 'EXCHANGE',
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.PrimaryBlue,
                                  fontSize: tablet ? hp(1.8) : wp(3.2),
                                ),
                                onPress: () {
                                  Navigator.of(context).pushReplacement(
                                    PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder:
                                          (BuildContext context, _, __) {
                                        return ExchangeDialog();
                                      },
                                    ),
                                  );
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
                              // padding: EdgeInsets.only(left: hp(1)),
                              child: EpaisaButton.withBorder(
                                title: 'CASH',
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.PrimaryBlue,
                                  fontSize: tablet ? hp(1.8) : wp(3.2),
                                ),
                                onPress: () {},
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

class OutlineInput extends StatelessWidget {
  const OutlineInput({
    Key key,
    @required this.hp,
    @required this.wp,
    this.tablet = false,
  }) : super(key: key);

  final Function hp;
  final Function wp;
  final bool tablet;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
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
            fontSize: tablet ? hp(2) : wp(3.2),
            fontWeight: FontWeight.w600,
          ),
        ),
        style: TextStyle(
          color: AppColors.DisabledText,
          fontSize: tablet ? hp(2.4) : wp(3.2),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class SmallCheckWithLabel extends StatelessWidget {
  SmallCheckWithLabel({
    Key key,
    @required this.hp,
    @required this.tablet,
    @required this.wp,
    @required this.label,
  }) : super(key: key);

  final Function hp;
  final bool tablet;
  final Function wp;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: hp(1)),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: hp(tablet ? 1 : 2)),
            child: EpaisaCheckBox(
              hp: hp,
              tablet: tablet,
              size: hp(2),
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: AppColors.BackPrimaryGray,
              fontSize: tablet ? hp(1.8) : wp(3.2),
              fontWeight: FontWeight.w700,
            ),
          )
        ],
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
