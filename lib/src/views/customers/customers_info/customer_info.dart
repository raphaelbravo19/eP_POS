import 'dart:async';
import 'dart:convert';

import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/remove_over_scroll_glow.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_card.dart';
import 'package:epaisa_pos/src/views/transactions/widgets/transaction_item.dart';
import 'package:epaisa_pos/src/widgets/buttons/payment_method_button.dart';
import 'package:intl/intl.dart';
import 'package:epaisa_pos/src/utility/colors.dart';

import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/customers/widgets/add_customer_dialog.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/views/transactions/transactions_screen.dart';
import 'package:epaisa_pos/src/widgets/cards/toggle_card.dart';
import 'package:epaisa_pos/src/widgets/textfields/texfield_number.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_dropdown.dart';
import 'package:epaisa_pos/src/widgets/texts/text_blue.dart';
import 'package:epaisa_pos/src/widgets/texts/text_gray.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:epaisa_pos/src/widgets/utils/daterange_picker.dart'
    as DateRagePicker;

import 'customer_credit_transection.dart';
import 'customer_personal_screen.dart';

class CustomersInfoScreen extends StatefulWidget {
  @override
  _CustomersInfoScreenState createState() => _CustomersInfoScreenState();
}

class ObjList {
  List<String> list = new List<String>();
  String key;
  ObjList({this.list, this.key});
}

class _CustomersInfoScreenState extends State<CustomersInfoScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));

    Widget _tabNavigator() {
      List<String> options = [
        "PERSONAL",
        eptxt('transactions').toUpperCase(),
        "CREDIT TRANSACTIONS"
      ];
      List<Widget> tabs = new List<Widget>();
      //var counter = 0;
      for (var i = 0; i < options.length; i++) {
        bool isSelected = i == _selectedIndex;
        var x = options[i];
        tabs.add(Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = i;
              });
              print(_selectedIndex);
            },
            child: Container(
              padding: EdgeInsets.only(top: hp(0.8)),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected
                        ? AppColors.PrimaryBlue
                        : AppColors.PrimaryWhite,
                    width: 4,
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: TextGray(
                title: x,
                fontSize: tablet ? hp(2) : wp(3.6),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ));
      }
      return Container(
        height: tablet ? hp(7) : hp(7),
        decoration: BoxDecoration(
          color: AppColors.PrimaryWhite,
          boxShadow: [
            BoxShadow(
                color: AppColors.DarkGray.withOpacity(0.3),
                offset: Offset(0, 2),
                blurRadius: 1)
          ],
        ),
        child: !tablet
            ? ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    width: wp(142),
                    child: Row(
                      children: tabs,
                    ),
                  ),
                ],
              )
            : Container(
                child: Row(
                  children: tabs,
                ),
              ),
      );
    }

    Widget _transactionInfo() {
      return Container(
        //width: tablet ? wp(70) : wp(95),
        margin: EdgeInsets.fromLTRB(wp(1.5), hp(1.8), wp(1.5), 0),

        decoration: BoxDecoration(
          color: AppColors.PrimaryWhite,
          borderRadius: BorderRadius.circular(hp(1)),
          border: Border.all(color: AppColors.DisabledBorder, width: 0.5),
          boxShadow: [
            BoxShadow(
                color: AppColors.DarkGray.withOpacity(0.35),
                offset: Offset(0, 2),
                blurRadius: 1)
          ],
        ),
        child: Column(
          verticalDirection: VerticalDirection.up,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: hp(1),
                  ),
                  Text(
                    "Total Sales",
                    style: TextStyle(
                        fontSize: tablet ? hp(1.8) : wp(3),
                        color: AppColors.TermsGray.withOpacity(0.7),
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5),
                  ),
                  Text(
                    "₹ 5,017.00",
                    style: TextStyle(
                        fontSize: tablet ? hp(3) : wp(4.8),
                        color: AppColors.Black,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.7),
                  ),
                  SizedBox(
                    height: tablet ? hp(1.5) : hp(1),
                  ),
                ],
              ),
            ),
            Container(
              height: tablet ? hp(29) : hp(25),
              width: wp(95),
              child: WebView(
                initialUrl:
                    'http://localhost:8080/chart_area${tablet ? "_landscape" : ""}.html?var=%20&dates=%20&height=100&width=100',
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.PrimaryWhite,
                boxShadow: [
                  BoxShadow(
                      color: AppColors.DarkGray.withOpacity(0.1),
                      offset: Offset(0, 1),
                      blurRadius: 2)
                ],
              ),
              child: SelectDate(
                onTap: () => pickRangeOfDates(DateTime.now(),
                    DateTime.now().add(Duration(days: 7)), context),
              ),
            ),
          ],
        ),
      );
    }

    Widget _transactionList() {
      return ScrollConfiguration(
        behavior: RemoveOverScrollGlow(),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: wp(1.5), vertical: hp(1)),
          //margin: EdgeInsets.only(top: hp(0.7)),
          child: Column(
              children: List.generate(5, (index) {
            return TransactionRowItem();
          })),
        ),
      );
    }

    Widget customerChart() {
      return Column(
        verticalDirection: VerticalDirection.up,
        children: <Widget>[
          Expanded(child: _transactionList()),
          _transactionInfo(),
        ],
      );
    }

    Widget _getScreen() {
      switch (_selectedIndex) {
        case 0:
          return SingleChildScrollView(child: CustomerPersonalScreen());
        case 1:
          return customerChart();
        case 2:
          return CustomerCreditTransactionScreen();
        default:
          return CustomerPersonalScreen();
      }
    }

    Widget _getScreenTablet() {
      switch (_selectedIndex) {
        case 0:
          return Row(
            children: <Widget>[
              Expanded(
                child: CustomerPersonalScreen(),
              ),
            ],
          );
        case 1:
          return Row(
            children: <Widget>[
              Expanded(
                child: customerChart(),
              ),
            ],
          );
        case 2:
          return Row(
            children: <Widget>[
              Expanded(
                child: CustomerCreditTransactionScreen(),
              ),
            ],
          );
        default:
          return Row(
            children: <Widget>[
              Expanded(
                child: CustomerPersonalScreen(),
              ),
            ],
          );
      }
    }

    Widget _buildContent() {
      return Container(
        child: Column(
          verticalDirection: VerticalDirection.up,
          children: <Widget>[
            Expanded(
              child: tablet ? _getScreenTablet() : _getScreen(),
            ),
            _tabNavigator(),
          ],
        ),
      );
    }

    return EpaisaScaffold(
        appBar: tablet
            ? Container()
            : EpaisaAppBar(
                back: true,
                title: "DETAILS",
              ),
        body: _buildContent());
  }

  void _showDialog() {
    // flutter defined function
    Navigator.of(context).push(new PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return AddCustomerDialog();
      },
    ));
  }
}

