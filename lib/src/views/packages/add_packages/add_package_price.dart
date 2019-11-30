import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/add_custom_barcode/add_custom_barcode_screen.dart';
import 'package:epaisa_pos/src/views/add_variations/add_variations_screen.dart';
import 'package:epaisa_pos/src/views/packages/add_packages/add_package_screen.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_border.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/dialogs/screen_as_modal.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:flutter/material.dart';

class AddPackagePriceScreen extends StatefulWidget {
  final Function callback;
  AddPackageBloc bloc;
  AddPackagePriceScreen({this.bloc, this.callback});
  @override
  _AddPackagePriceScreenState createState() => _AddPackagePriceScreenState();
}

class _AddPackagePriceScreenState extends State<AddPackagePriceScreen> {
  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));

    Widget _buildCard() {
      double fontSize = tablet ? hp(2.8) : hp(2);
      double separator = tablet ? hp(0.5) : hp(1);

      return Container(
        padding: tablet
            ? EdgeInsets.fromLTRB(hp(3), hp(0), hp(3), hp(3))
            : EdgeInsets.all(hp(1.5)),
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
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: TextfieldClassic(
                      stream: widget.bloc.sku,
                      paddingBottomInput: hp(1),
                      fontSize: fontSize,
                      alwaysFocus: true,
                      alwaysBlue: true,
                      labelText: "SKU",
                      initialValue: widget.bloc.skuStream.value,
                      onChanged: (val) {
                        //print(val);
                        widget.bloc.changeSKU(val);
                      },
                      noClear: true,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextfieldClassic(
                      stream: widget.bloc.priceStream,
                      initialValue: widget.bloc.priceStream.value,
                      leftBorder: true,
                      paddingBottomInput: hp(1),
                      fontSize: fontSize,
                      noClear: true,
                      alwaysFocus: true,
                      alwaysBlue: true,
                      prefixIcon: '₹',
                      labelText: "Price (₹)",
                      onChanged: widget.bloc.changePrice,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: separator,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: TextfieldClassic(
                      stream: widget.bloc.inventoryStream,
                      initialValue: widget.bloc.inventoryStream.value,
                      paddingBottomInput: hp(1),
                      fontSize: fontSize,
                      alwaysFocus: true,
                      alwaysBlue: true,
                      noClear: true,
                      labelText: "Inventory",
                      onChanged: widget.bloc.changeInventory,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextfieldClassic(
                      stream: widget.bloc.thresholdStream,
                      initialValue: widget.bloc.thresholdStream.value,
                      leftBorder: true,
                      paddingBottomInput: hp(1),
                      fontSize: fontSize,
                      alwaysFocus: true,
                      alwaysBlue: true,
                      noClear: true,
                      labelText: "Threshold",
                      onChanged: widget.bloc.changeThreshold,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: separator,
              ),
              TextfieldClassic(
                  stream: widget.bloc.barcodeStream,
                  initialValue: widget.bloc.barcodeStream.value,
                  paddingBottomInput: hp(1),
                  fontSize: fontSize,
                  labelText: "Barcode",
                  alwaysFocus: true,
                  alwaysBlue: true,
                  noClear: true,
                  onChanged: widget.bloc.changeBarcode,
                  customIcon: Image.asset(
                    "assets/productsscreen/qrscanner.png",
                    height: fontSize * 1.5,
                  )),
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
                    title: "NEXT",
                  )),
            ],
          ),
        ),
      );
    }

    return Column(
      children: <Widget>[
        Expanded(
            child: Container(
                //padding: tablet ? EdgeInsets.only(top: hp(1)) : EdgeInsets.all(0),
                child: tablet
                    ? ListView(
                        children: <Widget>[
                          SizedBox(
                            height: hp(0.7),
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: wp(tablet ? 2 : 3)),
                              child: ButtonGradient(
                                callback: () {
                                  Navigator.of(context)
                                      .push(new PageRouteBuilder(
                                    opaque: false,
                                    pageBuilder: (BuildContext context, _, __) {
                                      return ScreenAsModal(
                                        height: hp(85),
                                        width: hp(70),
                                        body: AddCustomBarcodeScreen(),
                                      );
                                    },
                                  ));
                                },
                                filled: true,
                                paddingVertical: tablet ? hp(2.1) : hp(1.8),
                                borderRadius: hp(2),
                                fontSize: hp(1.7),
                                title: "CUSTOM BARCODES",
                              )),
                          SizedBox(
                            height: hp(2.7),
                          ),
                          _buildCard(),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: wp(tablet ? 2 : 3)),
                              child: ButtonBorder(
                                //filled: true,
                                callback: () {
                                  Navigator.of(context)
                                      .push(new PageRouteBuilder(
                                    opaque: false,
                                    pageBuilder: (BuildContext context, _, __) {
                                      return ScreenAsModal(
                                        width: hp(70),
                                        body: AddVariationsScreen(),
                                      );
                                    },
                                  ));
                                },
                                paddingVertical: tablet ? hp(2.1) : hp(1.8),
                                borderRadius: hp(2),
                                fontSize: hp(1.7),
                                title: "+ ADD VARIATIONS",
                              ))
                        ],
                      )
                    : Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              SizedBox(
                                height: hp(0.7),
                              ),
                              Container(
                                padding:
                                    EdgeInsets.symmetric(horizontal: wp(3)),
                                child: ButtonGradient(
                                  callback: () {
                                    Navigator.of(context)
                                        .push(new PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder:
                                          (BuildContext context, _, __) {
                                        return ScreenAsModal(
                                          height: hp(92),
                                          width: wp(90),
                                          body: AddCustomBarcodeScreen(),
                                        );
                                      },
                                    ));
                                  },
                                  filled: true,
                                  paddingVertical: tablet ? hp(2.1) : hp(1.8),
                                  borderRadius: hp(2),
                                  fontSize: hp(1.7),
                                  title: "CUSTOM BARCODES",
                                ),
                              ),
                              _buildCard(),
                            ],
                          ),
                          Positioned(
                            height: hp(8),
                            width: wp(98),
                            top: isIOS ? hp(71.5) : hp(76),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(hp(1), 0, 0, hp(2)),
                              child: ButtonGradient(
                                callback: () {
                                  widget.callback(2);
                                },
                                paddingVertical: tablet ? hp(2.1) : hp(1.8),
                                borderRadius: hp(2),
                                fontSize: hp(1.7),
                                title: "NEXT",
                              ),
                            ),
                          )
                        ],
                      ))),
      ],
      //ListView(children: <Widget>[],)
    );
  }
}
