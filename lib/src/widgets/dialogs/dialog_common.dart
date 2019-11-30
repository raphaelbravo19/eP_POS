import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_dropdown.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_dropdown_with_field.dart';
import 'package:flutter/material.dart';

class DialogCommon extends StatefulWidget {
  final Widget child;
  final String title;
  final double width;
  final BuildContext context;
  final double fontSize;
  final bool padding;
  DialogCommon({
    this.width,
    this.child,
    this.title,
    Key key,
    this.context,
    this.fontSize = 0,
    this.padding = true,
  }) : super(key: key);

  productItem({image, title, price, promo, onTap}) {
    return Future.delayed(
      Duration.zero,
      () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Scaffold(
              backgroundColor: Colors.black.withOpacity(0.6),
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(hp(2)),
                      ),
                      width: tablet ? hp(60) : wp(90),
                      child: Stack(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: hp(1.56),
                                        left: wp(2),
                                        right: wp(2)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(hp(2)),
                                        border: Border.all(
                                          width: 1,
                                          color: Color(0xFF979797),
                                        ),
                                      ),
                                      width: tablet ? wp(22) : wp(22),
                                      height: tablet ? hp(10) : hp(12),
                                      child: Stack(
                                        children: <Widget>[
                                          Positioned.fill(
                                            child: Image.asset(
                                              'assets/manufacturerscreen/cocacola.png',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.PrimaryBlue,
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(hp(2)),
                                                ),
                                              ),
                                              child: Icon(Icons
                                                  .check_box_outline_blank),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "$title",
                                          style: TextStyle(
                                              color: Color(0xFF52565F),
                                              fontSize: fontSize == 0
                                                  ? hp(2.2)
                                                  : fontSize,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(height: hp(1)),
                                        Text(
                                          "₹ 148.50",
                                          style: TextStyle(
                                              color: Color(0xFF52565F),
                                              fontSize: hp(2.2),
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: hp(1)),
                              Container(height: 0.2, color: Color(0xFF6B6B6B)),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: hp(1),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ...promo.map(
                                      (value) {
                                        return Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: hp(0.2),
                                                horizontal: wp(3.61)),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "* $value",
                                              style: TextStyle(
                                                  color: Color(0xFF52565F),
                                                  fontSize: hp(1.7),
                                                  fontWeight: FontWeight.w600),
                                            ));
                                      },
                                    ).toList(),
                                  ],
                                ),
                              ),
                              Container(height: 0.2, color: Color(0xFF6B6B6B)),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: hp(2)),
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      flex: 1,
                                      child: TextfieldDropdownWithField(
                                        fontSize: tablet ? hp(2.4) : wp(4),
                                        paddingBottomInput: hp(1),
                                        showBlueDropdownColor: true,
                                        labelText: "Quantity",
                                        alwaysBlue: true,
                                        items: ["%", "₹"],
                                      ),
                                    ),
                                    SizedBox(width: hp(2)),
                                    Flexible(
                                      flex: 4,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          SizedBox(
                                            width: tablet ? wp(10) : wp(25),
                                            child: Container(
                                              alignment: Alignment.bottomLeft,
                                              child: TextfieldDropdown(
                                                fontSize:
                                                    tablet ? hp(2.4) : wp(4),
                                                paddingLeft: tablet
                                                    ? hp(2.4)
                                                    : wp(4) * 1.2,
                                                paddingBottomInput: hp(1),
                                                showBlueDropdownColor: true,
                                                labelText: "Discount",
                                                alwaysBlue: true,
                                                items: [
                                                  {"name": '%', "value": '%'},
                                                  {"name": '₹', "value": '₹'}
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                  bottom: BorderSide(
                                                      width: 2,
                                                      color:
                                                          AppColors.FocusText),
                                                )),
                                                width: tablet ? hp(2) : wp(3),
                                              ),
                                              padding: EdgeInsets.only(
                                                bottom: tablet
                                                    ? hp(2.4)
                                                    : wp(4) * 0.2,
                                              )),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.bottomLeft,
                                              child: TextfieldClassic(
                                                fontSize:
                                                    tablet ? hp(2.4) : wp(4),
                                                leftBorder: true,
                                                alwaysBlue: true,
                                                paddingBottomInput: hp(1),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: tablet ? hp(1) : hp(1.5),
                                    bottom: tablet ? hp(2) : hp(2)),
                                child: ButtonGradiant(
                                  tablet ? hp(1.5) : wp(3),
                                  tablet ? hp(45) : wp(70),
                                  'ADD',
                                  borderRadius: tablet ? hp(2.5) : hp(2.5),
                                  textStyle: TextStyle(
                                      fontSize: tablet ? hp(2.8) : hp(2),
                                      color: AppColors.PrimaryWhite,
                                      fontWeight: FontWeight.w600),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: hp(2),
                            right: hp(2),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topCenter,
                                  child: Image.asset(
                                    "assets/general_icons/xbutton.png",
                                    height: tablet ? hp(3) : hp(2.2),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  basic({String message}) {
    return Future.delayed(
      Duration.zero,
      () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    message,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: wp(10),
                  ),
                  ButtonGradiant(
                    tablet ? hp(3) : wp(3),
                    tablet ? hp(20) : wp(20),
                    'OK',
                    textStyle: TextStyle(
                        fontSize: tablet ? hp(2.8) : hp(2),
                        color: AppColors.PrimaryWhite,
                        fontWeight: FontWeight.w600),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  DialogCommonState createState() => DialogCommonState();
}

class DialogCommonState extends State<DialogCommon> {
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

    Widget content() {
      return Container(
        width: widget.width != null ? widget.width : (tablet ? wp(42) : wp(85)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(
                    0, hp(0.5), 0, widget.padding ? hp(1) : hp(0)),
                alignment: Alignment.center,
                child: Stack(
                  // alignment: Alignment.topRight,
                  children: <Widget>[
                    Container(
                      // color: Colors.blue,
                      padding: EdgeInsets.symmetric(
                          vertical: tablet ? hp(1.5) : hp(1)),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.LightGray,
                            width: 2.5,
                          ),
                        ),
                      ),
                      alignment: Alignment.center,
                      // width: (tablet ? wp(42) : wp(85)),
                      child: Text(
                        widget.title,
                        style: TextStyle(
                            fontSize: widget.fontSize != 0
                                ? widget.fontSize
                                : tablet ? hp(3.6) : hp(2.8),
                            fontWeight: FontWeight.w700,
                            color: AppColors.DarkGray),
                      ),
                    ),
                    Positioned(
                        top: tablet ? hp(1.5) : hp(1.3),
                        right: hp(1.5),
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                showModal = false;
                              });
                              Navigator.of(context).pop();
                            },
                            child: Image.asset(
                              "assets/general_icons/xbutton.png",
                              height: tablet ? hp(3.2) : hp(2.2),
                            ))),
                  ],
                ),
              ),
              widget.child
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
                        // width: (tablet ? wp(42) : wp(85)),
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
                              child: content(), // content
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
