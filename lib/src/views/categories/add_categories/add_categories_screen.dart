import 'dart:convert' as JSON;
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_colorpicker/material_picker.dart';
import 'package:flutter_colorpicker/block_picker.dart';
import 'package:flutter_colorpicker/utils.dart';
import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/data/initial/countries/api_service.dart';
import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:epaisa_pos/data/models/categories_dao.dart';
import 'package:epaisa_pos/data/models/products_dao.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/remove_over_scroll_glow.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/distributors/add_distributors/widgets/item_product.dart';
import 'package:epaisa_pos/src/views/packages/widgets/package_item.dart';
import 'package:epaisa_pos/src/views/point_of_sale/widgets/grid_list_pin.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_dropdown.dart';
import 'package:epaisa_pos/src/widgets/utils/dialogs_helper.dart';
import 'package:epaisa_pos/src/widgets/utils/image_helper.dart';
import 'package:epaisa_pos/src/widgets/utils/request_helper.dart';
import './widgets/arrow_card.dart';
import 'package:epaisa_pos/src/views/categories/add_categories/widgets/item_add.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_camera.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:epaisa_pos/src/widgets/texts/text_blue.dart';
import 'package:epaisa_pos/src/widgets/texts/text_gray.dart';
import 'package:flutter/material.dart';
import 'package:epaisa_pos/src/views/packages/add_packages/widgets/add_product_dialog.dart';
import 'package:rainbow_gradient/rainbow_gradient.dart';

import 'dart:io';

class AddCategoriesScreen extends StatefulWidget {
  AddCategoriesScreen({this.category});
  Categorie category;
  @override
  _AddCategoriesScreenState createState() => _AddCategoriesScreenState();
}

class _AddCategoriesScreenState extends State<AddCategoriesScreen> {
  var status = [
    {'color': Color(0xFFE02020), "value": "#E02020"},
    {'color': Color(0xFFFA6400), "value": "#FA6400"},
    {'color': Color(0xFFF7B500), "value": "#F7B500"},
    {'color': Color(0xFF6DD400), "value": "#6DD400"},
    {'color': Color(0xFF44D7B6), "value": "#44D7B6"},
    {'color': Color(0xFF32C5FF), "value": "#32C5FF"},
  ];

  var status2 = [
    {'color': Color(0xFF0091FF), "value": "#0091FF"},
    {'color': Color(0xFF6236FF), "value": "#6236FF"},
    {'color': Color(0xFFB620E0), "value": "#B620E0"},
    {'color': Color(0xFF000000), "value": "#000000"},
    {'color': Color(0xFFFFFFFF), "value": "#FFFFFF"},
  ];
  var colorMap = {
    "#E02020": {"i": 0, "j": -1},
    "#FA6400": {"i": 1, "j": -1},
    "#F7B500": {"i": 2, "j": -1},
    "#6DD400": {"i": 3, "j": -1},
    "#44D7B6": {"i": 4, "j": -1},
    "#32C5FF": {"i": 5, "j": -1},
    "#0091FF": {"i": -1, "j": 0},
    "#6236FF": {"i": -1, "j": 1},
    "#B620E0": {"i": -1, "j": 2},
    "#000000": {"i": -1, "j": 3},
    "#FFFFFF": {"i": -1, "j": 4},
  };
  Color currentColor = Colors.amber;
  int pivot = 0;
  int pivot2 = -1;
  GlobalKey<TextfieldClassicState> nameKey = GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldDropdownState> parentKey =
      GlobalKey<TextfieldDropdownState>();
  CategoriesDao dao = new CategoriesDao(db);
  ProductsDao pdao = new ProductsDao(db);
  File imagePending = null;
  var hex;
  void changeColor(Color color) {
    setState(() => currentColor = color);

    hex = '#${color.value.toRadixString(16)}';
  }

