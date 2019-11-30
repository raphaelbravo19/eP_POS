import 'dart:io';

import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:epaisa_pos/data/models/categories_dao.dart';
import 'package:epaisa_pos/data/models/distributors_dao.dart';
import 'package:epaisa_pos/data/models/manufacturers_dao.dart';
import 'package:epaisa_pos/data/models/units_dao.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/products/add_products/bloc/add_product_bloc.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_camera.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/textfields/texfield_box.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_dropdown.dart';
import 'package:flutter/material.dart';

class AddProductInfoScreen extends StatefulWidget {
  final bool portraitMode;
  final AddProductBloc bloc;
  final Function changeTab;
  AddProductInfoScreen({this.portraitMode = false, this.bloc, this.changeTab});

  @override
  _AddProductInfoScreenState createState() => _AddProductInfoScreenState();
}

class _AddProductInfoScreenState extends State<AddProductInfoScreen> {
  UnitsDao unitsDao = UnitsDao(db);
  ManufacturersDao manufacturersDao = ManufacturersDao(db);
  CategoriesDao categoriesDao = CategoriesDao(db);
  DistributorsDao distributorsDao = DistributorsDao(db);
  Future getUnits() async {
    var list = await unitsDao.getAll();
    return list.map((item) => {"name": item.name, "value": item.id}).toList();
  }

  Future getManu() async {
    var list = await manufacturersDao.getAll();
    return list.map((item) => {"name": item.name, "value": item.id}).toList();
  }

  Future getCate() async {
    var list = await categoriesDao.getSingles();
    return list.map((item) => {"name": item.name, "value": item.id}).toList();
  }

