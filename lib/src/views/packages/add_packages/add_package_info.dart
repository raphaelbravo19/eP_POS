import 'dart:io';

import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:epaisa_pos/data/models/categories_dao.dart';
import 'package:epaisa_pos/data/models/products_dao.dart';
import 'package:epaisa_pos/data/models/units_dao.dart';
import 'package:epaisa_pos/data/models/variants_dao.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/remove_over_scroll_glow.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/packages/add_packages/add_package_screen.dart';
import 'package:epaisa_pos/src/views/categories/add_categories/widgets/item_add.dart';
import 'package:epaisa_pos/src/views/packages/add_packages/widgets/add_product_dialog.dart';
import 'package:epaisa_pos/src/views/packages/add_packages/widgets/item_product.dart';
import 'package:epaisa_pos/src/views/point_of_sale/widgets/grid_list_pin.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_camera.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/textfields/texfield_box.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class AddPackageInfoScreen extends StatefulWidget {
  final bool portraitMode;
  final Function callback;
  AddPackageBloc bloc;
  AddPackageInfoScreen({this.portraitMode = false, this.bloc, this.callback});

  @override
  _AddPackageInfoScreenState createState() => _AddPackageInfoScreenState();
}

class _AddPackageInfoScreenState extends State<AddPackageInfoScreen> {
  Future getUnits() async {
    UnitsDao unitsDao = new UnitsDao(db);
    var list = await unitsDao.getAll();
    return list.map((item) => {"name": item.name, "value": item.id}).toList();
  }

  Future getCate() async {
    CategoriesDao categoriesDao = new CategoriesDao(db);
    var list = await categoriesDao.getParents();
    return list.map((item) => {"name": item.name, "value": item.id}).toList();
  }

  Future getChild(val) async {
    CategoriesDao categoriesDao = new CategoriesDao(db);
    var list = await categoriesDao.getChildren(val);
    return list.map((item) => {"name": item.name, "value": item.id}).toList();
  }

