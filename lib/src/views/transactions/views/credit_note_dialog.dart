import 'package:epaisa_pos/src/models/OrderItem.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/transactions/views/send_receipt_dialog.dart';
import 'package:epaisa_pos/src/widgets/buttons/epaisa_button.dart';
import 'package:epaisa_pos/src/widgets/epaisa/epaisa_checkbox.dart';
import 'package:flutter/material.dart';

class CreditNoteDialog extends StatefulWidget {
  CreditNoteDialog({
    Key key,
  }) : super(key: key);

  @override
  CreditNoteDialogState createState() => CreditNoteDialogState();
}

class CreditNoteDialogState extends State<CreditNoteDialog> {
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
                        "Credit Note",
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
        width: (tablet ? hp(60) : wp(95)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              header(),
              Container(
                margin: EdgeInsets.all(hp(2)),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        DetailItem(
                          hp: hp,
                          wp: wp,
                          name: 'Invoice No.',
                          value: '45612',
                          width: 300,
                          isTablet: tablet,
                        ),
                        DetailItem(
                          hp: hp,
                          wp: wp,
                          name: 'Payment ID.',
                          value: '7984654',
                          width: 300,
                          isTablet: tablet,
                        ),
                        DetailItem(
                          hp: hp,
                          wp: wp,
                          name: 'TransactionID',
                          value: '15698798',
                          width: 300,
                          isTablet: tablet,
                        ),
                        DetailItem(
                          hp: hp,
                          wp: wp,
                          name: 'Card No.',
                          value: 'XXXX XXXX XXXX 6544',
                          width: 300,
                          isTablet: tablet,
                        ),
                        DetailItem(
                          hp: hp,
                          wp: wp,
                          name: eptxt('date'),
                          value: '12 May 2019',
                          width: 300,
                          isTablet: tablet,
                        ),
                        DetailItem(
                          hp: hp,
                          wp: wp,
                          name: eptxt('time'),
                          value: '11:05 AM',
                          width: 300,
                          isTablet: tablet,
                        ),
                        DetailItem(
                          hp: hp,
                          wp: wp,
                          name: 'Status',
                          value: 'Approved',
                          width: 300,
                          valueColor: AppColors.NotificationGreen,
                          isTablet: tablet,
                        ),
                        DetailItem(
                          hp: hp,
                          wp: wp,
                          name: 'Credit Note',
                          value: '1234 5678 9012 3456',
                          width: 300,
                          isTablet: tablet,
                        ),
                        DetailItem(
                          hp: hp,
                          wp: wp,
                          name: 'Credit Date',
                          value: '15 May 2019',
                          width: 300,
                          isTablet: tablet,
                        ),
                        DetailItem(
                          hp: hp,
                          wp: wp,
                          name: 'Credit Validity',
                          value: '14 May 2020',
                          width: 300,
                          isTablet: tablet,
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: hp(1)),
                      child: Text(
                        'Credit Note Amount',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.BackPrimaryGray,
                          fontSize: tablet ? hp(2.4) : wp(3.5),
                        ),
                      ),
                    ),
                    Container(
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
                          fontSize: tablet ? hp(5) : wp(8),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: hp(2)),
                      child: Image.network(
                        'https://chart.googleapis.com/chart?chs=500x500&cht=qr&chl=http://misapinga.com&chld=L|1&choe=UTF-8',
                        width: tablet ? hp(15) : wp(25),
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(right: hp(1)),
                              child: EpaisaButton.withBorder(
                                title: 'PRINT',
                                onPress: () {},
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
                              child: EpaisaButton.medium(
                                title: 'SEND',
                                onPress: () {},
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

class DetailItem extends StatelessWidget {
  final String name;
  final String value;
  final double width;
  final bool isTablet;
  final Function hp;
  final Function wp;
  final Color valueColor;
  const DetailItem({
    Key key,
    this.name,
    @required this.hp,
    @required this.wp,
    this.value,
    this.valueColor = AppColors.BackPrimaryGray,
    this.width,
    this.isTablet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double fontSize = isTablet ? 18 : wp(3.5);
    return Container(
      margin: EdgeInsets.only(bottom: hp(1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 40,
            child: Container(
              width: width * 0.5,
              child: Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: fontSize,
                  color: AppColors.BackPrimaryGray,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            width: width * 0.15,
            // decoration: BoxDecoration(color: Colors.red),
            child: Text(
              ':',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: fontSize,
                color: AppColors.BackPrimaryGray,
              ),
            ),
          ),
          Expanded(
            flex: 60,
            child: Container(
              width: width * 0.35,
              alignment: Alignment.centerLeft,
              child: Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: fontSize,
                  color: valueColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