class SelectDate extends StatelessWidget {
  const SelectDate({
    Key key,
    @required this.onTap,
  }) : super(key: key);

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: hp(6),
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
        padding: EdgeInsets.symmetric(horizontal: hp(3)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/general_icons/calendar.png',
              height: tablet ? hp(3.2) : wp(5),
              color: AppColors.PrimaryBlue,
              colorBlendMode: BlendMode.srcATop,
            ),
            Padding(
              child: Text(
                "${DateFormat('dd MMM yyyy').format(DateTime.now())} - ${DateFormat('dd MMM yyyy').format(DateTime.now().add(Duration(days: 7)))}",
                style: TextStyle(
                    fontSize: tablet ? hp(1.9) : wp(3.1),
                    fontWeight: FontWeight.w700,
                    color: AppColors.PrimaryBlue,
                    wordSpacing: 1.0),
              ),
              padding: EdgeInsets.only(
                left: tablet ? hp(2.2) : wp(3),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: hp(0.3), left: tablet ? hp(0.5) : 0),
              child: Icon(Icons.keyboard_arrow_down,
                  size: tablet ? hp(3.6) : hp(3), color: AppColors.PrimaryBlue),
            ),
          ],
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

class TransactionRowItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    return EpaisaCard(
      margin: EdgeInsets.only(bottom: 8),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: tablet ? hp(2.5) : wp(4), vertical: hp(1.5)),
        child: Row(
          children: <Widget>[
            PaymentMethodButton(
              paymentName: "cash",
              fontSize: hp(2),
              size: tablet ? hp(7) : wp(12),
              onPress: () {},
            ),
            SizedBox(
              width: tablet ? hp(2.3) : wp(3),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 4),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 8),
                              child: Text(
                                "Cash",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: tablet ? hp(2.3) : wp(4),
                                  color: AppColors.BackPrimaryGray,
                                  height: 0.6,
                                ),
                              ),
                            ),
                            tablet
                                ? Text(
                                    '20 Feb 2018',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: hp(1.7),
                                      color: AppColors.TermsGray,
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '₹ 3121.36',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: tablet ? hp(2.3) : wp(4),
                                  color: TransactionColors.Approved,
                                  letterSpacing: 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: tablet ? hp(0.5) : 0,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 4),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 8),
                          child: Text(
                            'Invoice No. 45612',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: tablet ? hp(1.6) : wp(2.8),
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              tablet ? "APPROVED" : '20 Feb 2018',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: tablet ? hp(1.7) : wp(2.8),
                                color: AppColors.TermsGray,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
