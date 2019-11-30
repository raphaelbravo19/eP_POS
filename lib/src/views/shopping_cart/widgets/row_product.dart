import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/shopping_cart/widgets/check_field.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_border.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_camera.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_toggle.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_dropdown.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_dropdown_with_field.dart';
import 'package:flutter/material.dart';

class RowProduct extends StatefulWidget {
  RowProduct({Key key, @required this.product, this.transaction = false})
      : super(key: key);

  final Map<String, dynamic> product;
  final bool transaction;
  @override
  _RowProductState createState() => _RowProductState();
}

class _RowProductState extends State<RowProduct> {
  bool open = false;

  void closeInfo() {
    setState(() {
      open = false;
    });
  }

  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                open = true;
              });
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(wp(0.2), tablet ? hp(0.7) : hp(0.5),
                  wp(1.6), tablet ? hp(0.7) : hp(0.5)),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: tablet ? wp(0.5) : wp(1.3)),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.DarkGray,
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: tablet ? wp(0.3) : wp(0.5)),
                      height: tablet ? wp(1.6) : wp(3.6),
                      width: tablet ? wp(1.6) : wp(3.6),
                      child: Image.asset('assets/leftdrawer/packages.png'),
                    ),
                  ),
                  Expanded(
                    flex: 12,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.product["description"],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: tablet ? hp(2.1) : hp(1.9),
                          fontWeight: FontWeight.w600,
                          color: AppColors.BackPrimaryGray,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        widget.product["Qty"],
                        style: TextStyle(
                            fontSize: tablet ? hp(2.1) : hp(1.9),
                            fontWeight: FontWeight.w600,
                            color: AppColors.BackPrimaryGray),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "₹ ${widget.product["Price"]}",
                        style: TextStyle(
                            fontSize: tablet ? hp(2.1) : hp(1.9),
                            fontWeight: FontWeight.w700,
                            color: AppColors.PrimaryBlue),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          widget.transaction
              ? Container()
              : open
                  ? Container(
                      //height: hp(10),
                      padding: EdgeInsets.symmetric(
                          horizontal: tablet ? wp(1.2) : wp(2.3)),
                      child: EditProduct(
                        closeinfo: closeInfo,
                      ),
                    )
                  : Container()
        ],
      ),
    );
  }
}

