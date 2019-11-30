import 'dart:ui';
import 'dart:async';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/payment_button_names.dart';
import 'package:epaisa_pos/src/utility/remove_over_scroll_glow.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_card.dart';
import 'package:epaisa_pos/src/widgets/buttons/epaisa_button.dart';
import 'package:epaisa_pos/src/widgets/buttons/payment_method_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'dart:io';

class FilterDialog extends StatefulWidget {
  FilterDialog({Key key, this.x, this.y}) : super(key: key);
  final double x;
  final double y;
  @override
  FilterDialogState createState() => FilterDialogState();
}

final status = [
  {'title': 'Deposited', 'color': Color(0xFF2D8586), "selected": false},
  {'title': 'Settled', 'color': Color(0xFF04A754), "selected": false},
  {'title': 'Approved', 'color': Color(0xFF8FC742), "selected": false},
  {'title': 'Pending', 'color': Color(0xFFEADF00), "selected": true},
  {'title': 'Failed', 'color': Color(0xFFFF0000), "selected": true},
  {'title': 'Voided', 'color': Color(0xFF640563), "selected": false},
  {'title': 'Refunded', 'color': Color(0xFFEB6BAA), "selected": false},
  {'title': 'Cancelled', 'color': Color(0xFFFF3D00), "selected": false},
];

