import 'dart:io';
import 'dart:ui';

import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/remove_over_scroll_glow.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/screen_with_cart/screen_with_cart.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_card.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/views/shopping_cart/shopping_cart_screen.dart';
import 'package:epaisa_pos/src/views/shopping_cart/widgets/full_refund.dart';
import 'package:epaisa_pos/src/views/shopping_cart/widgets/partial_refund.dart';
import 'package:epaisa_pos/src/views/shopping_cart/widgets/transaction_exchange.dart';
import 'package:epaisa_pos/src/views/shopping_cart/widgets/transaction_info.dart';
import 'package:epaisa_pos/src/views/transactions/views/credit_note_dialog.dart';
import 'package:epaisa_pos/src/views/transactions/views/transaction_information_dialog.dart';
import 'package:epaisa_pos/src/views/transactions/widgets/exchange_items.dart';
import 'package:epaisa_pos/src/views/transactions/widgets/filter_dialog.dart'
    as dialog;
import 'package:epaisa_pos/src/views/transactions/widgets/transaction_item.dart';
import 'package:epaisa_pos/src/widgets/buttons/epaisa_button.dart';
import 'package:epaisa_pos/src/widgets/utils/daterange_picker.dart'
    as DateRagePicker;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class TransactionsScreen extends StatefulWidget {
  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  var cartContent;
  var mainContent;

  @override
  void initState() {
    cartContent = 'info';
    mainContent = 'transactions';
    super.initState();
  }

  getCartContent(String name) {
    if (name == 'info') {
      return TransactionInfo(
        fullRefund: () {
          setState(() {
            cartContent = 'full_refund';
          });
        },
        partialRefund: () {
          setState(() {
            cartContent = 'partial_refund';
          });
        },
      );
    } else if (name == 'full_refund') {
      return FullRefund();
    } else if (name == 'partial_refund') {
      return PartialRefund(exchange: () {
        setState(() {
          mainContent = 'exchange';
          cartContent = 'exchange';
        });
      }, creditNote: () {
        Navigator.of(context).push(PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) {
            return CreditNoteDialog();
          },
        ));
      });
    } else if (name == 'exchange') {
      return TransactionExchange(
        partialRefund: () {},
        fullRefund: () {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool tablet = isTablet(MediaQuery.of(context));
    return tablet
        ? ScreenWithCart(
            body: getMainContent(context, tablet),
            transactionsFooter: true,
            cart: ShoppingCartScreen(
              content: getCartContent(cartContent),
              transactionsFooter: true,
            ),
          )
        : getMainContent(context, tablet);
  }

  final GlobalKey _keyButton = GlobalKey();

  void _showFilter(BuildContext context) {
    // flutter defined function
    final RenderBox renderBoxRed = _keyButton.currentContext.findRenderObject();
    final positionRed = renderBoxRed.localToGlobal(Offset.zero);
    Navigator.of(context).push(new PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        final circleX = positionRed.dx - 10;
        final circleY = positionRed.dy - 10;
        bool isIOS = Platform.isIOS;

        return isIOS
            ? Scaffold(
                backgroundColor: Colors.black.withOpacity(0.6),
                body: Container(
                  alignment: Alignment.center,
                  width: wp(100),
                  height: hp(100),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                          child: Container(
                            width: wp(100),
                            height: hp(100),
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ),
                      Positioned(
                        left: circleX,
                        top: circleY,
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(hp(1.5)),
                              height: hp(5.5),
                              width: hp(5.5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                'assets/general_icons/settings.png',
                                colorBlendMode: BlendMode.srcIn,
                                color: AppColors.BackPrimaryGray,
                                height: hp(1),
                                width: hp(1),
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        left: circleX + hp(1.125),
                        top: circleY + hp(6),
                        child: ClipPath(
                          child: Container(
                            width: hp(3),
                            height: hp(2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                          clipper: dialog.TriangleUpClipper(),
                        ),
                      ),
                      Positioned(
                        top: circleY + hp(7.5),
                        child: Container(
                          width: tablet ? wp(60) : wp(96),
                          height: tablet ? hp(87) : hp(83),
                          child: EpaisaCard(
                            borderRadius: BorderRadius.circular(hp(1.8)),
                            child: Expanded(
                              child: ScrollConfiguration(
                                behavior: RemoveOverScrollGlow(),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: dialog.Amount(),
                                      ),
                                      dialog.PaymentMethods(
                                        hp: hp,
                                        wp: wp,
                                      ),
                                      dialog.TransactionStatus(),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              color: AppColors.LightGray,
                                              width: 0.25,
                                            ),
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: tablet ? hp(6) : hp(3.5),
                                          vertical: hp(2),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                bottom: hp(1),
                                              ),
                                              child: Text(
                                                'EMPLOYEE',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColors
                                                        .BackPrimaryGray,
                                                    fontSize: tablet
                                                        ? hp(2.5)
                                                        : wp(3.5),
                                                    letterSpacing: 1.5),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              height: tablet ? hp(7) : wp(11),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        hp(0.5)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    offset:
                                                        Offset.fromDirection(
                                                            45),
                                                    color: Colors.grey[700],
                                                    blurRadius: 1,
                                                    spreadRadius: 0.5,
                                                  )
                                                ],
                                              ),
                                              child: Row(
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: wp(3),
                                                  ),
                                                  Expanded(
                                                    flex: 90,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Select Employee',
                                                        style: TextStyle(
                                                          fontSize: tablet
                                                              ? hp(2.0)
                                                              : wp(3.0),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: AppColors
                                                              .BackPrimaryGray,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 10,
                                                    child: Icon(Icons
                                                        .arrow_forward_ios),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              color: AppColors.LightGray,
                                              width: 0.25,
                                            ),
                                          ),
                                        ),
                                        padding: EdgeInsets.only(
                                          left: hp(3),
                                          right: hp(3),
                                          bottom: hp(2),
                                          top: hp(2),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: tablet
                                              ? MainAxisAlignment.end
                                              : MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                height: tablet ? hp(6.5) : null,
                                                padding: EdgeInsets.only(
                                                    right: tablet
                                                        ? hp(3)
                                                        : hp(1.6),
                                                    left: tablet ? hp(6) : 0),
                                                child: !tablet
                                                    ? EpaisaButton.withBorder(
                                                        title: 'CLEAR',
                                                        onPress: () {},
                                                        fontSize: tablet
                                                            ? hp(2.3)
                                                            : null,
                                                        borderColor: AppColors
                                                            .PrimaryBlue,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          hp(1.6),
                                                        ),
                                                      )
                                                    : EpaisaButton.medium(
                                                        title: 'CLEAR',
                                                        onPress: () {},
                                                        leftColor:
                                                            Color(0xFFBDC1CD),
                                                        rightColor:
                                                            Color(0xFFBDC1CD),
                                                        textColor:
                                                            Color(0xFF52565F),
                                                        fontSize: tablet
                                                            ? hp(2.3)
                                                            : null,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          hp(1.6),
                                                        ),
                                                      ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: tablet ? hp(6.5) : null,
                                                padding: EdgeInsets.only(
                                                    left: tablet
                                                        ? hp(3)
                                                        : hp(1.6),
                                                    right: tablet ? hp(6) : 0),
                                                child: EpaisaButton.medium(
                                                  title: 'APPLY',
                                                  onPress: () {},
                                                  fontSize:
                                                      tablet ? hp(2.3) : null,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    hp(1.6),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : dialog.FilterDialog(x: positionRed.dx, y: positionRed.dy);
      },
    ));
  }

  void _showInfo(BuildContext context) {
    if (isTablet(MediaQuery.of(context))) {
      return;
    }
    Navigator.of(context).push(new PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return TransactionInformationDialog();
      },
    ));
  }

  EpaisaScaffold getMainContent(BuildContext context, bool tablet) {
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;

    return EpaisaScaffold(
      appBar: EpaisaAppBar(
        searchTitle: "transactions",
        menu: true,
        openDrawer: () {
          Scaffold.of(context).openDrawer();
        },
        trailing: [
          Container(
            margin: EdgeInsets.only(right: wp(2.5)),
            child: GestureDetector(
              onTap: () {
                _showFilter(context);
              },
              child: Image.asset(
                'assets/general_icons/settings.png',
                height: hp(2.5),
                key: _keyButton,
                color: Colors.white,
              ),
            ),
          ),
        ],
        searchIcon: true,
        title: 'TRANSACTIONS',
      ),
      body: mainContent == 'transactions'
          ? transactionsContent(context, wp, hp, tablet)
          : ExchangeItems(),
    );
  }

  Container transactionsContent(
      BuildContext context, Function wp, Function hp, bool tablet) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SelectDate(
              wp: wp,
              hp: hp,
              onTap: () => pickRangeOfDates(
                DateTime.now(),
                DateTime.now().add(Duration(days: 7)),
                context,
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  TransactionItem(
                    onTap: () => _showInfo(context),
                    status: TransactionStatusList.approved,
                    transactionAmount: '₹ 2045.64',
                    type: TransactionTypesList.cash(isTablet: tablet),
                    isTablet: tablet,
                  ),
                  TransactionItem(
                    onTap: () => _showInfo(context),
                    status: TransactionStatusList.cancelled,
                    transactionAmount: '₹ 2045.64',
                    type: TransactionTypesList.card(isTablet: tablet),
                    isTablet: tablet,
                  ),
                  TransactionItem(
                    onTap: () => _showInfo(context),
                    status: TransactionStatusList.deposited,
                    transactionAmount: '₹ 2045.64',
                    type: TransactionTypesList.cheque(isTablet: tablet),
                    isTablet: tablet,
                  ),
                  TransactionItem(
                    onTap: () => _showInfo(context),
                    status: TransactionStatusList.failed,
                    transactionAmount: '₹ 2045.64',
                    type: TransactionTypesList.wallet(isTablet: tablet),
                    isTablet: tablet,
                  ),
                  TransactionItem(
                    onTap: () => _showInfo(context),
                    status: TransactionStatusList.pending,
                    transactionAmount: '₹ 2045.64',
                    type: TransactionTypesList.upi(isTablet: tablet),
                    isTablet: tablet,
                  ),
                  TransactionItem(
                    onTap: () => _showInfo(context),
                    status: TransactionStatusList.settled,
                    transactionAmount: '₹ 2045.64',
                    type: TransactionTypesList.cash(isTablet: tablet),
                    isTablet: tablet,
                  ),
                  TransactionItem(
                    onTap: () => _showInfo(context),
                    status: TransactionStatusList.approved,
                    transactionAmount: '₹ 2045.64',
                    type: TransactionTypesList.cash(isTablet: tablet),
                    isTablet: tablet,
                  ),
                  TransactionItem(
                    onTap: () => _showInfo(context),
                    status: TransactionStatusList.pending,
                    transactionAmount: '₹ 2045.64',
                    type: TransactionTypesList.cash(isTablet: tablet),
                    isTablet: tablet,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectDate extends StatelessWidget {
  const SelectDate({
    Key key,
    @required this.wp,
    @required this.hp,
    @required this.onTap,
  }) : super(key: key);

  final Function wp;
  final Function hp;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final tablet = ScreenUtils.of(context).isTablet;
    return Container(
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.only(
            left: hp(2),
          ),
          height: hp(5.6),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey[200],
                offset: Offset(0.0, 2.0),
                blurRadius: 10.0,
              ),
            ],
          ),
          // padding: EdgeInsets.symmetric(horizontal: hp(3)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: tablet ? 80 : 72,
                child: GestureDetector(
                  onTap: onTap,
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/general_icons/calendar.png',
                        height: hp(3),
                        color: AppColors.PrimaryBlue,
                        colorBlendMode: BlendMode.srcATop,
                      ),
                      Padding(
                        child: Text(
                          tablet
                              ? "${DateFormat('dd MMMM yyyy').format(DateTime.now())} - ${DateFormat('dd MMMM yyyy').format(DateTime.now().add(Duration(days: 7)))}"
                              : "${DateFormat('dd MMM yyyy').format(DateTime.now())} - ${DateFormat('dd MMM yyyy').format(DateTime.now().add(Duration(days: 7)))}",
                          style: TextStyle(
                            fontSize: tablet ? hp(1.8) : wp(3.4),
                            fontWeight: FontWeight.w600,
                            color: AppColors.PrimaryBlue,
                            wordSpacing: 1.0,
                          ),
                        ),
                        padding: EdgeInsets.only(
                          left: hp(2),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(top: 4, right: hp(1), left: hp(1)),
                        child: Image.asset(
                          "assets/payments/arrowdw.png",
                          height: tablet ? hp(1.2) : wp(2),
                          color: Color(0x8A000000),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: hp(2)),
                decoration: BoxDecoration(
                  //color: Colors.red,
                  border: Border(
                    left: BorderSide(
                      color: Colors.grey[200],
                      width: hp(0.25),
                    ),
                  ),
                ),
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: tablet ? hp(2) : hp(1.6)),
                        child: DropdownButton<String>(
                          value: null,
                          icon: SizedBox(),
                          iconSize: 24,
                          elevation: 6,
                          hint: Row(
                            children: <Widget>[
                              Text(
                                'Sort By',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: tablet ? hp(2.1) : wp(3.5),
                                    fontFamily: "Montserrat"),
                              ),
                              SizedBox(
                                width: wp(tablet ? 4.5 : 2.3),
                              ),
                              Image.asset(
                                "assets/payments/arrowdw.png",
                                height: tablet ? hp(1.3) : wp(2),
                                color: Color(0x8A000000),
                              ),
                              SizedBox(
                                width: wp(tablet ? 1.5 : 0),
                              ),
                            ],
                          ),
                          style: TextStyle(
                            color: AppColors.BackPrimaryGray,
                          ),
                          underline: Container(),
                          onChanged: (String newValue) {
                            // setState(() {
                            //   dropdownValue = newValue;
                            // });
                          },
                          items: <String>['Newest', 'Latest']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: tablet ? hp(2.1) : wp(3.5),
                                    fontFamily: "Montserrat"),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                //     Container(
                //       margin: EdgeInsets.only(
                //         left: hp(2),
                //         top: 4,
                //       ),
                //       child: Text(
                //         "Sort By",
                //         style: TextStyle(
                //           fontSize: hp(1.8),
                //           fontWeight: FontWeight.w600,
                //           color: AppColors.BackPrimaryGray,
                //           wordSpacing: 1.0,
                //         ),
                //       ),
                //     ),
                //     Container(
                //       margin: EdgeInsets.only(
                //         top: 4,
                //       ),
                //       // color: Colors.green,
                //       child: Icon(
                //         Icons.keyboard_arrow_down,
                //         size: hp(3),
                //         color: AppColors.BackPrimaryGray,
                //       ),
                //     ),
                //   ],
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void pickRangeOfDates(
    DateTime startDate, DateTime endDate, BuildContext context) async {
  await DateRagePicker.showDatePicker(
    context: context,
    initialFirstDate: startDate,
    initialLastDate: endDate,
    firstDate: new DateTime(1900),
    lastDate: new DateTime(2100),
    headerBuilder: dateRangePickerHeader,
    footerBuilder: dateRangePickerFooter,
    width: tablet ? wp(45) : wp(80),
  );
}

Function dateRangePickerHeader = (date, year, yearAction, dateAction) {
  return Container(
      padding: EdgeInsets.only(
          left: tablet ? wp(2) : wp(4), bottom: hp(3), top: hp(3)),
      color: AppColors.PrimaryBlue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: yearAction,
            child: Text(
              year,
              style: TextStyle(
                  color: AppColors.PrimaryWhite,
                  fontSize: tablet ? hp(3) : wp(4),
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: hp(1),
          ),
          GestureDetector(
              onTap: dateAction,
              child: Text(date,
                  style: TextStyle(
                      color: AppColors.PrimaryWhite,
                      fontSize: tablet ? hp(3.7) : wp(5),
                      fontWeight: FontWeight.w600))),
        ],
      ));
};

Function dateRangePickerFooter = (cancelAction, okAction) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
            onTap: cancelAction,
            child: Container(
              padding: EdgeInsets.only(left: wp(4), bottom: hp(2)),
              child: Text("CANCEL",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: tablet ? hp(3) : wp(3.6),
                      color: AppColors.PrimaryBlue)),
            )),
        GestureDetector(
            onTap: okAction,
            child: Container(
              padding: EdgeInsets.only(right: wp(4), bottom: hp(2)),
              child: Text("OK",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: tablet ? hp(3) : wp(3.6),
                      color: AppColors.PrimaryBlue)),
            )),
      ],
    ),
  );
};

