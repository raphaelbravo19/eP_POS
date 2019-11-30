import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_border.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:flutter/material.dart';

class AddVariationsScreen extends StatefulWidget {
  @override
  _AddVariationsScreenState createState() => _AddVariationsScreenState();
}

class _AddVariationsScreenState extends State<AddVariationsScreen> {
  int cant;
  List<Map<String, dynamic>> variants = [
    {
      "fieldName": "Variant Name",
      "fieldValue": "",
      "variants": [
        {"fieldName": "Variant Value 1", "fieldValue": ""}
      ]
    }
  ];
  @override
  void initState() {
    cant = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));

    Widget _buildCard(data) {
      double fontSize = tablet ? hp(2.8) : hp(2.20);
      double separator = tablet ? hp(0.5) : hp(1);

      List<Widget> content = new List<Widget>();
      content.add(TextfieldClassic(
        paddingBottomInput: hp(1),
        fontSize: fontSize,
        labelText: data['fieldName'],
      ));
      List variants = data['variants'];
      for (var i = 0; i < variants.length; i++) {
        content.add(SizedBox(
          height: separator,
        ));
        content.add(
          Row(
            children: <Widget>[
              SizedBox(
                width: wp(5),
              ),
              Expanded(
                child: TextfieldClassic(
                  labelText: variants[i]['fieldName'],
                  paddingBottomInput: hp(1),
                  fontSize: fontSize,
                  onSubmitted: (value) {
                    setState(() {
                      data['variants'].add({
                        "fieldName":
                            "Variant Value ${data['variants'].length + 1}",
                        "fieldValue": "",
                      });
                    });
                  },
                ),
              ),
            ],
          ),
        );
      }

      return Container(
        padding: tablet
            ? EdgeInsets.fromLTRB(hp(1), hp(0), hp(1), hp(3))
            : EdgeInsets.fromLTRB(hp(1.5), hp(0.5), hp(1.5), hp(1.5)),
        //height: hp(65),
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: tablet
              ? EdgeInsets.symmetric(horizontal: hp(3.2), vertical: hp(2.5))
              : EdgeInsets.symmetric(
                  vertical: tablet ? hp(3.2) : hp(1.5),
                  horizontal: tablet ? hp(3.2) : wp(5)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(hp(1.2)),
            color: AppColors.PrimaryWhite,
            boxShadow: [
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
              children: content),
        ),
      );
    }

    Widget _buildAddModule() {
      return Container(
          padding: EdgeInsets.fromLTRB(
              tablet ? hp(3.2) : wp(3), 0, tablet ? hp(3.2) : wp(3), hp(2)),
          child: ButtonGradient(
            callback: () {
              //_showDialog("hola");
            },
            paddingVertical: tablet ? hp(2.1) : hp(1.8),
            borderRadius: hp(2),
            fontSize: tablet ? hp(2.3) : hp(1.7),
            title: "ADD VARIATONS",
          ));
    }

    return EpaisaScaffold(
        noImage: tablet,
        noSafe: tablet,
        appBar: !tablet
            ? EpaisaAppBar(
                back: true,
                title: "ADD VARIATIONS",
              )
            : null,
        body: Column(
          children: <Widget>[
            tablet
                ? Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: tablet ? wp(1) : wp(4)),
                    color:
                        tablet ? AppColors.PrimaryWhite : AppColors.PrimaryBlue,
                    alignment: Alignment.center,
                    height: tablet ? hp(7) : hp(9),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        tablet
                            ? Container(width: wp(6), child: Container())
                            : GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: wp(5),
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: tablet
                                        ? AppColors.DarkGray
                                        : AppColors.PrimaryWhite,
                                  ),
                                )),
                        Text(
                          tablet ? "Add Variations" : "ADD VARIATIONS",
                          style: TextStyle(
                              fontWeight:
                                  tablet ? FontWeight.w700 : FontWeight.w600,
                              fontSize: tablet ? hp(2.7) : hp(2),
                              color: tablet
                                  ? AppColors.DarkGray
                                  : AppColors.PrimaryWhite),
                          textAlign: TextAlign.center,
                        ),
                        !tablet
                            ? Container(width: wp(5), child: Container())
                            : GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(right: wp(1)),
                                  width: wp(3),
                                  child: Image.asset(
                                    "assets/general_icons/xbutton.png",
                                    color: tablet
                                        ? AppColors.DarkGray
                                        : AppColors.PrimaryWhite,
                                  ),
                                )),
                      ],
                    ),
                  )
                : SizedBox(),
            Expanded(
                child: SingleChildScrollView(
              padding: tablet
                  ? EdgeInsets.only(top: hp(2), bottom: hp(2))
                  : EdgeInsets.only(top: hp(1), bottom: hp(2)),
              child: Column(
                children: <Widget>[
                  ...variants.map((form) {
                    return _buildCard(form);
                  }).toList(),
                  // ...List.generate(cant, (index) {
                  //   return _buildCard();
                  // }),
                  Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: tablet ? hp(3.2) : wp(3)),
                      child: ButtonBorder(
                        callback: () {
                          setState(() {
                            variants.add({
                              "fieldName": "Variant Name",
                              "fieldValue": "",
                              "variants": [
                                {
                                  "fieldName": "Variant Value 1",
                                  "fieldValue": ""
                                }
                              ]
                            });
                          });
                        },
                        elevation: 0.5,
                        paddingVertical: tablet ? hp(2.1) : hp(1.5),
                        borderRadius: hp(2),
                        borderWidth: 2,
                        fontWeight: FontWeight.w700,
                        fontSize: tablet ? hp(2.1) : hp(1.6),
                        title: "+ ADD ANOTHER VARIANT",
                      )),
                ],
              ),
            )),
            _buildAddModule()
          ],
        ) //ListView(children: <Widget>[],)
        );
  }
}
