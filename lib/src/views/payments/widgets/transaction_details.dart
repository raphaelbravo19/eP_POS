import 'package:epaisa_pos/src/models/OrderItem.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/views/cash_register/cash_register.dart';
import 'package:epaisa_pos/src/widgets/epaisa/epaisa_cart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionDetails extends StatefulWidget {
  final double height;
  final double expandHeight;
  final Discount discount;
  final String subTotal;
  final bool showMoreEnabled;
  final bool isTablet;
  final bool isExpanded;
  final bool showInvoice;
  final List<OrderItem> items;
  const TransactionDetails({
    Key key,
    this.height,
    this.showMoreEnabled = true,
    this.isTablet = false,
    this.items = const [],
    this.discount,
    this.subTotal,
    this.isExpanded = false,
    @required this.expandHeight,
    this.showInvoice = true,
  }) : super(key: key);

  @override
  _TransactionDetailsState createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  bool isExpanded = false;

  @override
  void initState() {
    if (widget.isExpanded != null) {
      setState(() {
        isExpanded = widget.isExpanded;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final tablet = widget.isTablet;
    return Container(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              blurRadius: 0.5,
              color: Colors.black54,
              offset: Offset.fromDirection(45),
              spreadRadius: 0.5,
            )
          ],
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: widget.height * (widget.isTablet ? 0.60 : 0.6),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromRGBO(235, 235, 235, 1),
                    width: 1,
                  ),
                ),
              ),
              child: Container(
                // padding: EdgeInsets.symmetric(horizontal: 20),
                // color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Expanded(
                    // flex: tablet ? 14 : 20,
                    // child:
                    Container(
                      // color: Colors.green,
                      padding: EdgeInsets.only(left: hp(2), right: hp(3)),
                      alignment: Alignment.center,
                      child: EpaisaCart(),
                    ),
                    // ),
                    Expanded(
                      flex: 50,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Abhishek Maurya',
                              style: TextStyle(
                                color: AppColors.BackPrimaryGray,
                                fontWeight: FontWeight.w600,
                                fontSize: tablet ? hp(2.5) : wp(4.4),
                              ),
                            ),
                            SizedBox(
                              height: hp(0.3),
                            ),
                            if (widget.showInvoice)
                              Text(
                                'Invoice No. 45612',
                                style: TextStyle(
                                  color: AppColors.BackPrimaryGray,
                                  fontWeight: FontWeight.w600,
                                  fontSize: tablet ? hp(1.8) : wp(3.6),
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 30,
                      child: Container(
                        margin: EdgeInsets.only(right: hp(2)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FittedBox(
                              child: Text(
                                '12 May 2018',
                                style: TextStyle(
                                  color: AppColors.BackPrimaryGray,
                                  fontWeight: FontWeight.w600,
                                  fontSize: tablet ? hp(1.9) : wp(3.6),
                                ),
                              ),
                            ),
                            FittedBox(
                              child: Text(
                                '10:42 AM',
                                style: TextStyle(
                                  color: AppColors.BackPrimaryGray,
                                  fontWeight: FontWeight.w600,
                                  fontSize: tablet ? hp(1.8) : wp(3.6),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 150),
              decoration: BoxDecoration(
                  // color: Colors.blue,
                  ),
              height: isExpanded ? widget.expandHeight : 0,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    OrderTableHeader(hp: hp, wp: wp),
                    Container(
                      padding: EdgeInsets.only(
                          left: tablet ? hp(2) : wp(1.7), right: hp(2)),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: AppColors.TextLightGray, width: 0.3),
                        ),
                      ),
                      child: Column(
                          children: List.generate(widget.items.length, (index) {
                        return OrderTableItem(
                          hp: hp,
                          description: widget.items[index].description,
                          price: widget.items[index].price,
                          sno: (index + 1).toString() + ".",
                          quantity: widget.items[index].quantity,
                          discount: widget.items[index].discount,
                        );
                      })),
                    ),
                    if (widget.subTotal != null || widget.discount != null)
                      Container(
                        padding: EdgeInsets.only(top: hp(0.5)),
                        child: Column(
                          children: <Widget>[
                            if (widget.subTotal != null)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: hp(2),
                                  vertical: hp(0.25),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 50,
                                      child: Text(
                                        eptxt('sub_total'),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.BackPrimaryGray,
                                          fontSize: hp(2.1),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 25,
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          '₹ ${widget.subTotal}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.PrimaryBlue,
                                            fontSize: hp(2.1),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            SizedBox(
                              height: hp(0.2),
                            ),
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
            Container(
              height: widget.height * (!widget.showMoreEnabled ? 0.25 : 0.35),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: widget.showMoreEnabled
                        ? AppColors.PrimaryBlue
                        : Colors.transparent,
                    width: 1,
                  ),
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: hp(2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      eptxt('total_amount'),
                      style: TextStyle(
                        color: AppColors.BackPrimaryGray,
                        fontWeight: FontWeight.bold,
                        fontSize: tablet ? hp(2.6) : wp(5.2),
                      ),
                    ),
                    Text(
                      '₹${(cashRegisterBloc.streamTotal.value).toStringAsFixed(2)}',
                      style: TextStyle(
                        color: AppColors.PrimaryBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: tablet ? hp(2.6) : wp(5.2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: hp(tablet ? 1 : 0),
            ),
            if (widget.showMoreEnabled)
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(top: wp(1.2)),
                  height: widget.height * 0.19,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'SHOW ${isExpanded ? "LESS" : "MORE"}',
                        style: TextStyle(
                          color: AppColors.PrimaryBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: wp(2.7),
                        ),
                      ),
                      SizedBox(
                        width: wp(0.7),
                      ),
                      Container(
                          child: Image.asset(
                        '${isExpanded ? "assets/payments/arrowup.png" : "assets/payments/arrowdw.png"}',
                        height: tablet ? hp(0) : wp(1.8),
                      )),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class OrderTableHeader extends StatelessWidget {
  const OrderTableHeader({
    Key key,
    @required this.hp,
    this.wp,
  }) : super(key: key);

  final Function hp;
  final Function wp;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: tablet ? hp(2) : wp(2),
        vertical: hp(0.5),
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.TextLightGray, width: 0.3),
          bottom: BorderSide(color: AppColors.TextLightGray, width: 0.3),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 15,
            child: Text(
              'S No.',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: tablet ? hp(1.9) : wp(3.6),
                  color: AppColors.BackPrimaryGray),
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
            flex: 25,
            child: Container(
              alignment: Alignment.center,
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
            flex: 25,
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
          SizedBox(
            width: wp(1.5),
          ),
        ],
      ),
    );
  }
}

class OrderTableItem extends StatelessWidget {
  final String sno;
  final String description;
  final String quantity;
  final String price;
  final Discount discount;
  final Map<String, dynamic> customOrder;
  const OrderTableItem({
    Key key,
    @required this.hp,
    @required this.sno,
    @required this.description,
    @required this.quantity,
    this.quantityLeft = false,
    this.price,
    this.discount,
    this.customOrder = const {
      "first": {"column": 'sno', "flex": 17},
      "second": {"column": 'description', "flex": 50},
      "third": {"column": 'quantity', "flex": 25},
      "fourth": {"column": 'price', "flex": 25}
    },
  }) : super(key: key);

  final Function hp;
  final bool quantityLeft;

  @override
  Widget build(BuildContext context) {
    final hp = ScreenUtils.of(context).hp;
    final wp = ScreenUtils.of(context).wp;
    final tablet = ScreenUtils.of(context).isTablet;
    Widget getColumn(String name, int flex) {
      if (name == 'description') {
        return Expanded(
          flex: flex,
          child: Container(
            // color: Colors.blue,
            alignment: Alignment.centerLeft,
            child: Text(
              description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.BackPrimaryGray,
                fontSize: tablet ? hp(2.2) : wp(3.6),
              ),
            ),
          ),
        );
      } else if (name == 'quantity') {
        return Expanded(
          flex: flex,
          child: Container(
            // color: Colors.yellow,
            margin: EdgeInsets.only(left: quantityLeft ? hp(1.6) : 0),
            alignment: quantityLeft ? Alignment.centerLeft : Alignment.center,
            child: Text(
              quantity,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.BackPrimaryGray,
                fontSize: tablet ? hp(2.2) : wp(3.6),
              ),
            ),
          ),
        );
      } else if (name == 'price') {
        return Expanded(
          flex: flex,
          child: Container(
            // color: Colors.red,
            alignment: Alignment.centerRight,
            child: Text(
              '₹ $price',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.PrimaryBlue,
                fontSize: tablet ? hp(2.2) : wp(3.6),
              ),
            ),
          ),
        );
      } else if (name == 'sno') {
        return Expanded(
          flex: flex,
          child: Container(
            // color: Colors.red,
            alignment: Alignment.center,
            child: Text(
              sno,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.BackPrimaryGray,
                fontSize: tablet ? hp(2.2) : wp(3.6),
              ),
            ),
          ),
        );
      }
    }

    return Container(
      // color: Colors.red,
      padding: EdgeInsets.only(
        // horizontal: hp(2),
        top: hp(0.5),
        bottom: hp(0.5),
      ),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (customOrder != null && customOrder['first'] != null)
                getColumn(customOrder['first']['column'],
                    customOrder['first']['flex']),
              if (customOrder != null && customOrder['second'] != null)
                getColumn(customOrder['second']['column'],
                    customOrder['second']['flex']),
              if (customOrder != null && customOrder['third'] != null)
                getColumn(customOrder['third']['column'],
                    customOrder['third']['flex']),
              if (customOrder != null && customOrder['fourth'] != null)
                getColumn(customOrder['fourth']['column'],
                    customOrder['fourth']['flex']),
            ],
          ),
        ],
      ),
    );
  }
}
