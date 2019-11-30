import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/reset_password/widgets/otp_fields.dart';
import 'package:epaisa_pos/src/views/reset_password/widgets/timer.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/textfields/texfield_number.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_password.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatefulWidget {
  ConfirmationDialog({Key key, this.action}) : super(key: key);
  final Function action;
  @override
  ConfirmationDialogState createState() => ConfirmationDialogState();
}

class ConfirmationDialogState extends State<ConfirmationDialog> {
  bool showModal = true;
  bool resendDisabled = true;
  bool confirmationMethod = false;
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

    List<Widget> _titleContainer() {
      return [
        Text(eptxt('where_do_your_want'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.TextGray,
              fontSize: tablet ? hp(2.8) : hp(2.3),
              fontWeight: FontWeight.w600,
            )),
        Text(eptxt('confirmation_code'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.TextGray,
              fontSize: tablet ? hp(2.8) : hp(2.3),
              fontWeight: FontWeight.w600,
            ))
      ];
    }

    List<Widget> _fields() {
      return [
        SizedBox(
          height: hp(1.5),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: TextfieldClassic(
                labelText: eptxt('email'),
                fontSize: tablet ? hp(2.7) : hp(2.1),
                paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
                noClear: true,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (confirmationMethod )confirmationMethod = !confirmationMethod;
                });
              },
              child: Container(
                margin: EdgeInsets.only(left: hp(1), bottom: hp(1)),
                child: Image.asset(
                  "assets/createaccount/${confirmationMethod ? 'dis' : ''}agree.png",
                  height: tablet ? hp(4.7) : hp(3.8),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: hp(1.5)),
        Text(eptxt('or').toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.TextGray,
              fontSize: tablet ? hp(3.8) : hp(3),
              fontWeight: FontWeight.w700,
            )),
        SizedBox(height: hp(1.5)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: TextfieldNumber(
                labelText: eptxt('mobile_number'),
                fontSize: tablet ? hp(2.7) : hp(2.1),
                paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
                noClear: true,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (!confirmationMethod )confirmationMethod = !confirmationMethod;
                });
              },
              child: Container(
                  margin: EdgeInsets.only(left: hp(1), bottom: hp(0.5)),
                  child: Image.asset(
                      "assets/createaccount/${!confirmationMethod ? 'dis' : ''}agree.png",
                      height: tablet ? hp(4.7) : hp(3.8))),
            )
          ],
        ),
        SizedBox(
          height: hp(3.5),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: tablet ? wp(5) : wp(11)),
          child: ButtonGradient(
            callback: () {
              closeModal();
              widget.action();
            },
            title: eptxt('send').toUpperCase(),
            fontSize: hp(1.8),
            paddingVertical: tablet ? hp(2.1) : hp(1.8),
            borderRadius: hp(2.5),
          ),
        ),
        SizedBox(
          height: hp(3.5),
        ),
      ];
    }

    Widget content() {
      return Container(
        width: (tablet ? wp(37) : wp(85)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, hp(1.5), hp(1.5), hp(1)),
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showModal = false;
                    });
                    Navigator.of(context).pop();
                  },
                  child: Image.asset(
                    "assets/general_icons/xbutton.png",
                    height: tablet ? hp(2.5) : hp(2.2),
                  ),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: tablet ? wp(4) : wp(8)),
                child: Column(
                  children: <Widget>[..._titleContainer(), ..._fields()],
                ),
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
                        width: (tablet ? wp(37) : wp(85)),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(),
                            ),
                            Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      tablet ? wp(1) : wp(2)),
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
