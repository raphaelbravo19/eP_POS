import 'package:epaisa_pos/src/models/OrderItem.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/cash_register/cash_register.dart';
import 'package:epaisa_pos/src/views/manufacturers/add_manufacturers/widgets/item_product.dart';
import 'package:epaisa_pos/src/views/payments/widgets/transaction_details.dart';
import 'package:epaisa_pos/src/views/promotions/widgets/item_product_row.dart';
import 'package:epaisa_pos/src/views/saved_transactions/saved_transactions_screen.dart';
import 'package:epaisa_pos/src/views/transactions/views/confirm_exchange_dialog.dart';
import 'package:epaisa_pos/src/views/transactions/views/full_refund_dialog.dart';
import 'package:epaisa_pos/src/widgets/buttons/epaisa_button.dart';
import 'package:epaisa_pos/src/widgets/dialogs/dialog_common.dart';
import 'package:flutter/material.dart';

class ExchangeDialog extends StatefulWidget {
  ExchangeDialog({
    Key key,
  }) : super(key: key);

  @override
  ExchangeDialogState createState() => ExchangeDialogState();
}

class ExchangeDialogState extends State<ExchangeDialog> {
  bool showModal = true;
  bool resendDisabled = true;
  List<Map<String, dynamic>> items = [
    {"count": 0},
    {"count": 0},
    {"count": 0},
    {"count": 0},
    {"count": 0},
    {"count": 0},
    {"count": 0},
    {"count": 0},
    {"count": 0},
  ];
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

  bool hasSelected() {
    var result = items.firstWhere((e) {
      return e['count'] > 0;
    }, orElse: () => {'count': 0});
    return result['count'] > 0;
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));

    void openDetailsDialog(BuildContext context) {
      Navigator.of(context).pushReplacement(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return ConfirmExchangeDialog();
        },
      ));
    }

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
                        "Exchange",
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

    Widget content() {
      return Container(
        width: (tablet ? wp(42) : wp(95)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              header(),
              HeadingWithBorder(
                hp: hp,
                title: 'Select product(s) for exchange',
                wp: wp,
              ),
              Column(
                verticalDirection: VerticalDirection.up,
                children: <Widget>[
                  if (hasSelected())
                    Container(
                      // height: hp(10),
                      padding: EdgeInsets.all(hp(2)),
                      color: Colors.white,
                      child: EpaisaButton.medium(
                          onPress: () {
                            openDetailsDialog(context);
                          },
                          title: 'CONFIRM EXCHANGE',
                          borderRadius: BorderRadius.circular(hp(1.2))),
                    ),
                  Container(
                    alignment: Alignment.center,
                    height: hp(50),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(hp(1)),
                      child: Column(
                        children: items.map((n) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                items[items.indexOf(n)] = {
                                  "count": n['count'] + 1
                                };
                              });
                              print(items);
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: hp(1)),
                              child: ItemProductRow(
                                selectedCount: n['count'],
                                margin: EdgeInsets.all(0),
                                borderRadius: BorderRadius.circular(hp(0.75)),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SearchProductBox(tablet: tablet, hp: hp),
                ],
              ),
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
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(
                                    tablet ? wp(1) : wp(3),
                                  ),
                                  bottomRight: Radius.circular(
                                    tablet ? wp(1) : wp(3),
                                  ),
                                ),
                                child: content(),
                              ),
                            ),
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

class SearchProductBox extends StatelessWidget {
  const SearchProductBox({
    Key key,
    @required this.tablet,
    @required this.hp,
  }) : super(key: key);

  final bool tablet;
  final Function hp;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding:
      // EdgeInsets.symmetric(horizontal: hp(2), vertical: hp(1.6)),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: AppColors.DarkGray.withOpacity(tablet ? 0.6 : 0.1),
              offset: Offset.fromDirection(45),
              blurRadius: 5.0)
        ],
      ),
      height: hp(7.5),
      child: Row(
        children: <Widget>[
          // Expanded(
          Container(
            width: hp(6),
            child: Icon(
              Icons.search,
              color: AppColors.PrimaryBlue.withOpacity(0.8),
            ),
          ),
          // ),
          Expanded(
            child: TextField(
              decoration: InputDecoration.collapsed(
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: AppColors.LightGray,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: TextStyle(
                color: AppColors.BackPrimaryGray,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }
}