Function datePickerHeader = (date, year, yearAction, dateAction) {
  return Container(
      padding: EdgeInsets.only(
          left: tablet ? wp(2) : wp(4), bottom: hp(3), top: hp(3)),
      color: AppColors.PrimaryBlue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: yearAction,
            child: Text(
              year,
              style: TextStyle(
                  color: AppColors.PrimaryWhite,
                  fontSize: tablet ? hp(3) : wp(4),
                  fontWeight: FontWeight.w400),
            ),
          ),
          GestureDetector(
              onTap: dateAction,
              child: Text(date,
                  style: TextStyle(
                      color: AppColors.PrimaryWhite,
                      fontSize: tablet ? hp(5) : wp(7.8),
                      fontWeight: FontWeight.w600))),
        ],
      ));
};

Function datePickerFooter = (cancelAction, okAction) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
            onTap: cancelAction,
            child: Container(
              padding: EdgeInsets.only(left: wp(4), bottom: hp(2)),
              child: Text("CANCEL",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: tablet ? hp(3) : wp(3.6),
                      color: AppColors.PrimaryBlue)),
            )),
        GestureDetector(
            onTap: okAction,
            child: Container(
              padding: EdgeInsets.only(right: wp(4), bottom: hp(2)),
              child: Text("OK",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: tablet ? hp(3) : wp(3.6),
                      color: AppColors.PrimaryBlue)),
            )),
      ],
    ),
  );
};