  @override
  void didUpdateWidget(AddPackageInfoScreen oldWidget) {
    if (widget.bloc != oldWidget.bloc) {
      widget.bloc = widget.bloc;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    var isIOS = Platform.isIOS;

    Widget _buildCard() {
      double fontSize = tablet ? hp(2.8) : hp(2.05);
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
                    onSuccess: (f) {
                      widget.bloc.changeImage(f);
                    },
                  ),
                  SizedBox(
                    width: tablet ? hp(2) : wp(3),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      child: TextfieldClassic(
                        stream: widget.bloc.name,
                        alwaysFocus: true,
                        alwaysBlue: true,
                        fontSize: fontSize,
                        paddingBottomInput: hp(1),
                        labelText: "Package Name",
                        onChanged: widget.bloc.changeName,
                        initialValue: widget.bloc.nameStream.value,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: separator,
              ),
              TextfieldBox(
                stream: widget.bloc.description,
                paddingBottomInput: hp(1),
                fontSize: fontSize,
                labelText: "Package Description",
                onChanged: widget.bloc.changeDescription,
                initialValue: widget.bloc.descriptionStream.value,
              ),
              SizedBox(
                height: separator,
              ),
              FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      if (widget.bloc.categoryStream.value == null &&
                          snapshot.data.length > 0) {
                        widget.bloc.changeCategory(snapshot.data[0]["value"]);
                      }
                      return TextfieldDropdown(
                        items: snapshot.data,
                        paddingBottomInput: hp(1),
                        fontSize: fontSize,
                        scaleDropdown: 1.7,
                        labelText: "Category",
                        initValue: widget.bloc.categoryStream.value,
                        itemBuilder: ({option, index, height, selected}) {
                          return Container(
                            height: height,
                            padding: EdgeInsets.symmetric(
                                horizontal: tablet ? hp(2.5) : wp(2.5)),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  option.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: tablet ? hp(2) : hp(1.43),
                                      letterSpacing: 2,
                                      color: AppColors.TextGray,
                                      fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      right: tablet ? hp(1) : wp(3)),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: tablet ? hp(3) : hp(2),
                                    color:
                                        AppColors.IconDarkGray.withOpacity(0.7),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        onChanged: (val) {
                          print(val);
                          widget.bloc.changeCategory(val);
                          widget.bloc.changeSubCategory("");
                        },
                      );
                    } else {
                      return TextfieldClassic(
                        paddingBottomInput: hp(1),
                        fontSize: fontSize,
                        labelText: "Category",
                        onChanged: (val) {
                          //print(val);
                          //widget.bloc.changeUnit(val);
                        },
                      );
                    }
                  },
                  future: getCate()),
              SizedBox(
                height: separator,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: hp(6),
                  ),
                  Expanded(
                    child: StreamBuilder(
                        stream: widget.bloc.categoryStream,
                        builder: (context, snap) {
                          if (snap.data != null) {
                            return FutureBuilder(
                                builder: (context, snapshot) {
                                  if (snapshot.data != null) {
                                    if (snapshot.data.length > 0) {
                                      if (widget.bloc.subcategoryStream.value ==
                                          null) {
                                        widget.bloc.changeSubCategory(
                                            snapshot.data[0]["value"]);
                                      }
                                      if (widget.bloc.subcategoryStream.value !=
                                          null) {
                                        return TextfieldDropdown(
                                          items: snapshot.data,
                                          paddingBottomInput: hp(1),
                                          fontSize: fontSize,
                                          scaleDropdown: 1.7,
                                          labelText: "Sub - Category",
                                          initValue: widget
                                              .bloc.subcategoryStream.value,
                                          itemBuilder: (
                                              {option,
                                              index,
                                              height,
                                              selected}) {
                                            return Container(
                                              height: height,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: tablet
                                                      ? hp(2.5)
                                                      : wp(2.5)),
                                              alignment: Alignment.center,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    option.toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: tablet
                                                            ? hp(2)
                                                            : hp(1.43),
                                                        letterSpacing: 2,
                                                        color:
                                                            AppColors.TextGray,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: tablet
                                                            ? hp(1)
                                                            : wp(3)),
                                                    child: Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: tablet
                                                          ? hp(3)
                                                          : hp(2),
                                                      color:
                                                          AppColors.IconDarkGray
                                                              .withOpacity(0.7),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                          onChanged: (val) {
                                            //print(val);
                                            widget.bloc.changeSubCategory(val);
                                          },
                                        );
                                      } else {
                                        return TextfieldClassic(
                                          paddingBottomInput: hp(1),
                                          fontSize: fontSize,
                                          labelText: "Sub - Category",
                                          onChanged: (val) {
                                            //print(val);
                                            //widget.bloc.changeUnit(val);
                                          },
                                        );
                                      }
                                    } else {
                                      return Container();
                                    }
                                  } else {
                                    return TextfieldClassic(
                                      paddingBottomInput: hp(1),
                                      fontSize: fontSize,
                                      labelText: "Sub - Category",
                                      onChanged: (val) {
                                        //print(val);
                                        //widget.bloc.changeUnit(val);
                                      },
                                    );
                                  }
                                },
                                future: getChild(snap.data));
                          } else {
                            return Container();
                          }
                        }), /*TextfieldDropdown(
                      items: [
                        {"name": "Ketchup1", "value": 0},
                        {"name": "Ketchup2", "value": 1},
                        {"name": "Ketchup3", "value": 2},
                      ],
                      scaleDropdown: 2,
                      paddingBottomInput: hp(1),
                      fontSize: fontSize,
                      labelText: "Sub - Category",
                      itemBuilder: ({option, index, height, selected}) {
                        return Container(
                          height: height,
                          padding: EdgeInsets.symmetric(
                              horizontal: tablet ? hp(2.5) : wp(2.5)),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                option.toUpperCase(),
                                style: TextStyle(
                                    fontSize: tablet ? hp(2) : hp(1.43),
                                    letterSpacing: 2,
                                    color: AppColors.TextGray,
                                    fontWeight: FontWeight.w600),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: tablet ? hp(1) : wp(3)),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: tablet ? hp(3) : hp(2),
                                  color:
                                      AppColors.IconDarkGray.withOpacity(0.7),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),*/
                  ),
                ],
              ),
              SizedBox(
                height: separator,
              ),
              FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      if (widget.bloc.unitStream.value == null) {
                        widget.bloc.changeUnit(snapshot.data[0]["value"]);
                      }
                      return TextfieldDropdown(
                        items: snapshot.data,
                        paddingBottomInput: hp(1),
                        fontSize: fontSize,
                        scaleDropdown: 1.5,
                        initValue: widget.bloc.unitStream.value,
                        labelText: "Unit",
                        onChanged: (val) {
                          //print(val);
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
                          //print(val);
                          //widget.bloc.changeUnit(val);
                        },
                      );
                    }
                  },
                  future: getUnits()),
              SizedBox(
                height: separator,
              ),
            ],
          ),
        ),
      );
    }

    Widget _buildAddProduct() {
      return AddProducttoPackage(
        productList: widget.bloc.products,
        changeProduct: (val) {
          widget.bloc.changeProducts(val);
        },
      );
    }

    return Column(children: <Widget>[
      Expanded(
        child: Container(
          padding: tablet ? EdgeInsets.only(top: hp(1)) : EdgeInsets.all(0),
          child: tablet
              ? SingleChildScrollView(
                  child: Column(
                  children: <Widget>[
                    _buildCard(),
                    Container(
                      height: hp(8),
                      width: wp(98),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(hp(1), 0, 0, hp(2)),
                        child: ButtonGradient(
                          callback: () {
                            widget.callback(1);
                          },
                          paddingVertical: tablet ? hp(2.1) : hp(1.8),
                          borderRadius: hp(2),
                          fontSize: hp(1.7),
                          title: "NEXT",
                        ),
                      ),
                    )
                  ],
                ))
              // _buildAddModule()

              : Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          _buildAddProduct(),
                          _buildCard(),
                        ],
                      ),
                    ),
                    Positioned(
                      height: hp(8),
                      width: wp(98),
                      top: isIOS ? hp(71.5) : hp(76),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(hp(1), 0, 0, hp(2)),
                        child: ButtonGradient(
                          callback: () {
                            widget.callback(1);
                          },
                          paddingVertical: tablet ? hp(2.1) : hp(1.8),
                          borderRadius: hp(2),
                          fontSize: hp(1.7),
                          title: "NEXT",
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    ]) //ListView(children: <Widget>[],)
        ;
  }
}

