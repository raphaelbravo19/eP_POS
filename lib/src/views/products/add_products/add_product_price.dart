import 'dart:io';

import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/add_custom_barcode/add_custom_barcode_screen.dart';
import 'package:epaisa_pos/src/views/add_variations/add_variations_screen.dart';
import 'package:epaisa_pos/src/views/products/add_products/bloc/add_product_bloc.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_border.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_camera.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/cards/toggle_card.dart';
import 'package:epaisa_pos/src/widgets/dialogs/dialog_classic.dart';
import 'package:epaisa_pos/src/widgets/dialogs/screen_as_modal.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:flutter/material.dart';

class AddProductPriceScreen extends StatefulWidget {
  final AddProductBloc bloc;
  final Function changeTab;
  final Function getTemplate;
  AddProductPriceScreen({this.bloc, this.changeTab, this.getTemplate});
  @override
  _AddProductPriceScreenState createState() => _AddProductPriceScreenState();
}

class _AddProductPriceScreenState extends State<AddProductPriceScreen> {
  var cant = 0;
  @override
  void initState() {
    print("100000${widget.bloc.streamVariants.value}");
    cant = widget.bloc.streamVariants.value.length;
    print("100000");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    var isIOS = Platform.isIOS;

    void changeBloc(index, attr, val) {
      var current = widget.bloc.streamVariants.value;

      current[index]["attributes"][attr]["v"] = val;
      widget.bloc.changeVariants(current);
    }

    void changeParams(index, attr, val) {
      var current = widget.bloc.streamVariants.value;
      print("$index --- $attr");
      current[index][attr] = val;
      widget.bloc.changeVariants(current);
    }

    Widget _buildCard(index) {
      double fontSize = tablet ? hp(2.6) : wp(4.4);
      double separator = tablet ? hp(0.5) : hp(1);
      var listFields = [];
      List<String> defaultFields = [
        "SKU",
        "Cost Price (₹)",
        "MRP (₹)",
        "Inventory",
        "Threshold"
      ];
      List<String> defaultKeys = [
        "sku",
        "price",
        "mrp",
        "inventory",
        "threshold"
      ];
      var attrlength =
          widget.bloc.streamVariants.value[index]["attributes"].length;
      for (var i = 0; i < (((attrlength + 5) + 1) / 2); i++) {
        var areCustom1 = (i * 2) < attrlength;
        var index1 = areCustom1 ? i * 2 : (i * 2) - attrlength;
        var areCustom2 = (i * 2 + 1) < attrlength;
        var index2 = areCustom2 ? i * 2 + 1 : (i * 2 + 1) - attrlength;
        listFields.add(
          SizedBox(
            height: separator,
          ),
        );
        var initial1 = areCustom1
            ? widget.bloc.streamVariants.value[index]["attributes"][index1]["v"]
            : widget.bloc.streamVariants.value[index][defaultKeys[index1]];
        var initial2 = areCustom2
            ? widget.bloc.streamVariants.value[index]["attributes"][index2]["v"]
            : index2 < defaultKeys.length
                ? widget.bloc.streamVariants.value[index][defaultKeys[index2]]
                : "";
        listFields.add(
          Row(
            children: <Widget>[
              Expanded(
                child: TextfieldClassic(
                  paddingBottomInput: hp(1),
                  fontSize: fontSize,
                  alwaysFocus: true,
                  alwaysBlue: true,
                  initialValue: initial1,
                  onChanged: (str) {
                    if (areCustom1)
                      changeBloc(index, index1, str);
                    else {
                      changeParams(index, defaultKeys[index1], str);
                    }
                  },
                  labelText: areCustom1
                      ? widget.bloc.streamVariants.value[index]["attributes"]
                          [index1]["k"]
                      : defaultFields[index1],
                ),
              ),
              (i * 2 + 1) < attrlength ||
                      (i * 2 + 1) - attrlength < defaultFields.length
                  ? Expanded(
                      child: TextfieldClassic(
                        paddingBottomInput: hp(1),
                        fontSize: fontSize,
                        leftBorder: true,
                        initialValue: initial2,
                        onChanged: (str) {
                          if (areCustom2)
                            changeBloc(index, index2, str);
                          else {
                            changeParams(index, defaultKeys[index2], str);
                          }
                        },
                        alwaysFocus: true,
                        alwaysBlue: true,
                        labelText: areCustom2
                            ? widget.bloc.streamVariants.value[index]
                                ["attributes"][index2]["k"]
                            : defaultFields[index2],
                      ),
                    )
                  : Expanded(
                      child: Container(),
                    )
            ],
          ),
        );
      }
      return Container(
        padding: tablet
            ? EdgeInsets.fromLTRB(hp(3), hp(0), hp(3), hp(3))
            : EdgeInsets.fromLTRB(hp(1.5), hp(1.5), hp(1.5), hp(1.5)),
        //height: hp(65),
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: tablet
              ? EdgeInsets.symmetric(horizontal: hp(3.2), vertical: hp(2.5))
              : EdgeInsets.all(tablet ? hp(3.2) : hp(1.5)),
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
            children: <Widget>[
              TextfieldClassic(
                  paddingBottomInput: hp(1),
                  fontSize: fontSize,
                  labelText: "Barcode",
                  alwaysFocus: true,
                  alwaysBlue: true,
                  noClear: true,
                  initialValue: widget.bloc.streamVariants.value[index]
                      ["barcode"],
                  onChanged: (str) {
                    changeParams(index, "barcode", str);
                  },
                  customIcon: Image.asset(
                    "assets/productsscreen/qrscanner.png",
                    height: fontSize * 1.5,
                  )),
              ...listFields
            ],
          ),
        ),
      );
    }

    Widget _buildCardVariation(index) {
      double fontSize = tablet ? hp(2.8) : wp(4.4);
      double separator = tablet ? hp(0.5) : hp(1);
      var listFields = [];
      List<String> defaultFields = [
        "SKU",
        "Cost Price (₹)",
        "MRP (₹)",
        "Inventory",
        "Threshold"
      ];
      List<String> defaultKeys = [
        "sku",
        "price",
        "mrp",
        "inventory",
        "threshold"
      ];
      var attrlength =
          widget.bloc.streamVariants.value[index]["attributes"].length;
      for (var i = 0; i < (((attrlength + 5) + 1) / 2); i++) {
        var areCustom1 = (i * 2) < attrlength;
        var index1 = areCustom1 ? i * 2 : (i * 2) - attrlength;
        var areCustom2 = (i * 2 + 1) < attrlength;
        var index2 = areCustom2 ? i * 2 + 1 : (i * 2 + 1) - attrlength;
        listFields.add(
          SizedBox(
            height: separator,
          ),
        );
        var initial1 = areCustom1
            ? widget.bloc.streamVariants.value[index]["attributes"][index1]["v"]
            : widget.bloc.streamVariants.value[index][defaultKeys[index1]];
        var initial2 = areCustom2
            ? widget.bloc.streamVariants.value[index]["attributes"][index2]["v"]
            : index2 < defaultKeys.length
                ? widget.bloc.streamVariants.value[index][defaultKeys[index2]]
                : "";
        listFields.add(
          Row(
            children: <Widget>[
              Expanded(
                child: TextfieldClassic(
                  paddingBottomInput: hp(1),
                  fontSize: fontSize,
                  alwaysFocus: true,
                  alwaysBlue: true,
                  initialValue: initial1,
                  onChanged: (str) {
                    if (areCustom1)
                      changeBloc(index, index1, str);
                    else {
                      changeParams(index, defaultKeys[index1], str);
                    }
                  },
                  labelText: areCustom1
                      ? widget.bloc.streamVariants.value[index]["attributes"]
                          [index1]["k"]
                      : defaultFields[index1],
                ),
              ),
              (i * 2 + 1) < attrlength ||
                      (i * 2 + 1) - attrlength < defaultFields.length
                  ? Expanded(
                      child: TextfieldClassic(
                        paddingBottomInput: hp(1),
                        fontSize: fontSize,
                        leftBorder: true,
                        initialValue: initial2,
                        onChanged: (str) {
                          if (areCustom2)
                            changeBloc(index, index2, str);
                          else {
                            changeParams(index, defaultKeys[index2], str);
                          }
                        },
                        alwaysFocus: true,
                        alwaysBlue: true,
                        labelText: areCustom2
                            ? widget.bloc.streamVariants.value[index]
                                ["attributes"][index2]["k"]
                            : defaultFields[index2],
                      ),
                    )
                  : Expanded(
                      child: Container(),
                    )
            ],
          ),
        );
      }
      return Container(
        padding: tablet
            ? EdgeInsets.fromLTRB(hp(3), hp(0), hp(3), hp(3))
            : EdgeInsets.fromLTRB(hp(1.5), 0, hp(1.5), hp(1.5)),
        //height: hp(65),
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: tablet
              ? EdgeInsets.symmetric(horizontal: hp(3.2), vertical: hp(2.5))
              : EdgeInsets.all(tablet ? hp(3.2) : hp(1.5)),
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
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  ButtonCamera(
                    size: tablet ? hp(16) : wp(25),
                  ),
                  SizedBox(
                    width: tablet ? hp(2) : wp(3),
                  ),
                  Expanded(
                    child: TextfieldClassic(
                      paddingBottomInput: hp(1),
                      fontSize: fontSize,
                      noClear: true,
                      alwaysFocus: true,
                      alwaysBlue: true,
                      initialValue: widget.bloc.streamVariants.value[index]
                          ["name"],
                      onChanged: (str) {
                        changeParams(index, "name", str);
                      },
                      labelText: "Variant Name",
                    ),
                  )
                ],
              ),
              SizedBox(
                height: separator,
              ),
              TextfieldClassic(
                  paddingBottomInput: hp(1),
                  fontSize: fontSize,
                  labelText: "Barcode",
                  alwaysFocus: true,
                  alwaysBlue: true,
                  noClear: true,
                  initialValue: widget.bloc.streamVariants.value[index]
                      ["barcode"],
                  onChanged: (str) {
                    changeParams(index, "barcode", str);
                  },
                  customIcon: Image.asset(
                    "assets/productsscreen/qrscanner.png",
                    height: fontSize * 1.5,
                  )),
              ...listFields
            ],
          ),
        ),
      );
    }

    Widget _buildAddModule() {
      return Expanded(
        child: Container(
          padding: EdgeInsets.only(right: tablet ? wp(1) : 0),
          child: Column(
            children: <Widget>[
              Spacer(
                flex: 1,
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(hp(1), 0, hp(1), hp(2)),
                  child: ButtonGradient(
                    callback: () {
                      if (widget.changeTab != null) {
                        widget.changeTab(2);
                      }
                    },
                    paddingVertical: tablet ? hp(2.1) : hp(1.8),
                    borderRadius: hp(2),
                    fontSize: hp(1.7),
                    title: "NEXT",
                  )),
            ],
          ),
        ),
      );
    }

    return Stack(
      alignment: Alignment.topCenter,
      fit: StackFit.expand,
      children: <Widget>[
        SingleChildScrollView(
            padding: EdgeInsets.only(top: hp(1.5), bottom: tablet ? 0 : hp(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: wp(tablet ? 2 : 3)),
                    child: ToggleCard(
                      toggleSize: tablet ? hp(1.8) : hp(1.4),
                      letterSpacing: hp(0.02),
                      fontSize: tablet ? hp(2.3) : wp(3.5),
                      paddingHorizontal: hp(3),
                      paddingVertical: tablet ? hp(1.5) : hp(2),
                      description: "Do you want custom barcodes?",
                      onChanged: (val) {
                        if (val) {
                          Navigator.of(context).push(new PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) {
                              return DialogClassic(
                                content: () {
                                  return AddCustomBarcodeScreen();
                                },
                                //content: AddCustomBarcodeScreen(),
                              );
                            },
                          ));
                        }
                      },
                    )),
                if (tablet)
                  SizedBox(
                    height: hp(1.5),
                  ),
                //_buildCard(),
                ...List.generate(cant, (index) {
                  if (cant > 1)
                    return _buildCardVariation(index);
                  else {
                    return _buildCard(index);
                  }
                }),
                Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: wp(tablet ? 2 : 3)),
                    child: ButtonBorder(
                      //filled: true,
                      callback: () async {
                        var variants = widget.bloc.streamVariants.value;
                        var template = await widget.getTemplate();
                        variants.add(template);
                        widget.bloc.changeVariants(variants);
                        setState(() {
                          cant++;
                        });
                      },
                      elevation: 0.5,
                      paddingVertical: tablet ? hp(2.1) : hp(1.5),
                      borderRadius: hp(2),
                      borderWidth: 2,
                      fontWeight: FontWeight.w700,
                      fontSize: tablet ? hp(1.7) : hp(1.6),
                      title: "+ ADD VARIATIONS",
                    )),
                SizedBox(
                  height: !tablet ? 0 : hp(1.5),
                )
                // _buildAddModule()
              ],
            )),
        !tablet
            ? Positioned(
                height: hp(8),
                width: wp(98),
                top: isIOS ? hp(71.5) : hp(76),
                child: Container(
                  padding: EdgeInsets.fromLTRB(hp(1), 0, 0, hp(2)),
                  child: ButtonGradient(
                    callback: () {
                      if (widget.changeTab != null) {
                        widget.changeTab(2);
                      }
                    },
                    paddingVertical: tablet ? hp(2.1) : hp(1.8),
                    borderRadius: hp(2),
                    fontSize: hp(1.7),
                    title: "NEXT",
                  ),
                ),
              )
            : SizedBox(
                height: 0,
                width: 0,
              ),
      ],
    ) //ListView(children: <Widget>[],)
        ;
  }
}