  Future getDist() async {
    var list = await distributorsDao.getAll();
    return list.map((item) => {"name": item.name, "value": item.id}).toList();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    var isIOS = Platform.isIOS;

    Widget _buildCard() {
      double fontSize = tablet ? hp(2.8) : hp(2.20);
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  ButtonCamera(
                    size: tablet ? hp(16) : wp(25),
                    onSuccess: (image) {
                      widget.bloc.changeImage(image);
                      widget.bloc.changeImageChanged(true);
                    },
                    uriImage: widget.bloc.streamImage.value != null
                        ? widget.bloc.streamImage.value.toString()
                        : widget.bloc.streamImageUrl.value != null
                            ? widget.bloc.streamImageUrl.value
                            : "",
                  ),
                  SizedBox(
                    width: tablet ? hp(2) : wp(3),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      child: TextfieldClassic(
                        initialValue: widget.bloc.streamName.value,
                        fontSize: fontSize,
                        paddingBottomInput: hp(1),
                        labelText: "Product Name",
                        alwaysFocus: true,
                        alwaysBlue: true,
                        stream: widget.bloc.name,
                        onChanged: (str) {
                          widget.bloc.changeName(str);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: hp(1.1),
              ),
              TextfieldBox(
                paddingBottomInput: hp(1),
                fontSize: fontSize,
                initialValue: widget.bloc.streamDescription.value,
                stream: widget.bloc.description,
                onChanged: (str) {
                  widget.bloc.changeDescription(str);
                },
                labelText: "Product Description",
              ),
              SizedBox(
                height: separator,
              ),
              FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (widget.bloc.streamManufacturers.value == null &&
                          snapshot.data.length > 0) {
                        widget.bloc
                            .changeManufacturer(snapshot.data[0]["value"]);
                      }
                      var val = widget.bloc.streamManufacturers.value;
                      return TextfieldDropdown(
                        items: snapshot.data,
                        paddingBottomInput: hp(1),
                        fontSize: fontSize,
                        showBlueDropdownColor: true,
                        alwaysBlue: true,
                        labelText: "Manufacturer",
                        initValue: val,
                        onChanged: (val) {
                          print(val);
                          widget.bloc.changeManufacturer(val);
                        },
                      );
                    } else {
                      return TextfieldClassic(
                        paddingBottomInput: hp(1),
                        fontSize: fontSize,
                        alwaysBlue: true,
                        labelText: "Manufacturer",
                        onChanged: (val) {
                          print(val);
                          widget.bloc.changeUnit(val);
                        },
                      );
                    }
                  },
                  future: getManu()),
              SizedBox(
                height: separator,
              ),
              FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      //if (widget.bloc.streamDistributors.value == null) {
                      //widget.bloc.changeDistributors([0]);
                      //}

                      return TextfieldDropdown(
                        items: snapshot.data,
                        paddingBottomInput: hp(1),
                        fontSize: fontSize,
                        showBlueDropdownColor: true,
                        alwaysBlue: true,
                        initialMulti: widget.bloc.streamCategories.value,
                        labelText: "Category",
                        multiselection: true,
                        onChanged: (list) {
                          print("CAMBIO$list");
                          widget.bloc.changeCategories(list);
                        },
                      );
                    } else {
                      return TextfieldClassic(
                        paddingBottomInput: hp(1),
                        fontSize: fontSize,
                        alwaysBlue: true,
                        labelText: "Category",
                      );
                    }
                  },
                  future: getCate()),
              SizedBox(
                height: separator,
              ),
              TextfieldClassic(
                paddingBottomInput: hp(1),
                fontSize: fontSize,
                labelText: "HSN Code",
                alwaysFocus: true,
                alwaysBlue: true,
                stream: widget.bloc.hsn,
                initialValue: widget.bloc.streamHsn.value,
                onChanged: (str) {
                  widget.bloc.changeHSN(str);
                },
              ),
              SizedBox(
                height: separator,
              ),
              FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (widget.bloc.streamUnit.value == null) {
                        widget.bloc.changeUnit(snapshot.data[0]["value"]);
                      }

                      var val = widget.bloc.streamUnit.value;
                      return TextfieldDropdown(
                        items: snapshot.data,
                        paddingBottomInput: hp(1),
                        fontSize: fontSize,
                        showBlueDropdownColor: true,
                        alwaysBlue: true,
                        labelText: "Unit",
                        initValue: val,
                        onChanged: (val) {
                          print(val);
                          widget.bloc.changeUnit(val);
                        },
                      );
                    } else {
                      return TextfieldClassic(
                        paddingBottomInput: hp(1),
                        fontSize: fontSize,
                        alwaysBlue: true,
                        labelText: "Unit",
                        onChanged: (val) {
                          print(val);
                          widget.bloc.changeUnit(val);
                        },
                      );
                    }
                  },
                  future: getUnits()),
              SizedBox(
                height: separator,
              ),
              FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      //if (widget.bloc.streamDistributors.value == null) {
                      //widget.bloc.changeDistributors([0]);
                      //}

                      return StreamBuilder(
                          stream: widget.bloc.distributor,
                          builder: (context, snap) {
                            return TextfieldDropdown(
                              items: snapshot.data,
                              paddingBottomInput: hp(1),
                              fontSize: fontSize,
                              showBlueDropdownColor: true,
                              alwaysBlue: true,
                              initialMulti: snap.data,
                              labelText: "Distributors",
                              multiselection: true,
                              onChanged: (list) {
                                print("CAMBIO$list");
                                widget.bloc.changeDistributors(list);
                              },
                            );
                          });
                    } else {
                      return TextfieldClassic(
                        paddingBottomInput: hp(1),
                        fontSize: fontSize,
                        alwaysBlue: true,
                        labelText: "Distributors",
                      );
                    }
                  },
                  future: getDist()),
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
                        widget.changeTab(1);
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
          padding: EdgeInsets.only(
              top: tablet ? hp(1.5) : 0, bottom: tablet ? hp(0) : hp(0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildCard(),

              // _buildAddModule()
            ],
          ),
        ),
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
                        widget.changeTab(1);
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
    );
  }
}