class EditProduct extends StatefulWidget {
  EditProduct({Key key, this.closeinfo}) : super(key: key);
  final Function closeinfo;
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  bool gstValue = false;
  bool vatValue = false;
  GlobalKey<ButtonToggleState> gstController =
      new GlobalKey<ButtonToggleState>();
  GlobalKey<ButtonToggleState> vatController =
      new GlobalKey<ButtonToggleState>();
  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    double fontSize = tablet ? hp(2.4) : wp(4);
    double separator = tablet ? hp(0.5) : hp(1);
    return Container(
      padding: gstValue || vatValue
          ? EdgeInsets.all(0)
          : tablet
              ? EdgeInsets.symmetric(horizontal: hp(3.2), vertical: hp(2.5))
              : EdgeInsets.symmetric(horizontal: wp(5), vertical: hp(2)),
      decoration: BoxDecoration(
        borderRadius: gstValue || vatValue
            ? BorderRadius.circular(0)
            : BorderRadius.circular(hp(1.2)),
        color: gstValue || vatValue
            ? AppColors.PrimaryWhite.withOpacity(0)
            : AppColors.PrimaryWhite,
        boxShadow: gstValue || vatValue
            ? []
            : [
                new BoxShadow(
                    color: AppColors.DarkGray.withOpacity(tablet ? 0.6 : 0.5),
                    offset: new Offset(0.3, 2.0),
                    blurRadius: 2.0),
                new BoxShadow(
                    color: AppColors.DarkGray.withOpacity(tablet ? 0.6 : 0.5),
                    offset: new Offset(-0.6, 0),
                    blurRadius: 1.0)
              ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            padding: !(gstValue || vatValue)
                ? EdgeInsets.all(0)
                : tablet
                    ? EdgeInsets.symmetric(
                        horizontal: hp(3.2), vertical: hp(2.5))
                    : EdgeInsets.symmetric(horizontal: wp(5), vertical: hp(2)),
            decoration: BoxDecoration(
              borderRadius: !(gstValue || vatValue)
                  ? BorderRadius.circular(0)
                  : BorderRadius.only(
                      topLeft: Radius.circular(hp(1.2)),
                      topRight: Radius.circular(hp(1.2))),
              color: !(gstValue || vatValue)
                  ? AppColors.PrimaryWhite.withOpacity(0)
                  : AppColors.PrimaryWhite,
              boxShadow: !(gstValue || vatValue)
                  ? []
                  : [
                      new BoxShadow(
                          color: AppColors.DarkGray.withOpacity(
                              tablet ? 0.6 : 0.5),
                          offset: new Offset(0.3, 2.0),
                          blurRadius: 2.0),
                      new BoxShadow(
                          color: AppColors.DarkGray.withOpacity(
                              tablet ? 0.6 : 0.5),
                          offset: new Offset(-0.6, 0),
                          blurRadius: 1.0)
                    ],
            ),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    ButtonCamera(
                      size: tablet ? wp(10) : wp(25),
                    ),
                    SizedBox(
                      width: tablet ? hp(2) : wp(3),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: TextfieldClassic(
                          fontSize: fontSize,
                          alwaysBlue: true,
                          paddingBottomInput: hp(1),
                          labelText: "Product Name",
                          alwaysFocus: true,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: separator,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      width: tablet ? wp(10) : wp(25),
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: TextfieldDropdownWithField(
                          fontSize: fontSize,
                          paddingBottomInput: hp(1),
                          showBlueDropdownColor: true,
                          labelText: "Quantity",
                          alwaysBlue: true,
                          items: ["%", "₹"],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: tablet ? hp(2) : wp(3),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: TextfieldClassic(
                          fontSize: fontSize,
                          paddingBottomInput: hp(1),
                          labelText: "Price (₹)",
                          alwaysBlue: true,
                          alwaysFocus: true,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: separator,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      width: tablet ? wp(10) : wp(25),
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: TextfieldDropdown(
                          fontSize: fontSize,
                          paddingLeft: fontSize * 1.2,
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
                                width: 2, color: AppColors.FocusText),
                          )),
                          width: tablet ? hp(2) : wp(3),
                        ),
                        padding: EdgeInsets.only(
                          bottom: fontSize * 0.2,
                        )),
                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: TextfieldClassic(
                          fontSize: fontSize,
                          leftBorder: true,
                          alwaysBlue: true,
                          paddingBottomInput: hp(1),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: tablet ? separator * 1.2 : separator * 0.8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                          //padding: EdgeInsets.only(right: 10),
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Add GST",
                            style: TextStyle(
                                fontSize: tablet ? wp(1.5) : wp(4),
                                fontWeight:
                                    tablet ? FontWeight.w600 : FontWeight.w500,
                                color: AppColors.DisabledText),
                          ),
                          ButtonToggle(
                            key: gstController,
                            onChanged: (val) {
                              setState(() {
                                gstValue = val;
                                vatValue = false;
                              });
                              vatController.currentState.toggleButton(false);
                            },
                            size: tablet ? wp(.8) : wp(2.2),
                          )
                        ],
                      )),
                    ),
                    SizedBox(
                      width: tablet ? wp(4.5) : wp(7),
                    ),
                    Expanded(
                      child: Container(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Add VAT",
                            style: TextStyle(
                                fontSize: tablet ? wp(1.5) : wp(4),
                                fontWeight:
                                    tablet ? FontWeight.w600 : FontWeight.w500,
                                color: AppColors.DisabledText),
                          ),
                          ButtonToggle(
                            key: vatController,
                            onChanged: (val) {
                              setState(() {
                                vatValue = val;
                                gstValue = false;
                              });
                              gstController.currentState.toggleButton(false);
                            },
                            size: tablet ? wp(0.8) : wp(2.2),
                          )
                        ],
                      )),
                    ),
                  ],
                ),
                !(gstValue || vatValue)
                    ? SizedBox(
                        height: tablet ? separator * 3 : separator * 1.2,
                      )
                    : Container(),
              ],
            ),
          ),
          gstValue
              ? Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: tablet ? wp(0.1) : wp(0.5)),
                  padding: tablet
                      ? EdgeInsets.symmetric(
                          horizontal: hp(3.2), vertical: hp(1.5))
                      : EdgeInsets.symmetric(
                          horizontal: wp(5), vertical: hp(2)),
                  decoration: BoxDecoration(
                    boxShadow: [
                      new BoxShadow(
                          color: AppColors.DarkGray.withOpacity(
                              tablet ? 0.6 : 0.5),
                          offset: new Offset(0.3, 2.0),
                          blurRadius: 2.0),
                      new BoxShadow(
                          color: AppColors.DarkGray.withOpacity(
                              tablet ? 0.6 : 0.5),
                          offset: new Offset(-0.6, 0),
                          blurRadius: 1.0),
                      new BoxShadow(
                        color: AppColors.DisabledBorder,
                        offset: Offset(0, 1),
                        spreadRadius: -0.2,
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                  child: CheckField(
                                size: tablet ? wp(1.8) : wp(4.5),
                                text: "Intrastate",
                              )),
                              SizedBox(
                                width: wp(3),
                              ),
                              Expanded(
                                  child: CheckField(
                                size: tablet ? wp(1.8) : wp(4.5),
                                text: "Interstate",
                              ))
                            ],
                          ),
                          SizedBox(
                              height: tablet ? separator * 3 : separator * 1.2),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Expanded(
                                child: Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: <Widget>[
                                    SizedBox(
                                      child: Container(
                                        alignment: Alignment.bottomLeft,
                                        child: TextfieldDropdown(
                                          fontSize: fontSize,
                                          paddingLeft: fontSize * 1.2,
                                          paddingBottomInput: hp(1),

                                          showBlueDropdownColor: true,
                                          labelText: "SGST & CGST",
                                          alwaysBlue: true,
                                          defaultText: '%',
                                          //items: ["%", "₹"],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      margin: EdgeInsets.only(
                                          left: tablet ? wp(9) : wp(23)),
                                      child: TextfieldDropdown(
                                        items: [
                                          {"name": "5", "value": 0},
                                          {"name": "10", "value": 1},
                                          {"name": "15", "value": 2},
                                        ],
                                        fontSize: fontSize,
                                        leftBorder: true,
                                        scaleDropdown: 1.5,
                                        alwaysBlue: true,
                                        paddingLeft: tablet ? wp(1) : wp(3),
                                        showBlueDropdownColor: true,
                                        paddingBottomInput: hp(0.7),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: separator * 0.5,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              SizedBox(
                                width: tablet ? wp(9) : wp(23),
                                child: Container(
                                  alignment: Alignment.bottomLeft,
                                  child: TextfieldDropdown(
                                    fontSize: fontSize,
                                    paddingLeft: fontSize * 1.2,
                                    paddingBottomInput: hp(1),
                                    showBlueDropdownColor: true,
                                    labelText: "CESS",
                                    alwaysBlue: true,
                                    defaultText: '%',
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.bottomLeft,
                                  child: TextfieldClassic(
                                    fontSize: fontSize,
                                    paddingLeft: tablet ? wp(1.45) : wp(4),
                                    leftBorder: true,
                                    alwaysBlue: true,
                                    alwaysFocus: true,
                                    paddingBottomInput: hp(1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                )
              : vatValue
                  ? Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: tablet ? wp(0.1) : wp(0.5)),
                      padding: tablet
                          ? EdgeInsets.symmetric(
                              horizontal: hp(3.2), vertical: hp(1.5))
                          : EdgeInsets.symmetric(
                              horizontal: wp(5), vertical: hp(2)),
                      decoration: BoxDecoration(
                        boxShadow: [
                          new BoxShadow(
                              color: AppColors.DarkGray.withOpacity(
                                  tablet ? 0.6 : 0.5),
                              offset: new Offset(0.3, 2.0),
                              blurRadius: 2.0),
                          new BoxShadow(
                              color: AppColors.DarkGray.withOpacity(
                                  tablet ? 0.6 : 0.5),
                              offset: new Offset(-0.6, 0),
                              blurRadius: 1.0),
                          new BoxShadow(
                            color: AppColors.DisabledBorder,
                            offset: Offset(0, 1),
                            spreadRadius: -0.2,
                            blurRadius: 0,
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  SizedBox(
                                    width: tablet ? wp(9) : wp(23),
                                    child: Container(
                                      alignment: Alignment.bottomLeft,
                                      child: TextfieldDropdown(
                                        fontSize: fontSize,
                                        paddingLeft: fontSize * 1.2,

                                        paddingBottomInput: hp(1),

                                        showBlueDropdownColor: true,
                                        labelText: "VAT",
                                        alwaysBlue: true,
                                        defaultText: '%',
                                        //items: ["%", "₹"],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.bottomLeft,
                                      child: TextfieldDropdown(
                                        items: [
                                          {"name": "5", "value": 0},
                                          {"name": "10", "value": 1},
                                          {"name": "15", "value": 2},
                                        ],
                                        fontSize: fontSize,
                                        leftBorder: true,
                                        alwaysBlue: true,
                                        paddingLeft: tablet ? wp(1) : wp(3),
                                        showBlueDropdownColor: true,
                                        paddingBottomInput:
                                            tablet ? hp(1) : hp(0.7),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  : Container(),
          Container(
            padding: !(gstValue || vatValue)
                ? EdgeInsets.all(0)
                : tablet
                    ? EdgeInsets.symmetric(
                        horizontal: hp(3.2), vertical: hp(2.5))
                    : EdgeInsets.symmetric(horizontal: wp(5), vertical: hp(2)),
            decoration: BoxDecoration(
              borderRadius: !(gstValue || vatValue)
                  ? BorderRadius.circular(0)
                  : BorderRadius.only(
                      bottomLeft: Radius.circular(hp(1.2)),
                      bottomRight: Radius.circular(hp(1.2))),
              color: !(gstValue || vatValue)
                  ? AppColors.PrimaryWhite.withOpacity(0)
                  : AppColors.PrimaryWhite,
              boxShadow: !(gstValue || vatValue)
                  ? []
                  : [
                      new BoxShadow(
                          color: AppColors.DarkGray.withOpacity(
                              tablet ? 0.6 : 0.5),
                          offset: new Offset(0.3, 2.0),
                          blurRadius: 2.0),
                      new BoxShadow(
                          color: AppColors.DarkGray.withOpacity(
                              tablet ? 0.6 : 0.5),
                          offset: new Offset(-0.6, 0),
                          blurRadius: 1.0)
                    ],
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                          child: ButtonBorder(
                        title: 'CANCEL',
                        textColor: AppColors.ErrorText,
                        borderRadius: tablet ? hp(2.5) : hp(2.9),
                        paddingVertical: hp(1.8),
                        fontSize: tablet ? hp(2) : wp(3),
                        fontWeight: FontWeight.w600,
                        borderColor: AppColors.ErrorText,
                        callback: () {
                          widget.closeinfo();
                        },
                      )),
                    ),
                    SizedBox(
                      width: wp(5),
                    ),
                    Expanded(
                      child: Container(
                          child: ButtonGradient(
                        title: 'SAVE',
                        borderRadius: tablet ? hp(2.5) : hp(2.9),
                        paddingVertical: hp(1.8),
                        fontSize: tablet ? hp(2) : wp(3),
                        fontWeight: FontWeight.w500,
                        callback: () {
                          widget.closeinfo();
                        },
                      )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