  var productsChanged = false;
  var listman;
  List<String> tempMarked = new List<String>();
  void addCategory() async {
    print("here");
    await getToken((val) async {
      print(val);
      try {
        var params;
        var color;
        if (pivot != -1) {
          color = status[pivot]["value"];
        } else {
          if (pivot2 == 5)
            color = hex;
          else
            color = status2[pivot2]["value"];
        }

        if (parentKey.currentState.getValue()["value"] == 0) {
          params = {"name": nameKey.currentState.value, "color": color};
        } else {
          params = {
            "name": nameKey.currentState.value,
            "parent": parentKey.currentState.getValue()["id"],
            "color": color
          };
        }

        print("PARAMS$params");
        var categoryResponse = await ApiService.create()
            .createCategories(authKey: val, body: params);
        var category = categoryResponse.body;
        print(category);
        if (productsChanged) {
          categoryResponse = await ApiService.create().addProductsToCategory(
              authKey: val, id: category["id"], body: {"ids": tempMarked});
          category = categoryResponse.body;
        }
        if (imagePending != null) {
          category["image"] = imagePending.toString();
          await UploadImage(
              "upload/categories/${category["id"]}", imagePending);
        }
        dao.add(CategoriesDao.fromMap(category));
        if (parentKey.currentState.getValue()["value"] != 0) {
          var cat = await dao.getOne(parentKey.currentState.getValue()["id"]);
          var temp = cat.toJson();
          List newList =
              temp["children"] != null ? temp["children"].split(",") : [];
          if (newList.indexOf(category["id"]) == -1) {
            newList.add(category["id"]);
          }
          temp["children"] = newList;
          temp["products"] = JSON.jsonDecode(temp["products"]);
          print(temp["products"].runtimeType);
          print("TEMP$temp");
          dao.edit(CategoriesDao.fromMap(temp));
        }

        Navigator.pop(context);
        Navigator.pop(context);
      } catch (e) {
        print(e);
        if (e.body != null) {
          print(e.body);

          Navigator.pop(context);
          showDialogMessage(context, JSON.jsonDecode(e.body)["message"], () {});
        } else {
          Navigator.pop(context);
        }
      }
    });
  }

  List<Categorie> categories = [];

  Future getCategoriesParent() async {
    var cat = await dao.getParents();
    var list = new List<Map<String, dynamic>>();
    list.add({"name": "None", "value": 0});
    for (var i = 0; i < cat.length; i++) {
      if (widget.category != null) {
        if (cat[i].id != widget.category.id) {
          list.add({"name": cat[i].name, "value": cat[i].id, "id": cat[i].id});
        }
      } else {
        list.add({"name": cat[i].name, "value": cat[i].id, "id": cat[i].id});
      }
    }
    return list;
  }

  void editCategorie() async {
    print("here");
    await getToken((val) async {
      print(val);
      try {
        var params = widget.category.toJson();
        var previousParent = params["parent"] != null ? params["parent"] : "";
        var color;
        if (pivot != -1) {
          color = status[pivot]["value"];
        } else {
          if (pivot2 == 5)
            color = hex;
          else
            color = status2[pivot2]["value"];
        }

        if (parentKey.currentState.getValue()["value"] == 0) {
          params["parent"] = null;
        } else {
          if (widget.category.children != null) {
            throw new Exception("This category is a parent");
          } else
            params["parent"] = parentKey.currentState.getValue()["id"];
        }
        params["name"] = nameKey.currentState.value;
        params["color"] = color;
        print(params);
        var categoryResponse = await ApiService.create().updateCategories(
            id: widget.category.id, authKey: val, body: params);

        var category = categoryResponse.body;

        if (productsChanged) {
          categoryResponse = await ApiService.create().addProductsToCategory(
              authKey: val,
              id: widget.category.id,
              body: {"ids": JSON.jsonDecode(widget.category.products)});
          category = categoryResponse.body;
        }
        if (imagePending != null) {
          category["image"] = imagePending.toString();
          await UploadImage(
              "upload/categories/${widget.category.id}", imagePending);
        }
        dao.edit(CategoriesDao.fromMap(category));
        if (parentKey.currentState.getValue()["value"] != 0) {
          var cat = await dao.getOne(parentKey.currentState.getValue()["id"]);
          var temp = cat.toJson();

          List newList =
              temp["children"] != null ? temp["children"].split(",") : [];
          if (newList.indexOf(category["id"]) == -1) {
            newList.add(category["id"]);
          }
          temp["children"] = newList;
          temp["products"] = JSON.jsonDecode(temp["products"]);
          print(temp["products"].runtimeType);
          print("TEMP$temp");
          dao.edit(CategoriesDao.fromMap(temp));
        }
        if (previousParent != "" &&
            previousParent != parentKey.currentState.getValue()["id"]) {
          var previouscat = await dao.getOne(previousParent);
          var previousTemp = previouscat.toJson();
          if (previousTemp["children"] != null) {
            var tempNew = previousTemp["children"].split(",");
            var newTempNew =
                tempNew.where((x) => x.toString() != category["id"]).toList();
            /*if (tempNew.indexOf(category["id"] + ",") != -1) {
              tempNew.replaceAll(category["id"] + ",", "");
            } else if (tempNew.indexOf("," + category["id"]) != -1) {
              tempNew.replaceAll("," + category["id"], "");
            } else {
              tempNew = "";
            }*/
            print("CATEGORIE NEW PARENT$newTempNew");
            previousTemp["children"] = newTempNew; //.split(",");
          }
          previousTemp["products"] = JSON.jsonDecode(previousTemp["products"]);
          dao.edit(CategoriesDao.fromMap(previousTemp));
        }

        Navigator.pop(context);
        Navigator.pop(context);
      } catch (e) {
        print(e);
        try {
          if (e.body != null) {
            print(e.body);

            Navigator.pop(context);
            showDialogMessage(
                context, JSON.jsonDecode(e.body)["message"], () {});
          } else {
            Navigator.pop(context);
          }
        } catch (ex) {
          try {
            var message = e.message;
            Navigator.pop(context);
            showDialogMessage(context, message, () {});
          } catch (exc) {}
        }
      }
    });
  }