class FilterDialogState extends State<FilterDialog> {
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
    settingsBloc.map = status;
    tablet = isTablet(MediaQuery.of(context));
    final hp = ScreenUtils.of(context).hp;
    final wp = ScreenUtils.of(context).wp;
    final circleX = widget.x - 10;
    final circleY = widget.y - 10;
    var isIOS = Platform.isIOS;

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0),
      body: Container(
        alignment: Alignment.center,
        width: wp(100),
        height: isIOS ? hp(100) : hp(110),
        child: !showModal
            ? Container(
                height: 100,
                width: 100,
              )
            : Stack(fit: StackFit.expand,
                alignment: Alignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showModal = false;
                      });
                      Navigator.of(context).pop();
                    },
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                      child: Container(
                        width: wp(100),
                        height: hp(100),
                        color: Colors.black.withOpacity(0.4),

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
                      clipper: TriangleUpClipper(),
                    ),
                  ),
                  Positioned(
                    top: circleY + hp(7.5),
                    child: Container(
                      width: tablet ? wp(60) : wp(96),
                      height: hp(90),
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
                                    child: Amount(),
                                  ),
                                  PaymentMethods(
                                    hp: hp,
                                    wp: wp,
                                  ),
                                  TransactionStatus(),
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
                                                color:
                                                    AppColors.BackPrimaryGray,
                                                fontSize:
                                                    tablet ? hp(2.5) : wp(3.5),
                                                letterSpacing: 1.5),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          height: tablet ? hp(7) : wp(11),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(hp(0.5)),
                                            boxShadow: [
                                              BoxShadow(
                                                offset:
                                                    Offset.fromDirection(1.5),
                                                color: Colors.grey[500],
                                                blurRadius: 1,
                                                spreadRadius: 0.5,
                                              )
                                            ],
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(width: wp(3),),
                                              Expanded(
                                                flex: 90,
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      'Select Employee',
                                                      style: TextStyle(
                                                        fontSize: tablet
                                                            ? hp(2.0)
                                                            : wp(2.9),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppColors
                                                            .BackPrimaryGray,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 10,
                                                child: Icon(
                                                    Icons.arrow_forward_ios),
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
                                      top: hp(1),
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
                                                right: tablet ? hp(3) : hp(1.6),
                                                left: tablet ? hp(6) : 0),
                                            child: !tablet
                                                ? EpaisaButton.withBorder(
                                                    title: 'CLEAR',
                                                    textStyle: TextStyle(
                                                      letterSpacing: 1,
                                                      fontSize: tablet ? hp(2.3) : wp(3.4),
                                                      fontWeight: FontWeight.w600,
                                                      color: AppColors.PrimaryBlue,),
                                                    onPress: () {},
                                                    borderColor:
                                                        AppColors.PrimaryBlue,
                                                    borderRadius:
                                                        BorderRadius.circular(
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
                                                    fontSize:
                                                        tablet ? hp(2.3) : null,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      hp(1.6),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: tablet ? hp(6.5) : null,
                                            padding: EdgeInsets.only(
                                                left: tablet ? hp(3) : hp(1.6),
                                                right: tablet ? hp(6) : 0),
                                            child: EpaisaButton.medium(

                                              title: 'APPLY',
                                              onPress: () {},
                                              fontSize: tablet ? hp(2.3) : null,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                hp(1.6),
                                              ),
                                            ),
                                          ),
                                        )
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
    );
  }
}

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({
    Key key,
    @required this.hp,
    @required this.wp,
  }) : super(key: key);

  final Function hp;
  final Function wp;

  @override
  Widget build(BuildContext context) {
    final buttons = [
      {"title": 'Cash', "icon": "cash_sh"},
      {"title": 'Card', "icon": "card_sh"},
      {
        "title": eptxt('payment_button_upi_qr'),
        "icon": "upiscan_sh"
      },
      {"title": eptxt('payment_button_upi'), "icon": "upi_sh"},
      {"title": 'Cheque', "icon": "cheque_sh"},
      {"title": 'EMI', "icon": "emi_sh"},
      {"title": 'Citrus', "icon": "citrus_sh"},
      {"title": 'Freecharge', "icon": "freecharge_sh"},
      {"title": 'Mobikwik', "icon": "mobik_sh"},
      {"title": 'OLA Money', "icon": "ola_sh"},
      {"title": 'Pockets', "icon": "pockets_sh"},
      {"title": 'mPesa', "icon": "mpesa_sh"},
    ];
    return Container(
      padding: EdgeInsets.only(
        top: hp(2),
        left: tablet ? hp(3) : hp(0.5),
        right: tablet ? hp(3) : hp(0.5),
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.LightGray,
            width: 0.25,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              bottom: hp(1),
              left: tablet ? hp(3) : hp(3),
              right: tablet ? hp(3) : hp(3),
            ),
            child: Text(
              'PAYMENT METHODS',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.BackPrimaryGray,
                  fontSize: tablet ? hp(2.5) : wp(3.5),
                  letterSpacing: 1.5),
            ),
          ),
          Container(
              padding: EdgeInsets.only(
                  bottom: hp(1),
                  left: tablet ? hp(0) : hp(1),
                  right: tablet ? hp(0) : hp(1)),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(tablet ? 8 : 6, (index) {
                      var cant = tablet ? 8 : 6;
                      var totalWidth = tablet ? wp(60) - hp(6) : wp(96) - hp(3);
                      var circleSize = tablet
                          ? (0.65 * totalWidth / cant)
                          : (0.7 * totalWidth / cant);
                      return Container(
                          width: totalWidth / cant,
                          alignment: Alignment.center,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                  child: PaymentMethodButton(
                                    fontWeight: FontWeight.w600,
                                    spacing: tablet ? hp(0.5) : hp(0.5),
                                    paymentName: buttons[index]['icon'],
                                    fontSize: tablet ? hp(1.5) : wp(2.6),
                                    marginRight: 0,
                                    size: circleSize * 1.25,
                                    onPress: () {
                                      print(buttons[index]);
                                    },
                                    title: buttons[index]['title'],
                                  ),
                                )
                              ]));
                    }),
                  ),
                  SizedBox(
                    height: hp(0.6),
                  ),
                  Row(
                    mainAxisAlignment: tablet
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.spaceBetween,
                    children: List.generate(tablet ? 4 : 6, (index) {
                      var cant = tablet ? 8 : 6;
                      var totalWidth = tablet ? wp(60) - hp(6) : wp(96) - hp(3);
                      var circleSize = tablet
                          ? (0.65 * totalWidth / cant)
                          : (0.7 * totalWidth / cant);
                      return Container(
                          width: totalWidth / cant,
                          alignment: Alignment.center,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                  child: PaymentMethodButton(
                                    fontWeight: FontWeight.w600,
                                    spacing: tablet ? hp(0.5) : hp(0.5),
                                    paymentName: buttons[index + cant]['icon'],
                                    fontSize: tablet ? hp(1.5) : wp(2.6),
                                    marginRight: 0,
                                    size: circleSize * 1.25,
                                    onPress: () {
                                      print(buttons[index + cant]);
                                    },
                                    title: buttons[index + cant]['title'],
                                  ),
                                )
                              ]));
                    }),
                  ),
                ],
              )
              ),
        ],
      ),
    );
  }
}

