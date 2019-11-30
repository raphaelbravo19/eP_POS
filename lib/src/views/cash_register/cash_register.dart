import 'package:epaisa_pos/data/initial/countries/api_service.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/validators/Validator.dart';
import 'package:epaisa_pos/src/views/payments/checkout/checkout.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/widgets/epaisa/total_amount.dart';
import 'package:epaisa_pos/src/widgets/general/add_customer.dart';
import 'package:epaisa_pos/src/widgets/utils/request_helper.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:rxdart/subjects.dart';

class CashRegister extends StatefulWidget {
  @override
  _CashRegisterState createState() => _CashRegisterState();
}

CashRegisterBloc cashRegisterBloc = new CashRegisterBloc();

class _CashRegisterState extends State<CashRegister> {
  void _onButtonTap(String value) {
    double newAmount;
    if (value == 'BACKSPACE') {
      var amounttext = cashRegisterBloc.streamAmount.value.toString();
      newAmount =
          double.parse(amounttext.substring(0, amounttext.length - 1)) / 10;
    } else if (value == 'ADD' || value == 'CLEAR') {
      if (value == 'ADD') {
        cashRegisterBloc.changeTotal(cashRegisterBloc.streamTotal.value +
            cashRegisterBloc.streamAmount.value);
      }
      if (value == 'CLEAR') {
        cashRegisterBloc.changeTotal(0.0);
      }
      newAmount = 0;
    } else {
      newAmount =
          (cashRegisterBloc.streamAmount.value * 10 + int.parse(value) / 100);
    }
    if (newAmount <= 999999.99) {
      cashRegisterBloc.changeAmount(newAmount);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hp = ScreenUtils.of(context).hp;
    final wp = ScreenUtils.of(context).wp;
    final tablet = ScreenUtils.of(context).isTablet;
    var isIOS = Platform.isIOS;

    final buttonsCount = tablet ? 11 : 5;
    var gap = tablet ? wp(2) : wp(1);
    var buttonSize = ((wp(100) - gap) / buttonsCount) - gap;
    return EpaisaScaffold(
        bottomColor: AppColors.TextGray,
        appBar: EpaisaAppBar(
          openDrawer: () {
            Scaffold.of(context).openDrawer();
          },
          menu: true,
          title: 'CASH REGISTER',
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            // color: Colors.red,
            height: isIOS ? hp(90.6) : hp(tablet ? 93.2 : 92),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                if (!tablet)
                  StreamBuilder<double>(
                      stream: cashRegisterBloc.streamTotal,
                      builder: (context, snapshot) {
                        if (snapshot.data != null)
                          return TotalAmount(
                            context: context,
                            value: snapshot.data.toStringAsFixed(2),
                          );
                        else
                          return Container();
                      }),
                SizedBox(
                  height: hp(1),
                ),
                Buttons(
                  gap: tablet ? wp(2.5) : wp(3.1),
                  buttonSize: buttonSize,
                  fontSize: tablet ? hp(2) : wp(2.8),
                ),
                SizedBox(
                  height: hp(1),
                ),
                Container(
                    height: hp(8.6),
                    child: StreamBuilder<double>(
                        stream: cashRegisterBloc.streamAmount,
                        builder: (context, snapshot) {
                          if (snapshot.data != null)
                            return Amount(
                                hp: hp,
                                value: snapshot.data.toStringAsFixed(2));
                          else
                            return Container();
                        })),
                Expanded(
                  flex: 65,
                  child: CashRegisterButtonsGrid(
                      hp: hp, onButtonTap: _onButtonTap),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    child: tablet
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Expanded(
                                child: AddCustomer(hp: hp),
                              ),
                              Expanded(
                                  child: StreamBuilder<double>(
                                      stream: cashRegisterBloc.streamAmount,
                                      builder: (context, snapshot) {
                                        if (snapshot.data != null)
                                          return AmountTablet(
                                              hp: hp,
                                              value: snapshot.data
                                                  .toStringAsFixed(2));
                                        else
                                          return Container();
                                      })),
                            ],
                          )
                        : AddCustomer(hp: hp),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class AmountTablet extends StatelessWidget {
  const AmountTablet({
    Key key,
    @required this.hp,
    @required this.value,
  }) : super(key: key);

  final Function hp;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: hp(10)),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color.fromRGBO(93, 103, 112, 1),
          border: Border(left: BorderSide(color: Colors.black, width: 1))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            eptxt('total_amount').toUpperCase(),
            style: TextStyle(
                color: Colors.white,
                fontSize: hp(2.5),
                fontWeight: FontWeight.bold),
          ),
          Text(
            '₹ $value',
            style: TextStyle(
                color: Colors.white,
                fontSize: hp(2.5),
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

class CashRegisterButtonsGrid extends StatelessWidget {
  const CashRegisterButtonsGrid({
    Key key,
    @required this.hp,
    @required this.onButtonTap,
  }) : super(key: key);

  final Function hp;
  final Function onButtonTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        hp(0.5),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 75,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 25,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 25,
                        child: CashRegisterButton(
                          onTap: () => onButtonTap('1'),
                          hp: hp,
                          text: CashRegisterButtonText(
                            text: '1',
                            fontSize: hp(5),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 25,
                        child: CashRegisterButton(
                          onTap: () => onButtonTap('2'),
                          hp: hp,
                          text: CashRegisterButtonText(
                            text: '2',
                            fontSize: hp(5),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 25,
                        child: CashRegisterButton(
                          onTap: () => onButtonTap('3'),
                          hp: hp,
                          text: CashRegisterButtonText(
                            text: '3',
                            fontSize: hp(5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 25,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 25,
                        child: CashRegisterButton(
                          onTap: () => onButtonTap('4'),
                          hp: hp,
                          text: CashRegisterButtonText(
                            text: '4',
                            fontSize: hp(5),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 25,
                        child: CashRegisterButton(
                          onTap: () => onButtonTap('5'),
                          hp: hp,
                          text: CashRegisterButtonText(
                            text: '5',
                            fontSize: hp(5),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 25,
                        child: CashRegisterButton(
                          onTap: () => onButtonTap('6'),
                          hp: hp,
                          text: CashRegisterButtonText(
                            text: '6',
                            fontSize: hp(5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 25,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 25,
                        child: CashRegisterButton(
                          onTap: () => onButtonTap('7'),
                          hp: hp,
                          text: CashRegisterButtonText(
                            text: '7',
                            fontSize: hp(5),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 25,
                        child: CashRegisterButton(
                          onTap: () => onButtonTap('8'),
                          hp: hp,
                          text: CashRegisterButtonText(
                            text: '8',
                            fontSize: hp(5),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 25,
                        child: CashRegisterButton(
                          onTap: () => onButtonTap('9'),
                          hp: hp,
                          text: CashRegisterButtonText(
                            text: '9',
                            fontSize: hp(5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 25,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 25,
                        child: CashRegisterButton(
                          onTap: () => onButtonTap('CLEAR'),
                          hp: hp,
                          text: CashRegisterButtonText(
                              text: 'C',
                              fontSize: hp(5),
                              color: Color.fromRGBO(208, 2, 27, 1)),
                        ),
                      ),
                      Expanded(
                        flex: 50,
                        child: CashRegisterButton(
                          onTap: () => onButtonTap('0'),
                          hp: hp,
                          text: CashRegisterButtonText(
                            text: '0',
                            fontSize: hp(5),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 25,
            child: Column(children: <Widget>[
              Expanded(
                flex: 50,
                child: CashRegisterButton(
                  onTap: () => onButtonTap('BACKSPACE'),
                  hp: hp,
                  text: Icon(
                    Icons.arrow_back,
                    size: hp(7.5),
                    color: Color.fromRGBO(255, 96, 0, 1),
                  ),
                ),
              ),
              Expanded(
                flex: 50,
                child: CashRegisterButton(
                  onTap: () => onButtonTap('ADD'),
                  hp: hp,
                  text: CashRegisterButtonText(
                    text: '+',
                    fontSize: hp(9),
                    color: Color.fromRGBO(23, 66, 133, 1),
                  ),
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}

class CashRegisterButton extends StatelessWidget {
  const CashRegisterButton({
    Key key,
    @required this.hp,
    @required this.text,
    @required this.onTap,
  }) : super(key: key);

  final Function hp;
  final Function onTap;
  final Widget text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            hp(1),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset.fromDirection(45),
              blurRadius: 2,
              spreadRadius: 1,
            )
          ],
        ),
        child: Center(
          child: text,
        ),
      ),
    );
  }
}

class CashRegisterButtonText extends StatelessWidget {
  const CashRegisterButtonText({
    Key key,
    @required this.text,
    @required this.fontSize,
    this.color = const Color.fromRGBO(102, 102, 102, 1),
  }) : super(key: key);

  final String text;
  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: color,
        fontSize: fontSize,
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  const Buttons({
    Key key,
    @required this.gap,
    @required this.buttonSize,
    @required this.fontSize,
  }) : super(key: key);

  final gap;
  final double buttonSize;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: hp(1)),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Container(
          padding: EdgeInsets.only(left: tablet ? wp(2) : wp(2.5)),
          child: ButtonsScroll(
            tWidth: MediaQuery.of(context).size.width,
            marginRight: gap,
            buttonSize: buttonSize,
            fontSize: fontSize,
            onButtonPress: () {
              cashRegisterBloc.initPayment();
            },
          ),
        ),
      ),
    );
  }
}

class Amount extends StatelessWidget {
  const Amount({
    Key key,
    @required this.hp,
    @required this.value,
  }) : super(key: key);

  final Function hp;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - hp(2),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(hp(1.5)),
        border: Border.all(color: Colors.black12),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            offset: const Offset(0, 0),
          ),
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            offset: const Offset(-0, -0),
          ),
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            offset: const Offset(0, -0),
          ),
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            offset: const Offset(-0, 0),
          ),
          BoxShadow(
            color: Colors.white,
            offset: const Offset(0, 0),
            blurRadius: 4,
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: hp(2.5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              eptxt('amount'),
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.BackPrimaryGray,
                fontSize: hp(2.5),
              ),
            ),
            Text(
              '₹ $value',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.BackPrimaryGray,
                  fontSize: hp(2.5)),
            ),
          ],
        ),
      ),
    );
  }
}

class CashRegisterBloc extends Object with Validators {
  final streamAmount = BehaviorSubject<double>.seeded(0.0);
  final streamTotal = BehaviorSubject<double>.seeded(0.0);
  final streamOrder = BehaviorSubject<Map<String, dynamic>>();
  final streamInitPayments = BehaviorSubject<Map<String, dynamic>>();
  final streamProcessPayments = BehaviorSubject<Map<String, dynamic>>();
  final streamFinalizePayments = BehaviorSubject<Map<String, dynamic>>();
  Function(double) get changeAmount => streamAmount.sink.add;
  Function(double) get changeTotal => streamTotal.sink.add;
  Function(Map<String, dynamic>) get changeOrder => streamOrder.sink.add;
  Function(Map<String, dynamic>) get changeInitPayment =>
      streamInitPayments.sink.add;
  Function(Map<String, dynamic>) get changeProcessPayment =>
      streamProcessPayments.sink.add;
  Function(Map<String, dynamic>) get changeFinalizePayment =>
      streamFinalizePayments.sink.add;
  final api = ApiService.create();
  void initPayment() async {
    var order = {
      "currencyId": "5dc5b870a4fe11031de1e352",
      "amount": streamTotal.value
    };
    changeOrder(order);
    var authkey = await getauthkey();
    var response = await api.initPayment(authKey: authkey, body: order);
    print(response.body);
    changeInitPayment(response.body);
  }

  void processPayment(double amount) async {
    var order = {
      "paymentId": streamInitPayments.value["id"],
      "currencyId": "5dc5b870a4fe11031de1e352",
      "amount": amount,
      "type": "5d9f1cdba455cf04c08ae6cf"
    };
    var authkey = await getauthkey();
    var response = await api.processPayment(authKey: authkey, body: order);
    print(response.body);
    changeProcessPayment(response.body);
  }

  void finalizePayment() async {
    var order = {"paymentId": streamInitPayments.value["id"]};
    var authkey = await getauthkey();
    var response = await api.finalizePayment(authKey: authkey, body: order);
    print(response.body);
    changeFinalizePayment(response.body);
  }

  dispose() {
    print('dispose');
    streamAmount.close();
    streamTotal.close();
    streamOrder.close();
    streamInitPayments.close();
    streamProcessPayments.close();
    streamFinalizePayments.close();
  }
}