  Future getProducts() async {
    print("SI");
    listman = new List<Map<String, dynamic>>();
    var products = await pdao.getAll();

    for (var i = 0; i < products.length; i++) {
      var y = products[i].toJson();

      if (widget.category != null) {
        if (JSON.jsonDecode(widget.category.products).indexOf(y["id"]) != -1) {
          y["text"] = y["name"];
          y["color"] = AppColors.PrimaryBlue;
          y["count"] = 0;
          y["id"] = y["id"];
          listman.add(y);
        }
      } else {
        if (tempMarked.indexOf(y["id"]) != -1) {
          y["text"] = y["name"];
          y["color"] = AppColors.PrimaryBlue;
          y["count"] = 0;
          y["id"] = y["id"];
          listman.add(y);
        }
      }
    }

    listman.add({"text": "Add"});
    print(listman);
    return listman;
  }

  @override
  void initState() {
    if (widget.category != null) {
      print(widget.category.color);
      if (colorMap["#${widget.category.color.substring(3).toUpperCase()}"] !=
          null) {
        pivot = colorMap["#${widget.category.color.substring(3).toUpperCase()}"]
            ["i"];
        pivot2 =
            colorMap["#${widget.category.color.substring(3).toUpperCase()}"]
                ["j"];
      } else {
        pivot = -1;
        pivot2 = 5;

        hex = widget.category.color;
        currentColor = HexColor(widget.category.color);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    var isIOS = Platform.isIOS;
    List pl;
    var productLength;
    if (widget.category != null) {
      print("ARRAY${widget.category.products}");
      var str = widget.category.products != null
          ? widget.category.products[0] == '"'
              ? widget.category.products
                  .substring(1, widget.category.products.length - 1)
                  .replaceAll("\\", "")
              : widget.category.products
          : "[]";
      pl = widget.category.products != null ? JSON.jsonDecode(str) : [];
      productLength = 0;
      if (pl is List) {
        productLength = pl.length;
      } else {
        pl = [];
      }
    }
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
              ? EdgeInsets.only(
                  left: wp(1.3), right: wp(1.3), top: hp(1.8), bottom: hp(1))
              : EdgeInsets.all(tablet ? hp(3.2) : hp(1.5)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(hp(1.2)),
            color: AppColors.PrimaryWhite,
            boxShadow: [
              new BoxShadow(
                  color: AppColors.DarkGray.withOpacity(tablet ? 0.8 : 0.5),
                  offset: new Offset(0.3, 2.0),
                  blurRadius: 2.0),
              new BoxShadow(
                  color: AppColors.DarkGray.withOpacity(tablet ? 0.3 : 0.5),
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
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      child: TextfieldClassic(
                        key: nameKey,
                        fontSize: fontSize,
                        paddingBottomInput: hp(1),
                        initialValue: widget.category != null
                            ? widget.category.name
                            : null,
                        labelText: "Category Name",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: separator,
              ),
              FutureBuilder(
                future: getCategoriesParent(),
                builder: (ctx, snapshot) {
                  if (snapshot.data != null) {
                    return TextfieldDropdown(
                      key: parentKey,
                      items: snapshot.data,
                      paddingBottomInput: hp(1),
                      showBlueDropdownColor: true,
                      alwaysBlue: true,
                      fontSize: fontSize,
                      initValue: widget.category != null
                          ? widget.category.parent != null
                              ? widget.category.parent
                              : ""
                          : "",
                      labelText: "Parent Category",
                    );
                  } else {
                    return TextfieldDropdown(
                      items: [
                        {"name": "Snacks", "value": 0},
                        {"name": "Snacks2", "value": 1},
                      ],
                      paddingBottomInput: hp(1),
                      showBlueDropdownColor: true,
                      alwaysBlue: true,
                      fontSize: fontSize,
                      labelText: "Parent Category",
                    );
                  }
                },
              ),
              SizedBox(
                height: hp(1),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 3),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Category Color',
                        style: TextStyle(
                            fontSize: fontSize * 0.8,
                            fontWeight: FontWeight.w600,
                            color: AppColors.DisabledText),
                      ),
                    ),
                    SizedBox(
                      height: tablet ? hp(0.1) : hp(1),
                    ),
                    Container(
                      height: tablet ? hp(17.5) : hp(13.5),
                      child: Container(
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return Container(
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: hp(0.3),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            if (pivot != index) {
                                              setState(() {
                                                print('pivot');
                                                print(index);
                                                print(pivot);
                                                pivot = index;
                                                pivot2 = -1;
                                              });
                                            }
                                          },
                                          child: Container(
                                            height: tablet ? hp(8) : hp(6),
                                            width: tablet ? wp(5.7) : wp(12.5),
                                            padding: EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      tablet ? 10 : 4),
                                              color: AppColors.PrimaryWhite,
                                              border: Border.all(
                                                color: pivot == index
                                                    ? AppColors.BackPrimaryGray
                                                    : Colors.white,
                                                width: pivot == index ? 1 : 0,
                                              ),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: status[index]['color'],
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        tablet ? 10 : 4),
                                                boxShadow: [
                                                  new BoxShadow(
                                                      color: AppColors.DarkGray
                                                          .withOpacity(0.8),
                                                      offset:
                                                          new Offset(0.6, 1.0),
                                                      blurRadius: 1.0)
                                                ],
                                              ),
                                              child: Container(),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: tablet ? wp(1.7) : wp(2.2),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: hp(0.8),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            index == 5
                                                ? showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        titlePadding:
                                                            const EdgeInsets
                                                                .all(0.0),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .all(0.0),
                                                        content:
                                                            SingleChildScrollView(
                                                          child: ColorPicker(
                                                            pickerColor:
                                                                currentColor,
                                                            onColorChanged:
                                                                changeColor,
                                                            colorPickerWidth:
                                                                300.0,
                                                            pickerAreaHeightPercent:
                                                                0.7,
                                                            enableAlpha: true,
                                                            displayThumbColor:
                                                                true,
                                                            enableLabel: true,
                                                            paletteType:
                                                                PaletteType.hsv,

                                                            /*pickerAreaBorderRadius:
                                                                const BorderRadius
                                                                    .only(
                                                              topLeft: const Radius
                                                                      .circular(
                                                                  2.0),
                                                              topRight: const Radius
                                                                      .circular(
                                                                  2.0),
                                                            ),*/
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : print('');
                                            if (pivot2 != index) {
                                              setState(() {
                                                print('pivot');
                                                print(index);
                                                print(pivot2);
                                                pivot2 = index;
                                                pivot = -1;
                                              });
                                            }
                                          },
                                          child: Container(
                                            height: tablet ? hp(8) : hp(6),
                                            width: tablet ? wp(5.7) : wp(12.5),
                                            padding: EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      tablet ? 10 : 4),
                                              color: AppColors.PrimaryWhite,
                                              border: Border.all(
                                                color: pivot2 == index
                                                    ? AppColors.BackPrimaryGray
                                                    : Colors.white,
                                                width: pivot2 == index ? 1 : 0,
                                              ),
                                            ),
                                            child: currentColor ==
                                                        Colors.amber &&
                                                    index == 5
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                      gradient: RainbowGradient(
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                        colors: <Color>[
                                                          const Color(
                                                              0xFFE02020),
                                                          const Color(
                                                              0xFFFA6400),
                                                          const Color(
                                                              0xFFF7B500),
                                                          const Color(
                                                              0xFF6DD400),
                                                          const Color(
                                                              0xFF00CCFF),
                                                          const Color(
                                                              0xFF0091FF),
                                                          const Color(
                                                              0xFF6236FF),
                                                          const Color(
                                                              0xFFB620E0),
                                                        ],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              tablet ? 10 : 4),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: AppColors
                                                                    .DarkGray
                                                                .withOpacity(
                                                                    0.8),
                                                            offset: Offset(
                                                                0.6, 1.0),
                                                            blurRadius: 1.0)
                                                      ],
                                                    ),
                                                    child: Container(),
                                                  )
                                                : Container(
                                                    decoration: BoxDecoration(
                                                      color: index == 5
                                                          ? currentColor
                                                          : status2[index]
                                                              ['color'],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              tablet ? 10 : 4),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: AppColors
                                                                    .DarkGray
                                                                .withOpacity(
                                                                    0.8),
                                                            offset: Offset(
                                                                0.6, 1.0),
                                                            blurRadius: 1.0)
                                                      ],
                                                    ),
                                                    child: Container(),
                                                  ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: tablet ? wp(1.7) : wp(2.2),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget _buildAddModule() {
      return Container(
        padding: EdgeInsets.only(
            right: tablet ? wp(1) : 0, bottom: tablet ? hp(9) : 0),
        child: Column(
          children: <Widget>[
            tablet
                ? FutureBuilder(
                    future: getProducts(),
                    builder: (ctx, snapshot) {
                      if (snapshot.data != null) {
                        return GridListPin(
                          children: snapshot.data,
                          contextWidth: wp(48.2),
                          gridLength: 3,
                          height: hp(22),
                          totalWidth: wp(45),
                          verticalMargin: hp(1),
                          noLetters: true,
                          itemBuilder: ({text, color, index, onTap}) {
                            if (index == snapshot.data.length - 1) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                      new PageRouteBuilder(
                                          opaque: false,
                                          pageBuilder:
                                              (BuildContext context, _, __) {
                                            return AddProductDialog(
                                              storeAction: (data) {
                                                print("xx");
                                                if (widget.category != null) {
                                                  var newd =
                                                      widget.category.toJson();
                                                  newd["products"] = data;
                                                  setState(() {
                                                    productsChanged = true;
                                                    widget.category =
                                                        CategoriesDao.fromMap(
                                                            newd);
                                                  });
                                                } else {
                                                  setState(() {
                                                    productsChanged = true;
                                                    tempMarked = data;
                                                  });
                                                }
                                              },
                                              marked: widget.category != null
                                                  ? pl != null
                                                      ? pl
                                                          .map((x) =>
                                                              x.toString())
                                                          .toList()
                                                      : []
                                                  : tempMarked,
                                            );
                                          }));
                                },
                                child: ItemAdd(
                                  tablet: tablet,
                                  scale: isIOS ? 13 : 15,
                                ),
                              );
                            } else {
                              return ItemProduct(
                                tablet: tablet,
                                scale: wp(1.3),
                                text: snapshot.data[index]["text"],
                              );
                            }
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  )
                : TextBlue(
                    title: "ADD PRODUCTS TO CATEGORY",
                    fontSize: hp(2),
                    fontWeight: FontWeight.w700,
                  ),
            tablet
                ? Container()
                : SizedBox(
                    height: hp(0.5),
                  ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(new PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (BuildContext context, _, __) {
                      return AddProductDialog(
                        storeAction: (data) {
                          print("xx");
                          if (widget.category != null) {
                            var newd = widget.category.toJson();
                            newd["products"] = data;
                            setState(() {
                              productsChanged = true;
                              widget.category = CategoriesDao.fromMap(newd);
                            });
                          } else {
                            setState(() {
                              productsChanged = true;
                              tempMarked = data;
                              //  data.map((x) => x.toString()).toList();
                            });
                          }
                          /*dao.edit(DistributorsDao.fromMap(data));

                            widget.distributor = DistributorsDao.fromMap(data);
                          */
                        },
                        marked: widget.category != null
                            ? pl != null
                                ? pl.map((x) => x.toString()).toList()
                                : []
                            : tempMarked,
                      );
                    }));
              },
              child: tablet
                  ? Container()
                  : Container(
                      padding: EdgeInsets.symmetric(
                          vertical: hp(0.5), horizontal: hp(1)),
                      child: ArrowCard(
                        letterSpacing: hp(0.02),
                        fontSize: hp(2),
                        paddingHorizontal: hp(3),
                        paddingVertical: hp(2),
                        description:
                            "Applicable to ${widget.category != null ? productLength != null ? productLength : 0 : tempMarked.length} Products",
                      ),
                    ),
            ),
          ],
        ),
      );
    }

    return EpaisaScaffold(
        appBar: EpaisaAppBar(
          back: true,
          title: '${widget.category != null ? "EDIT" : "ADD"} CATEGORY',
        ),
        body: Column(
          children: <Widget>[
            tablet
                ? SizedBox(
                    height: hp(2),
                  )
                : SizedBox(
                    height: 0,
                  ),
            Expanded(
                child: Stack(
              alignment: Alignment.topCenter,
              fit: StackFit.expand,
              children: <Widget>[
                tablet
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                              child: SingleChildScrollView(
                                  child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[_buildCard()]))),
                          Expanded(
                              child: Stack(
                                  alignment: Alignment.topCenter,
                                  fit: StackFit.expand,
                                  children: <Widget>[
                                _buildAddModule(),
                                Column(
                                  children: <Widget>[
                                    Spacer(
                                      flex: 1,
                                    ),
                                    Container(
                                        padding: EdgeInsets.fromLTRB(
                                            hp(1), 0, hp(1), hp(2)),
                                        child: ButtonGradient(
                                          callback: () async {
                                            showLoading(context);
                                            if (widget.category != null) {
                                              await editCategorie();
                                            } else {
                                              await addCategory();
                                            }
                                            print("out");
                                          },
                                          paddingVertical:
                                              tablet ? hp(2.1) : hp(1.8),
                                          borderRadius: hp(2),
                                          fontSize: hp(1.7),
                                          title:
                                              "${widget.category != null ? "UPDATE" : "ADD"} CATEGORY",
                                        )),
                                  ],
                                )
                              ]))
                        ],
                      )
                    : SingleChildScrollView(
                        padding: EdgeInsets.only(top: tablet ? hp(1.5) : 0),
                        child: Column(
                          children: <Widget>[
                            _buildCard(), _buildAddModule()
                            // _buildAddModule()
                          ],
                        )),
                !tablet
                    ? Column(
                        children: <Widget>[
                          Spacer(
                            flex: 1,
                          ),
                          Container(
                              padding:
                                  EdgeInsets.fromLTRB(hp(1), 0, hp(1), hp(2)),
                              child: ButtonGradient(
                                callback: () async {
                                  showLoading(context);
                                  if (widget.category != null) {
                                    await editCategorie();
                                  } else {
                                    await addCategory();
                                  }
                                  print("out");
                                },
                                paddingVertical: tablet ? hp(2.1) : hp(1.8),
                                borderRadius: hp(2),
                                fontSize: hp(1.7),
                                title:
                                    "${widget.category != null ? "UPDATE" : "ADD"} CATEGORY",
                              )),
                        ],
                      )
                    : SizedBox(
                        height: 0,
                        width: 0,
                      ),
              ],
            )),
          ],
        ) //ListView(children: <Widget>[],)
        );
  }
}