class TransactionStatus extends StatelessWidget {
  const TransactionStatus({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: hp(2),
        left: tablet ? hp(3) : hp(0.5),
        right: tablet ? hp(3) : hp(0.5),
      ),
      decoration: BoxDecoration(
        border: Border(
          // bottom: BorderSide(
          //   color: AppColors.BackPrimaryGray,
          //   width: 0.5,
          // ),
          top: BorderSide(
            color: AppColors.LightGray,
            width: 0.25,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              bottom: hp(1),
              left: tablet ? hp(3) : hp(3),
              right: tablet ? hp(3) : hp(3),
            ),
            child: Text(
              'TRANSACTION STATUS',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.BackPrimaryGray,
                  fontSize: tablet ? hp(2.5) : wp(3.5),
                  letterSpacing: 1.5),
            ),
          ),
          Container(
              padding: EdgeInsets.only(
                  bottom: hp(1),
                  left: tablet ? hp(0) : hp(1),
                  right: tablet ? hp(0) : hp(1)),
              child: tablet
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(8, (index) {
                        var totalWidth = wp(60) - hp(6);
                        var circleSize =
                            tablet ? (0.65 * totalWidth / 8) : wp(10.26);
                        return Container(
                          width: totalWidth / 8,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Container(
                                  height: circleSize,
                                  width: circleSize,
                                  decoration: BoxDecoration(
                                    border: status[index]['selected']
                                        ? Border.all(
                                            width: 3.41,
                                            color: Color(0xFF417505),
                                          )
                                        : null,
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.white,
                                          status[index]['color']
                                        ]),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(1.0, 1.0),
                                        color: Colors.grey[status[index]
                                                ['selected']
                                            ? 100
                                            : 600],
                                        blurRadius: 1.2,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: hp(0.9)),
                              Container(
                                margin: EdgeInsets.only(right: 0),
                                child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      status[index]['title'],
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.BackPrimaryGray,
                                        fontSize: tablet ? hp(1.5) : wp(2.5),
                                      ),
                                    )),
                              )
                            ],
                          ),
                        );
                      }),
                    )
                  : Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(6, (index) {
                            var totalWidth = wp(96) - hp(3);
                            var circleSize = tablet
                                ? (0.65 * totalWidth / 6)
                                : (0.7 * totalWidth / 6);
                            return Container(
                              width: totalWidth / 6,
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Center(
                                    child: Container(
                                      height: circleSize,
                                      width: circleSize,
                                      decoration: BoxDecoration(
                                        border: status[index]['selected']
                                            ? Border.all(
                                                width: tablet ? 3.41 : 3,
                                                color: Color(0xFF417505),
                                              )
                                            : null,
                                        gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              tablet ? Colors.white : status[index]['color'],
                                              status[index]['color']
                                            ]),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(1.0, 1.0),
                                            color: Colors.grey[status[index]
                                                    ['selected']
                                                ? 100
                                                : 600],
                                            blurRadius: 1.2,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: hp(0.9)),
                                  Container(
                                    margin: EdgeInsets.only(right: 0),
                                    child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          status[index]['title'],
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.BackPrimaryGray,
                                            fontSize:
                                                tablet ? hp(1.5) : wp(2.6),
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            );
                          }),
                        ),
                        SizedBox(
                          height: hp(0.6),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(2, (index) {
                            var totalWidth = wp(96) - hp(3);
                            var circleSize = tablet
                                ? (0.65 * totalWidth / 6)
                                : (0.7 * totalWidth / 6);
                            return Container(
                              width: totalWidth / 6,
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Center(
                                    child: Container(
                                      height: circleSize,
                                      width: circleSize,
                                      decoration: BoxDecoration(
                                        border: status[index + 6]['selected']
                                            ? Border.all(
                                                width: tablet ? 3.41 : 3,
                                                color: Color(0xFF417505),
                                              )
                                            : null,
                                        gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              tablet ? Colors.white : status[index + 6]['color'],
                                              status[index + 6]['color']
                                            ]),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(1.0, 1.0),
                                            color: Colors.grey[status[index + 6]
                                                    ['selected']
                                                ? 100
                                                : 600],
                                            blurRadius: 1.2,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: hp(0.9)),
                                  Container(
                                    margin: EdgeInsets.only(right: 0),
                                    child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          status[index + 6]['title'],
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.BackPrimaryGray,
                                            fontSize:
                                                tablet ? hp(1.5) : wp(2.5),
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            );
                          }),
                        ),
                      ],
                    )
              /*GridView.count(
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 0.8,
              crossAxisCount: tablet ? 8 : 6,
              crossAxisSpacing: 0,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: status.map((Map i) {
                var circleSize = tablet ? hp(7) : wp(10.26);
                return Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Container(
                              height: circleSize,
                              width: circleSize,
                              decoration: BoxDecoration(
                                border: i['selected']
                                    ? Border.all(
                                        width: 3.41,
                                        color: Color(0xFF417505),
                                      )
                                    : null,
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [Colors.white, i['color']]),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(hp(0.2), hp(0.18)),
                                    color: Colors.grey[700],
                                    blurRadius: 1.2,
                                    spreadRadius: 1.2,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: hp(0.9)),
                          Container(
                            margin: EdgeInsets.only(right: 0),
                            child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  i['title'],
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.BackPrimaryGray,
                                    fontSize: tablet ? hp(1.5) : wp(2.5),
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),*/
              ),
        ],
      ),
    );
  }
}