class AddProducttoPackage extends StatefulWidget {
  AddProducttoPackage({Key key, this.productList, this.changeProduct})
      : super(key: key);
  BehaviorSubject<List<Map<String, dynamic>>> productList;
  final Function changeProduct;
  @override
  _AddProducttoPackageState createState() => _AddProducttoPackageState();
}

class _AddProducttoPackageState extends State<AddProducttoPackage> {
  Future<List<Map<String, dynamic>>> getVariants(val) async {
    VariantsDao dao = new VariantsDao(db);
    var variants = new List<Map<String, dynamic>>();
    for (var i = 0; i < val.length; i++) {
      var temp = await dao.getOne(val[i]["variantId"]);
      variants.add({"text": temp.name, "color": AppColors.PrimaryBlue});
    }
    return variants;
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    var isIOS = Platform.isIOS;

    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: hp(1)),
          if (!tablet)
            Text(
              "ADD PRODUCTS TO PACKAGE",
              style: TextStyle(
                  fontSize: hp(2),
                  color: AppColors.PrimaryBlue,
                  fontWeight: FontWeight.w700),
            ),
          SizedBox(height: hp(1)),
          tablet
              ? StreamBuilder<List<Map<String, dynamic>>>(
                  stream: widget.productList,
                  builder: (context, snap) {
                    if (snap.data != null) {
                      return FutureBuilder<List<Map<String, dynamic>>>(
                          future: getVariants(snap.data),
                          builder: (context, snapshot) {
                            if (snapshot.data != null) {
                              return GridListPin(
                                children: snapshot.data,
                                gridLength: 3,
                                height: hp(20),
                                totalWidth: wp(45),
                                verticalMargin: hp(1),
                                noLetters: true,
                                itemBuilder: ({text, color, index, onTap}) {
                                  if (index == 4) {
                                    return ItemAdd(
                                      tablet: tablet,
                                      scale: isIOS ? 13 : 15,
                                    );
                                  } else {
                                    return ItemProduct(
                                      tablet: tablet,
                                      scale: 15.5,
                                      text: snapshot.data[index]["text"],
                                      more: (val) {
                                        var tempList = snap.data;
                                        tempList[index]["quantity"] = val;
                                        widget.changeProduct(tempList);
                                      },
                                      less: (val) {
                                        var tempList = snap.data;
                                        tempList[index]["quantity"] = val;
                                        widget.changeProduct(tempList);
                                      },
                                      quantity: snap.data[index]["quantity"],
                                    );
                                  }
                                },
                              );
                            } else
                              return Container();
                          });
                    } else
                      return Container();
                  })
              : Container(
                  height: hp(17),
                  padding: EdgeInsets.symmetric(
                    horizontal: wp(1),
                  ),
                  width: wp(98.4),
                  alignment: Alignment.center,
                  child: ScrollConfiguration(
                    behavior: RemoveOverScrollGlow(),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: wp(1)),
                      scrollDirection: Axis.horizontal,
                      child: StreamBuilder<List<Map<String, dynamic>>>(
                          stream: widget.productList,
                          builder: (context, snap) {
                            return FutureBuilder<List<Map<String, dynamic>>>(
                                future: getVariants(snap.data),
                                builder: (context, snapshot) {
                                  if (snapshot.data != null) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ...List.generate(snapshot.data.length,
                                            (index) {
                                          return Container(
                                            width: wp(30),
                                            margin: EdgeInsets.only(
                                                left: index == 0
                                                    ? wp(0.2)
                                                    : wp(2),
                                                bottom: hp(0.3)),
                                            child: ItemProduct(
                                              text: snapshot.data[index]
                                                  ["text"],
                                              tablet: tablet,
                                              scale: 11.5,
                                              more: (val) {
                                                var tempList = snap.data;
                                                tempList[index]["quantity"] =
                                                    val;
                                                widget.changeProduct(tempList);
                                              },
                                              less: (val) {
                                                var tempList = snap.data;
                                                tempList[index]["quantity"] =
                                                    val;
                                                widget.changeProduct(tempList);
                                              },
                                              quantity: snap.data[index]
                                                  ["quantity"],
                                            ),
                                          );
                                        }).toList(),
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  new PageRouteBuilder(
                                                      opaque: false,
                                                      pageBuilder:
                                                          (BuildContext context,
                                                              _, __) {
                                                        return AddProductComplexDialog(
                                                            storeAction:
                                                                (data) {
                                                              widget
                                                                  .changeProduct(
                                                                      data);
                                                            },
                                                            marked: snap.data);
                                                      }));
                                            },
                                            child: Container(
                                              width: wp(30),
                                              margin: EdgeInsets.only(
                                                  left: wp(2),
                                                  right: wp(0.2),
                                                  bottom: hp(0.3)),
                                              child: ItemAdd(
                                                tablet: tablet,
                                                scale: 9,
                                              ),
                                            )),
                                        if (snap.data.length < 2)
                                          ...List.generate(2 - snap.data.length,
                                              (index) {
                                            return Container(
                                                width: wp(30),
                                                margin: EdgeInsets.only(
                                                    left: wp(2),
                                                    right: wp(0.2),
                                                    bottom: hp(0.3)));
                                          })
                                      ],
                                    );
                                  } else {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              width: wp(30),
                                              margin: EdgeInsets.only(
                                                  left: wp(2),
                                                  right: wp(0.2),
                                                  bottom: hp(0.3)),
                                              child: ItemAdd(
                                                tablet: tablet,
                                                scale: 9,
                                              ),
                                            )),
                                        ...List.generate(2, (index) {
                                          return Container(
                                              width: wp(30),
                                              margin: EdgeInsets.only(
                                                  left: wp(2),
                                                  right: wp(0.2),
                                                  bottom: hp(0.3)));
                                        })
                                      ],
                                    );
                                  }
                                });
                          }),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
