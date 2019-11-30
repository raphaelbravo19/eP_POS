import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/packages/add_packages/add_package_screen.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/cards/toggle_card.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_tax_classic.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_tax_dropdown.dart';
import 'package:epaisa_pos/src/widgets/utils/dialogs_helper.dart';
import 'package:flutter/material.dart';

class AddPackageTaxesScreen extends StatefulWidget {
  final AddPackageBloc bloc;
  AddPackageTaxesScreen({this.bloc});

  @override
  _AddPackageTaxesScreenState createState() => _AddPackageTaxesScreenState();
}

class _AddPackageTaxesScreenState extends State<AddPackageTaxesScreen> {
  GlobalKey<ToggleCardState> gkey = new GlobalKey<ToggleCardState>();
  GlobalKey<ToggleCardState> vkey = new GlobalKey<ToggleCardState>();
  var status = -1;
  @override
  void initState() {
    super.initState();
    if (widget.bloc.isGSTStream.value != null) {
      if (widget.bloc.isGSTStream.value) {
        status = 1;
      }
    }
    if (widget.bloc.isVATStream.value != null) {
      if (widget.bloc.isVATStream.value) {
        status = 2;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));

    Widget _buildCard() {
      double fontSize = tablet ? hp(2.8) : hp(2.20);

      return status == -1
          ? Container()
          : status == 1
              ? Container(
                  padding: tablet
                      ? EdgeInsets.fromLTRB(hp(3), hp(0), hp(3), hp(3))
                      : EdgeInsets.all(hp(1.5)),
                  //height: hp(65),
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: tablet
                        ? EdgeInsets.symmetric(
                            horizontal: hp(3.2), vertical: hp(2.5))
                        : EdgeInsets.all(tablet ? hp(3.2) : hp(1.5)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(hp(1.2)),
                      color: AppColors.PrimaryWhite,
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
                            blurRadius: 1.0)
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: TextfieldTaxDrowpdown(
                                alwaysBlue: true,
                                paddingBottomInput: hp(2),
                                paddingTopInput: hp(0.8),
                                showArrow: true,
                                fontSize: fontSize,
                                labelText: "SGST & CGST",
                                items: [
                                  {"name": "5", "value": "5"},
                                  {"name": "10", "value": "10"},
                                  {"name": "15", "value": "15"},
                                ],
                              ),
                            ),
                            SizedBox(
                              width: wp(5),
                            ),
                            Expanded(
                              flex: 1,
                              child: TextfieldTaxClassic(
                                alwaysBlue: true,
                                paddingBottomInput: hp(2),
                                paddingTopInput: hp(0.8),
                                fontSize: fontSize,
                                labelText: "CESS",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  padding: tablet
                      ? EdgeInsets.fromLTRB(hp(3), hp(0), hp(3), hp(3))
                      : EdgeInsets.all(hp(1.5)),
                  //height: hp(65),
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: tablet
                        ? EdgeInsets.symmetric(
                            horizontal: hp(3.2), vertical: hp(2.5))
                        : EdgeInsets.all(tablet ? hp(3.2) : hp(1.5)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(hp(1.2)),
                      color: AppColors.PrimaryWhite,
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
                            blurRadius: 1.0)
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: TextfieldTaxDrowpdown(
                                alwaysBlue: true,
                                paddingBottomInput: hp(2),
                                paddingTopInput: hp(0.8),
                                showArrow: true,
                                fontSize: fontSize,
                                labelText: "VAT",
                                items: [
                                  {"name": "5", "value": "5"},
                                  {"name": "10", "value": "10"},
                                  {"name": "15", "value": "15"},
                                ],
                              ),
                            ),
                          ],
                        ),
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
                    paddingVertical: tablet ? hp(2.1) : hp(1.8),
                    borderRadius: hp(2),
                    fontSize: hp(1.7),
                    title: "ADD PACKAGE",
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
            padding: EdgeInsets.only(top: tablet ? hp(1.5) : hp(1.5)),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: wp(1.7)),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ToggleCard(
                          key: gkey,
                          toggleSize: tablet ? hp(1.8) : hp(1.4),
                          letterSpacing: hp(0.02),
                          fontSize: tablet ? hp(2.6) : wp(3.5),
                          paddingHorizontal: hp(3),
                          paddingVertical: tablet ? hp(1.5) : hp(2),
                          description: "Add GST",
                          initial: widget.bloc.isGSTStream.value,
                          onChanged: (val) {
                            if (val) {
                              vkey.currentState.change(false);
                              widget.bloc.changeIsGST(true);
                              widget.bloc.changeIsVAT(false);
                              setState(() {
                                status = 1;
                              });
                            } else {
                              setState(() {
                                status = -1;
                              });
                              widget.bloc.changeIsGST(false);
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: wp(3),
                      ),
                      Expanded(
                        child: ToggleCard(
                          key: vkey,
                          toggleSize: tablet ? hp(1.8) : hp(1.4),
                          letterSpacing: hp(0.02),
                          fontSize: tablet ? hp(2.6) : wp(3.5),
                          paddingHorizontal: hp(3),
                          paddingVertical: tablet ? hp(1.5) : hp(2),
                          description: "Add VAT",
                          initial: widget.bloc.isVATStream.value,
                          onChanged: (val) {
                            if (val) {
                              gkey.currentState.change(false);
                              widget.bloc.changeIsGST(false);
                              widget.bloc.changeIsVAT(true);
                              setState(() {
                                status = 2;
                              });
                            } else {
                              setState(() {
                                status = -1;
                              });
                              widget.bloc.changeIsVAT(false);
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
                if (tablet)
                  SizedBox(
                    height: hp(1.5),
                  ),
                _buildCard(),
              ],
            )),
        Column(
          children: <Widget>[
            Spacer(
              flex: 1,
            ),
            Container(
                padding: EdgeInsets.fromLTRB(hp(1), 0, hp(1), hp(2)),
                child: ButtonGradient(
                  callback: () {
                    if (widget.bloc.detailsStream.value == '')
                      widget.bloc.createPackage(context);
                    else
                      widget.bloc.updatePackage(
                          context, widget.bloc.detailsStream.value);
                  },
                  paddingVertical: tablet ? hp(2.1) : hp(1.8),
                  borderRadius: hp(2),
                  fontSize: hp(1.7),
                  title: "ADD PRODUCT",
                )),
          ],
        )
      ],
    );
  }
}
