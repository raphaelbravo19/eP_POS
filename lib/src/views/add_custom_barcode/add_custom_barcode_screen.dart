import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_border.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_dropdown.dart';
import 'package:epaisa_pos/src/widgets/texts/text_blue.dart';
import 'package:epaisa_pos/src/widgets/texts/text_gray.dart';
import 'package:flutter/material.dart';

class AddCustomBarcodeScreen extends StatefulWidget {
  @override
  _AddCustomBarcodeScreenState createState() => _AddCustomBarcodeScreenState();
}

class _AddCustomBarcodeScreenState extends State<AddCustomBarcodeScreen> {
  int _selected;

  @override
  void initState() {
    _selected = 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));

    Widget _tabNavigator() {
      List<String> options = [lang('create'), lang('print')];
      List<Widget> tabs = new List<Widget>();
      //var counter = 0;
      for (var i = 0; i < options.length; i++) {
        bool isSelected = i == _selected;
        var x = options[i];
        tabs.add(Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selected = i;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: isSelected
                              ? AppColors.PrimaryBlue
                              : AppColors.DisabledBorder,
                          width: 2))),
              alignment: Alignment.center,
              child: isSelected
                  ? TextBlue(
                      title: x,
                      fontSize: tablet ? hp(2) : hp(1.6),
                      fontWeight: FontWeight.w700,
                    )
                  : TextGray(
                      title: x,
                      fontSize: tablet ? hp(2) : hp(1.6),
                      fontWeight: FontWeight.w700,
                      opacity: 0.6,
                    ),
            ),
          ),
        ));
      }
      return Container(
        height: tablet ? hp(6) : hp(5),
        width: wp(94),
        child: Row(
          children: tabs,
        ),
      );
    }

    Widget _buildAddModule() {
      return Expanded(
        child: Container(
          //padding: EdgeInsets.only(right: tablet ? wp(1) : 0),
          child: Column(
            children: <Widget>[
              Spacer(
                flex: 1,
              ),
              Container(
                  padding: EdgeInsets.symmetric(
                      vertical: tablet ? 0 : hp(2),
                      horizontal: tablet ? hp(3.2) : wp(3)),
                  child: ButtonGradient(
                    callback: () {
                      //_showDialog("hola");
                    },
                    fontWeight: FontWeight.w700,
                    paddingVertical: tablet ? hp(2) : hp(1.8),
                    borderRadius: hp(2.3),
                    fontSize: tablet ? hp(1.9) : hp(1.7),
                    title: _selected == 0
                        ? lang('save', u: true)
                        : lang('print', u: true),
                  )),
            ],
          ),
        ),
      );
    }

    Widget _firstScreen() {
      return Column(
        children: <Widget>[
          Container(
            width: tablet ? hp(65) : wp(94),
            padding: EdgeInsets.symmetric(vertical: hp(1), horizontal: wp(2.5)),
            child: FittedBox(
              child: TextGray(
                fontWeight: FontWeight.w700,
                title: lang('individual_barcodes_for_product'),
              ),
            ),
          ),
          SizedBox(
            height: hp(0.5),
          ),
          Container(
              width: tablet ? hp(65) : wp(94),
              padding: EdgeInsets.symmetric(horizontal: wp(2.5)),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ButtonGradient(
                      filled: true,
                      paddingVertical: tablet ? hp(2.1) : hp(1.8),
                      borderRadius: hp(2.3),
                      fontSize: tablet ? hp(2) : hp(1.7),
                      title: lang('yes', u: true),
                    ),
                  ),
                  SizedBox(
                    width: tablet ? wp(2) : wp(3),
                  ),
                  Expanded(
                    child: ButtonBorder(
                      //filled: true,
                      borderWidth: tablet ? 3 : 1.5,

                      paddingVertical: tablet ? hp(1.6) : hp(1.5),
                      borderRadius: hp(2.3),
                      fontSize: tablet ? hp(2) : hp(1.7),
                      title: lang('no', u: true),
                    ),
                  )
                ],
              )),
          SizedBox(
            height: hp(2.5),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: wp(3)),
            child: TextGray(
              fontSize: tablet ? hp(2) : hp(1.85),
              fontWeight: FontWeight.w700,
              title: lang('choose_barcode_type'),
            ),
          ),
          SizedBox(
            height: hp(1.3),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: wp(3)),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: hp(2)),
                    decoration: BoxDecoration(
                      color: AppColors.PrimaryWhite,
                      borderRadius: BorderRadius.circular(hp(1)),
                      border: Border.all(
                          color: AppColors.DisabledBorder, width: 0.5),
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.DarkGray.withOpacity(0.35),
                            offset: Offset(0, 2),
                            blurRadius: 1)
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: hp(10),
                        ),
                        Text(
                          "1D Barcodes",
                          style: TextStyle(
                              fontSize: hp(1.7),
                              fontWeight: FontWeight.w700,
                              color: AppColors.DarkGray.withOpacity(0.8)),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: wp(1.2),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: hp(2)),
                    decoration: BoxDecoration(
                      color: AppColors.PrimaryWhite,
                      borderRadius: BorderRadius.circular(hp(1)),
                      border: Border.all(
                          color: AppColors.DisabledBorder, width: 0.5),
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.DarkGray.withOpacity(0.35),
                            offset: Offset(0, 2),
                            blurRadius: 1)
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: hp(10),
                        ),
                        Text("2D Barcodes",
                            style: TextStyle(
                                fontSize: hp(1.7),
                                fontWeight: FontWeight.w700,
                                color: AppColors.DarkGray.withOpacity(0.8)))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: wp(1.2),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: hp(2)),
                    decoration: BoxDecoration(
                      color: AppColors.PrimaryWhite,
                      borderRadius: BorderRadius.circular(hp(1)),
                      border: Border.all(
                          color: AppColors.DisabledBorder, width: 0.5),
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.DarkGray.withOpacity(0.35),
                            offset: Offset(0, 2),
                            blurRadius: 1)
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: hp(10),
                        ),
                        Text("(QR) Codes",
                            style: TextStyle(
                                fontSize: hp(1.7),
                                fontWeight: FontWeight.w700,
                                color: AppColors.DarkGray.withOpacity(0.8)))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          _buildAddModule(),
          SizedBox(
            height: wp(2),
          ),
        ],
      );
    }

    Widget _rowItem(String name, String type) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: wp(4), vertical: hp(1)),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: AppColors.DisabledBorder, width: 2))),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                        color: AppColors.DarkGray.withOpacity(0.8),
                        fontWeight: FontWeight.w700,
                        fontSize: hp(2)),
                  ),
                  Text(
                    type,
                    style: TextStyle(
                        color: AppColors.DarkGray.withOpacity(0.8),
                        fontWeight: FontWeight.w700,
                        fontSize: hp(2)),
                  )
                ],
              ),
            ),
            Container(
                width: tablet ? wp(3) : wp(6),
                child: Text(
                  "=",
                  style: TextStyle(
                      color: AppColors.PrimaryBlue,
                      fontWeight: FontWeight.w700,
                      fontSize: hp(2.2)),
                )),
            Expanded(
              flex: 1,
              child: TextfieldClassic(
                center: true,
                noClear: true,
                fontSize: hp(2.4),
                paddingBottomInput: hp(0.5),
              ),
            ),
          ],
        ),
      );
    }

    Widget _rowInputs() {
      return Container(
          child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: wp(4),
            ),
            child: Row(
              children: <Widget>[
                Spacer(
                  flex: 2,
                ),
                SizedBox(width: tablet ? wp(3) : wp(6)),
                Expanded(
                    flex: 1,
                    child: FittedBox(
                        child: Text(
                      "No. of barcodes",
                      style: TextStyle(
                        color: AppColors.DarkGray.withOpacity(0.6),
                        fontWeight: FontWeight.w700,
                      ),
                    )))
              ],
            ),
          ),
          _rowItem("Heinz Ketchup", "Red, 1KG"),
          _rowItem("Heinz Ketchup", "Red, 500 Gms"),
          _rowItem("Heinz Ketchup", "Blue, 1KG"),
          _rowItem("Heinz Ketchup", "Blue, 500 Gms")
        ],
      ));
    }

    Widget _secondScreen() {
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: hp(1), horizontal: wp(3)),
            child: TextBlue(
              fontSize: hp(2),
              fontWeight: FontWeight.w700,
              title: "Select Size of Barcode",
            ),
          ),
          SizedBox(
            height: hp(0.5),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: wp(4)),
            child: TextfieldDropdown(
              items: [
                {'name': '3" x 2"', 'value': 0},
                {"name": '3" x 3"', "value": 1},
                {"name": '3" x 4"', "value": 2}
              ],
              paddingBottomInput: hp(1.1),
              fontSize: hp(2.2),
              labelText: "Barcode Size",
            ),
          ),
          SizedBox(
            height: hp(1),
          ),
          _rowInputs(),
          _buildAddModule(),
          SizedBox(
            height: wp(2),
          ),
        ],
      );
    }

    var container = Container(
        padding: EdgeInsets.symmetric(horizontal: wp(1)),
        alignment: Alignment.center,
        height: hp(7),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: AppColors.DarkGray.withOpacity(0.4),
                    width: hp(0.2)))),
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Text(
                lang('custom_barcodes'),
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: hp(2.7),
                    color: AppColors.DarkGray),
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              right: tablet ? hp(.5) : hp(1),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: Image.asset(
                      "assets/general_icons/xbutton.png",
                      color: AppColors.DarkGray,
                      height: hp(2.5),
                    ),
                  )),
            )
          ],
        ));
    return Container(
        width: tablet ? hp(65) : wp(94),
        decoration: BoxDecoration(
            color: AppColors.PrimaryWhite,
            borderRadius: BorderRadius.circular(hp(1.5))),
        child: Column(
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              container,
              _tabNavigator(),
              Container(
                  height: tablet ? hp(80) : hp(78),
                  child: _selected == 0 ? _firstScreen() : _secondScreen()),
            ]

            //ListView(children: <Widget>[],)
            ));
  }
}
