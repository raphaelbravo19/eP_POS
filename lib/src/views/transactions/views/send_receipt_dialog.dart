import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/widgets/buttons/epaisa_button.dart';
import 'package:epaisa_pos/src/widgets/textfields/texfield_number.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:flutter/material.dart';

class SendReceiptDialog extends StatefulWidget {
  SendReceiptDialog({
    Key key,
  }) : super(key: key);

  @override
  SendReceiptDialogState createState() => SendReceiptDialogState();
}

class SendReceiptDialogState extends State<SendReceiptDialog> {
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
                        "Send Receipt",
                        style: TextStyle(
                          fontSize: tablet ? isIOS? hp(3) : hp(3.2) : wp(5.6),
                          fontWeight: FontWeight.w700,
                          color: AppColors.DarkGray,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: isIOS? -hp(0.5) : hp(0.1),
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
                            height: tablet ? isIOS? hp(2.5) : hp(3) : wp(4.3),
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
              Container(
                padding:
                    EdgeInsets.symmetric(vertical: hp(2), horizontal: hp(4)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: FittedBox(
                        child: Text(
                          'How do you want to receive your receipts?',
                          style: TextStyle(
                            fontSize: tablet ? 18 : wp(3.6),
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(71, 82, 93, 1),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: hp(1)),
                      child: TextfieldClassic(
                        paddingBottomInput: 6,
                        fontSize: tablet ? 18 : wp(4),
                        labelText: eptxt('email'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: hp(1)),
                      child: TextfieldNumber(
                        paddingBottomInput: 6,
                        fontSize: tablet ? 18 : wp(4),
                        labelText: eptxt('mobile_number'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: hp(2)),
                      child: EpaisaButton.medium(onPress: () {}, title: 'SEND'),
                    ),
                    Text(
                      eptxt('send_receipt_note'),
                      style: TextStyle(
                        fontSize: tablet ? 14 : wp(2.8),
                        fontWeight: FontWeight.w600,
                        color: AppColors.BackPrimaryGray,
                      ),
                      textAlign: TextAlign.center,
                    ),
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