class Amount extends StatelessWidget {
  const Amount({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: hp(2),
        left: tablet ? hp(3) : hp(0.5),
        right: tablet ? hp(3) : hp(0.5),
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.BackPrimaryGray,
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: hp(3),
              left: hp(3),
              right: hp(3),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              'AMOUNT',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.BackPrimaryGray,
                  fontSize: tablet ? hp(2.5) : wp(3.5),
                  letterSpacing: 1.5),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: hp(1.5)),
            child: EpaisaRange(),
            // color: Colors.red,
          ),
          Container(
            padding: EdgeInsets.only(
              left: hp(3),
              right: hp(3),
              bottom: hp(2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InsideShadowTextBox(hp: hp),
                InsideShadowTextBox(hp: hp),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class InsideShadowTextBox extends StatelessWidget {
  const InsideShadowTextBox({
    Key key,
    @required this.hp,
  }) : super(key: key);

  final Function hp;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: tablet ? hp(20) : hp(16),
      height: hp(5.5),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(hp(1.5)),
        border: Border.all(color: Colors.black12),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            offset: const Offset(0, 0),
          ),
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            offset: const Offset(-0, -0),
          ),
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            offset: const Offset(0, -0),
          ),
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
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
        alignment: Alignment.center,
        child: Text(
          '₹ 123',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.TermsGray,
            fontSize: hp(2),
          ),
        ),
      ),
    );
  }
}

class EpaisaRange extends StatefulWidget {
  const EpaisaRange({
    Key key,
  }) : super(key: key);

  @override
  _EpaisaRangeState createState() => _EpaisaRangeState();
}

class _EpaisaRangeState extends State<EpaisaRange> {
  RangeValues _values = RangeValues(0.0, 0.9);
  static final RangeThumbSelector _customRangeThumbSelector = (
    TextDirection textDirection,
    RangeValues values,
    double tapValue,
    Size thumbSize,
    Size trackSize,
    double dx,
  ) {
    final double start = (tapValue - values.start).abs();
    final double end = (tapValue - values.end).abs();
    return start < end ? Thumb.start : Thumb.end;
  };
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.green,

      child: SliderTheme(
        data: SliderThemeData(
          trackHeight: 3,
          activeTrackColor: Colors.grey,
          disabledActiveTrackColor: Colors.grey,
          disabledInactiveTrackColor: Colors.grey,
          // thumbColor: Colors.red,
          thumbSelector: _customRangeThumbSelector,
          // trackShape: RetroSliderTrackShape(),
          // thumbShape: _CustomRangeThumbShape(),
          // overlayShape: RoundSliderOverlayShape(overlayRadius: 0.0),
          rangeThumbShape: _CustomRangeThumbShape(),
        ),
        child: RangeSlider(
          activeColor: AppColors.PrimaryBlue,
          inactiveColor: Colors.grey,
          onChanged: (RangeValues values) {
            setState(() {
              _values = values;
            });
          },
          values: _values,
        ),
      ),
    );
  }
}

class _CustomRangeThumbShape extends RangeSliderThumbShape {
  static double _thumbSize = 15.0;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      Size(_thumbSize, _thumbSize);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    @required Animation<double> activationAnimation,
    @required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool isOnTop,
    @required SliderThemeData sliderTheme,
    TextDirection textDirection,
    Thumb thumb,
  }) {
    final Canvas canvas = context.canvas;
    final Gradient gradient = new LinearGradient(
      colors: <Color>[
        Color(0xFF001C51),
        Color(0xFF001C51),
        Color(0xFF2087F2),
        Color(0xFF2087F2),
      ],
      stops: [
        0.0,
        0.48,
        0.52,
        1.0,
      ],
      begin: Alignment(0.0, -1.0),
      end: Alignment(0.0, 1.0),
      // end: AlignmentDirectional.centerEnd,
    );
    Rect rect = new Rect.fromCircle(
      center: center,
      radius: 180,
    );
    Paint paint = Paint()
      // ..color = sliderTheme.thumbColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..shader = gradient.createShader(rect);

    // final Path thumbPath = Path();
    // thumbPath.addOval(Rect.fromCircle(center: center, radius: 10.0));
    // thumbPath.close();

    // canvas.drawPath(thumbPath, paint);
    canvas.drawCircle(center, 10.0, paint);
    // canvas.drawArc(rect, pi / 4, pi * 3 / 4, true, paint);
  }
}

class TriangleUpClipper extends CustomClipper<Path> {
  bool half;
  bool right;
  TriangleUpClipper({this.half: false, this.right: false});
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(half ? right ? size.width : 0.0 : size.width / 2, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleUpClipper oldClipper) => false;
}

class SettingsBloc {
  List<Map<String, dynamic>> map;
  StreamController<List<Map<String, dynamic>>> _controller =
      StreamController<List<Map<String, dynamic>>>.broadcast();
  Function(List<Map<String, dynamic>>) get push => _controller.sink.add;
  Stream<List<Map<String, dynamic>>> get stream => _controller.stream;
  var counter = 0;
  SettingsBloc();
  changeState(index) {
    map[index]['selected'] = !map[index]['selected'];
    push(map);
  }

  void dispose() {
    _controller.close();
  }
}

SettingsBloc settingsBloc = SettingsBloc();
