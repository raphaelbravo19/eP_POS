import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/data/initial/countries/api_service.dart';
import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:epaisa_pos/data/models/products_dao.dart';
import 'package:epaisa_pos/data/models/variants_dao.dart';
import 'package:epaisa_pos/src/utility/code_scanner.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/countries.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/packages/widgets/package_item.dart';
import 'package:epaisa_pos/src/views/point_of_sale/widgets/grid_list.dart';
import 'package:epaisa_pos/src/views/point_of_sale/widgets/grid_list_pin.dart';
import 'package:epaisa_pos/src/views/point_of_sale/widgets/horizontal_list.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_qrscanner.dart';
import 'package:epaisa_pos/src/widgets/dialogs/dialog_with_header.dart';
import 'package:epaisa_pos/src/widgets/textfields/search_field.dart';
import 'package:epaisa_pos/src/widgets/utils/dialogs_helper.dart';
import 'package:epaisa_pos/src/widgets/utils/request_helper.dart';
import 'package:flutter/material.dart';

class AddProductDialog extends StatefulWidget {
  List<String> marked;
  String type;
  String id;
  Function storeAction;
  AddProductDialog(
      {this.marked, this.type = "distributor", this.id = "", this.storeAction});
  @override
  _AddProductDialogState createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  bool showModal = true;
  int _selectedView = 0;
  GlobalKey<DialogWithHeaderState> _modal = GlobalKey();
  List<Map<String, dynamic>> lw = new List();
  List<Map<String, dynamic>> listman = new List<Map<String, dynamic>>();
  List<Product> products;
  List<String> listMark;
  ProductsDao dao = new ProductsDao(db);
  bool changed = false;
  Future getProducts() async {
    print("SI");
    listman = new List<Map<String, dynamic>>();
    products = await dao.getAll();
    listman.add({"text": "Add"});
    for (var i = 0; i < products.length; i++) {
      var y = products[i].toJson();
      y["text"] = y["name"];
      y["color"] = AppColors.PrimaryBlue;
      y["count"] = 0;
      y["id"] = y["id"];
      listman.add(y);
    }

    print(listman);
    return listman;
  }

  List<String> newList = [];
  @override
  void initState() {
    print("RAPHAELAA${widget.marked}");
    if (widget.marked != null) {
      listMark = widget.marked;
      print("RAPHAEL$listMark");
    } else {
      listMark = [];
    }
    newList.addAll(listMark);
    lw = List.generate(abc.length, (index) {
      return {
        "text": "${abc[index]}ruits & Vegetables",
        "color": baseColors[index % 10],
        "count": 0
      };
    });

    super.initState();
  }

  void closeModal() {
    Navigator.of(context).pop();
    setState(() {
      showModal = false;
    });
  }

  @override
  void dispose() {
    print("hola");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));

    Widget _searchContainer() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: tablet ? wp(1) : wp(2.5)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: SearchField(
                hintText: "${eptxt('search')} ${eptxt('products')}",
                paddingVertical: hp(1.7),
                paddingHorizontal: tablet ? wp(1.5) : wp(3),
                fontSize: tablet ? wp(1.6) : hp(1.9),
              ),
            ),
            if (tablet)
              SizedBox(
                width: tablet ? wp(1.5) : wp(2),
              ),
            if (tablet)
              Container(
                alignment: Alignment.center,
                //color: Colors.red,
                height: tablet ? hp(3.4) + wp(1.8) : hp(5.6),
                width: tablet ? hp(3.4) + wp(1.8) : hp(5.6),
                child: ButtonQRScanner(
                  onTap: () {
                    CodeScanner.scan(
                      onSuccess: (code) {
                        ScreenUtils(MediaQuery.of(context).size)
                            .showCustomDialog(code, context);
                      },
                      onError: (e) => print(e),
                      onBackButton: (e) => print(e),
                    );
                  },
                  borderRadius: hp(0.85),
                ),
              ),
          ],
        ),
      );
    }

    void _showDialog(String message) {
      // flutter defined function

      Navigator.of(context).push(new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          var selected = 0;
          return DialogWithHeader(
            key: _modal,
            message: message,
            width: tablet ? wp(66) : wp(95),
            marginContent: tablet ? wp(1) : wp(3),
            height: tablet ? hp(69) : hp(60),
            content: GridList(
                children: lw,
                totalWidth: tablet ? wp(60) : wp(88),
                marginH: tablet ? hp(0.2) : wp(1),
                gridLength: tablet ? 4 : 3,
                height: tablet ? hp(19) : wp(22),
                onTapGeneral: (_sel) {
                  _modal.currentState.changeTitle("Categories");
                  _modal.currentState.changeContent(
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          HorizontalLists(
                            lw: lw,
                            selected: _sel,
                          ),
                          GridList(
                              children: lw,
                              totalWidth: tablet ? wp(60) : wp(88),
                              marginH: tablet ? hp(0.2) : wp(1),
                              gridLength: tablet ? 4 : 3,
                              height: tablet ? hp(19) : wp(22),
                              onTapGeneral: (_select) {
                                print(_select);
                                _modal.currentState.closeModal();
                              })
                        ],
                      ),
                    ),
                  );
                }),
          );
        },
      ));
    }

    void handleChecked(String id, bool checked) {
      if (checked) {
        newList.add(id);
      } else {
        newList.remove(id);
      }
      print(newList);
      changed = true;
    }

    Widget _buildTabs() {
      var first = _selectedView == 0;
      return Container(
        padding: EdgeInsets.symmetric(horizontal: tablet ? wp(1) : wp(2.5)),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: tablet ? 2 : 1,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedView = 0;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  width: first
                                      ? tablet ? 1 : 0.6
                                      : tablet ? 2 : 1.1,
                                  color: AppColors.DisabledText.withOpacity(
                                      first ? 0.2 : 0.3)),
                              borderRadius: BorderRadius.only(
                                  bottomLeft:
                                      Radius.circular(hp(tablet ? 1.2 : 0.8)),
                                  topLeft:
                                      Radius.circular(hp(tablet ? 1.2 : 0.8)))),
                          padding: EdgeInsets.symmetric(
                              vertical: first ? hp(1.15) : hp(1)),
                          child: Opacity(
                              opacity: first ? 0.8 : 0.3,
                              child: Image.asset(
                                "assets/payments/grid.png",
                                height: tablet ? hp(3.5) : hp(3.5),
                              )),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedView = 1;
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    width: !first
                                        ? tablet ? 2 : 1.1
                                        : tablet ? 1 : 0.6,
                                    color: AppColors.DisabledText.withOpacity(
                                        !first ? 0.2 : 0.3)),
                                borderRadius: BorderRadius.only(
                                    bottomRight:
                                        Radius.circular(hp(tablet ? 1.2 : 0.8)),
                                    topRight: Radius.circular(
                                        hp(tablet ? 1.1 : 0.8)))),
                            padding: EdgeInsets.symmetric(
                                vertical: !first ? hp(1.15) : hp(1)),
                            child: Opacity(
                                opacity: !first ? 0.8 : 0.3,
                                child: Image.asset(
                                  "assets/payments/list.png",
                                  height: tablet ? hp(3.5) : hp(3.5),
                                ))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: wp(1),
            ),
            Expanded(
              flex: tablet ? 7 : 1,
              child: GestureDetector(
                onTap: () {
                  _showDialog("Categories");
                },
                child: Container(
                  height: hp(5.6),
                  padding: EdgeInsets.symmetric(vertical: hp(0.5)),
                  decoration: BoxDecoration(
                    color: AppColors.PrimaryWhite,
                    borderRadius: BorderRadius.circular(hp(tablet ? 1 : 0.7)),
                    boxShadow: [
                      new BoxShadow(
                          color: AppColors.DarkGray.withOpacity(
                              tablet ? 0.8 : 0.6),
                          offset: new Offset(0.6, 1.3),
                          blurRadius: 1.0)
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "CATEGORIES",
                    style: TextStyle(
                        fontSize: tablet ? hp(2) : wp(3.5),
                        fontWeight: FontWeight.w700,
                        color: AppColors.DarkGray),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    return !showModal
        ? Container()
        : EpaisaScaffold(
            appBar: EpaisaAppBar(
              back: true,
              backasClose: true,
              title: "SELECT PRODUCTS",
              onTapClose: () {
                if (changed) {
                  print("RAPHAEL$newList");
                  widget.storeAction(newList);
                }
                closeModal();
              },
              trailing: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: tablet ? 0 : wp(3)),
                  child: GestureDetector(
                    onTap: () {
                      listMark = new List<String>();
                      for (var i = 1; i < listman.length; i++) {
                        listMark.add(listman[i]["id"]);
                      }
                      newList = listMark;
                      changed = true;
                      setState(() {});
                      print(listMark);
                    },
                    child: Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: hp(0.2)),
                            height: hp(3),
                            width: hp(3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(hp(0.5)),
                                border: Border.all(
                                    color: AppColors.DarkWhite, width: 2.2)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: hp(1),
                  ),
                  _searchContainer(),
                  SizedBox(
                    height: hp(1),
                  ),
                  _buildTabs(),
                  SizedBox(height: hp(0.5)),
                  FutureBuilder(
                      future: getProducts(),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          return GridListPin(
                            itemBuilder: (
                                {String text, color, onTap, int index}) {
                              if (index == 0) {
                                return Container(
                                  margin: EdgeInsets.only(top: 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        (tablet ? wp(1.3) : hp(1.9)) * 0.3),
                                    color: AppColors.PrimaryWhite,
                                    boxShadow: [
                                      new BoxShadow(
                                          color: AppColors.DarkGray.withOpacity(
                                              tablet ? 0.6 : 0.8),
                                          offset: new Offset(0.6, 1.0),
                                          blurRadius: 1.0)
                                    ],
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          alignment: Alignment.bottomCenter,
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  (tablet ? wp(1.3) : hp(1.9))),
                                          child: Container(
                                            child: Image.asset(
                                              "assets/packages/plusicon.png",
                                              height:
                                                  (tablet ? wp(1.3) : hp(1.9)) *
                                                      2,
                                              width:
                                                  (tablet ? wp(1.3) : hp(1.9)) *
                                                      2,
                                              color: AppColors.DarkGray,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 12.0,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: tablet ? 0 : wp(2)),
                                          alignment: Alignment.topCenter,
                                          child: FittedBox(
                                            child: Text(
                                              "ADD NEW PRODUCT",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: AppColors.DarkGray,
                                                //fontSize: (tablet ? wp(1.4) : hp(1.9)) * 0.7,
                                                fontWeight: tablet
                                                    ? FontWeight.w700
                                                    : FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return PackageItem(
                                  //onTap: onTap,
                                  text: text,
                                  color: color,
                                  noPrice: true,
                                  noQuant: true,
                                  noPackage: true,
                                  sideName: true,
                                  checkMark: true,
                                  onChecked: (check) {
                                    handleChecked(listman[index]["id"], check);
                                  },
                                  checked:
                                      listMark.indexOf(listman[index]["id"]) !=
                                          -1,
                                  scale: tablet ? wp(1.35) : hp(1.85),
                                );
                              }
                            },
                            totalWidth: tablet ? wp(92) : wp(89),
                            children: listman,
                            gridLength: tablet ? 6 : 3,
                            height: tablet ? hp(20) : hp(16),
                            verticalMargin: hp(1.3),
                          );
                        } else {
                          return Container();
                        }
                      }),
                  //_gridList(),
                ],
              ),
            ),
          );
  }
}

class AddProductComplexDialog extends StatefulWidget {
  List<Map<String, dynamic>> marked;
  String type;
  String id;
  Function storeAction;
  AddProductComplexDialog(
      {this.marked, this.type = "distributor", this.id = "", this.storeAction});
  @override
  _AddProductComplexDialogState createState() =>
      _AddProductComplexDialogState();
}

class _AddProductComplexDialogState extends State<AddProductComplexDialog> {
  bool showModal = true;
  int _selectedView = 0;
  GlobalKey<DialogWithHeaderState> _modal = GlobalKey();
  List<Map<String, dynamic>> lw = new List();
  List<Map<String, dynamic>> listman = new List<Map<String, dynamic>>();
  List<Variant> variants;
  List<String> listMark;
  List<Map<String, dynamic>> listComplex;
  VariantsDao dao = new VariantsDao(db);
  bool changed = false;
  Future getProducts() async {
    print("SI");
    listman = new List<Map<String, dynamic>>();
    variants = await dao.getAll();
    listman.add({"text": "Add"});
    for (var i = 0; i < variants.length; i++) {
      var y = variants[i].toJson();
      y["text"] = y["name"];
      y["color"] = AppColors.PrimaryBlue;
      y["count"] = 0;
      y["id"] = y["id"];
      listman.add(y);
    }

    print(listman);
    return listman;
  }

  @override
  void initState() {
    print("RAPHAELAA${widget.marked}");
    if (widget.marked != null) {
      listMark = widget.marked.map((o) => o["variantId"].toString()).toList();
      print("RAPHAEL$listMark");
    } else {
      listMark = [];
    }
    listComplex = widget.marked;
    lw = List.generate(abc.length, (index) {
      return {
        "text": "${abc[index]}ruits & Vegetables",
        "color": baseColors[index % 10],
        "count": 0
      };
    });

    super.initState();
  }

  void closeModal() {
    Navigator.of(context).pop();
    setState(() {
      showModal = false;
    });
  }

  @override
  void dispose() {
    print("hola");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));

    Widget _searchContainer() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: tablet ? wp(1) : wp(2.5)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: SearchField(
                hintText: "${eptxt('search')} ${eptxt('products')}",
                paddingVertical: hp(1.7),
                paddingHorizontal: tablet ? wp(1.5) : wp(3),
                fontSize: tablet ? wp(1.6) : hp(1.9),
              ),
            ),
            if (tablet)
              SizedBox(
                width: tablet ? wp(1.5) : wp(2),
              ),
            if (tablet)
              Container(
                alignment: Alignment.center,
                //color: Colors.red,
                height: tablet ? hp(3.4) + wp(1.8) : hp(5.6),
                width: tablet ? hp(3.4) + wp(1.8) : hp(5.6),
                child: ButtonQRScanner(
                  onTap: () {
                    CodeScanner.scan(
                      onSuccess: (code) {
                        ScreenUtils(MediaQuery.of(context).size)
                            .showCustomDialog(code, context);
                      },
                      onError: (e) => print(e),
                      onBackButton: (e) => print(e),
                    );
                  },
                  borderRadius: hp(0.85),
                ),
              ),
          ],
        ),
      );
    }

    void _showDialog(String message) {
      // flutter defined function

      Navigator.of(context).push(new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          var selected = 0;
          return DialogWithHeader(
            key: _modal,
            message: message,
            width: tablet ? wp(66) : wp(95),
            marginContent: tablet ? wp(1) : wp(3),
            height: tablet ? hp(69) : hp(60),
            content: GridList(
                children: lw,
                totalWidth: tablet ? wp(60) : wp(88),
                marginH: tablet ? hp(0.2) : wp(1),
                gridLength: tablet ? 4 : 3,
                height: tablet ? hp(19) : wp(22),
                onTapGeneral: (_sel) {
                  _modal.currentState.changeTitle("Categories");
                  _modal.currentState.changeContent(
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          HorizontalLists(
                            lw: lw,
                            selected: _sel,
                          ),
                          GridList(
                              children: lw,
                              totalWidth: tablet ? wp(60) : wp(88),
                              marginH: tablet ? hp(0.2) : wp(1),
                              gridLength: tablet ? 4 : 3,
                              height: tablet ? hp(19) : wp(22),
                              onTapGeneral: (_select) {
                                print(_select);
                                _modal.currentState.closeModal();
                              })
                        ],
                      ),
                    ),
                  );
                }),
          );
        },
      ));
    }

    void handleChecked(String id, bool checked) {
      if (checked) {
        listMark.add(id);
        listComplex.add({"variantId": id, "quantity": 0});
      } else {
        listMark.remove(id);
        [].removeWhere((x) => x.id == id);
        listComplex.removeWhere((x) => x["variantId"] == id);
      }
      print(listMark);
      changed = true;
    }

    Widget _buildTabs() {
      var first = _selectedView == 0;
      return Container(
        padding: EdgeInsets.symmetric(horizontal: tablet ? wp(1) : wp(2.5)),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: tablet ? 2 : 1,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedView = 0;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  width: first
                                      ? tablet ? 1 : 0.6
                                      : tablet ? 2 : 1.1,
                                  color: AppColors.DisabledText.withOpacity(
                                      first ? 0.2 : 0.3)),
                              borderRadius: BorderRadius.only(
                                  bottomLeft:
                                      Radius.circular(hp(tablet ? 1.2 : 0.8)),
                                  topLeft:
                                      Radius.circular(hp(tablet ? 1.2 : 0.8)))),
                          padding: EdgeInsets.symmetric(
                              vertical: first ? hp(1.15) : hp(1)),
                          child: Opacity(
                              opacity: first ? 0.8 : 0.3,
                              child: Image.asset(
                                "assets/payments/grid.png",
                                height: tablet ? hp(3.5) : hp(3.5),
                              )),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedView = 1;
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    width: !first
                                        ? tablet ? 2 : 1.1
                                        : tablet ? 1 : 0.6,
                                    color: AppColors.DisabledText.withOpacity(
                                        !first ? 0.2 : 0.3)),
                                borderRadius: BorderRadius.only(
                                    bottomRight:
                                        Radius.circular(hp(tablet ? 1.2 : 0.8)),
                                    topRight: Radius.circular(
                                        hp(tablet ? 1.1 : 0.8)))),
                            padding: EdgeInsets.symmetric(
                                vertical: !first ? hp(1.15) : hp(1)),
                            child: Opacity(
                                opacity: !first ? 0.8 : 0.3,
                                child: Image.asset(
                                  "assets/payments/list.png",
                                  height: tablet ? hp(3.5) : hp(3.5),
                                ))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: wp(1),
            ),
            Expanded(
              flex: tablet ? 7 : 1,
              child: GestureDetector(
                onTap: () {
                  _showDialog("Categories");
                },
                child: Container(
                  height: hp(5.6),
                  padding: EdgeInsets.symmetric(vertical: hp(0.5)),
                  decoration: BoxDecoration(
                    color: AppColors.PrimaryWhite,
                    borderRadius: BorderRadius.circular(hp(tablet ? 1 : 0.7)),
                    boxShadow: [
                      new BoxShadow(
                          color: AppColors.DarkGray.withOpacity(
                              tablet ? 0.8 : 0.6),
                          offset: new Offset(0.6, 1.3),
                          blurRadius: 1.0)
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "CATEGORIES",
                    style: TextStyle(
                        fontSize: tablet ? hp(2) : wp(3.5),
                        fontWeight: FontWeight.w700,
                        color: AppColors.DarkGray),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    return !showModal
        ? Container()
        : EpaisaScaffold(
            appBar: EpaisaAppBar(
              back: true,
              backasClose: true,
              title: "SELECT PRODUCTS",
              onTapClose: () {
                if (changed) {
                  print("RAPHAEL$listMark");
                  widget.storeAction(listComplex);
                }
                closeModal();
              },
              trailing: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: tablet ? 0 : wp(3)),
                  child: GestureDetector(
                    onTap: () {
                      listMark = new List<String>();
                      listComplex = new List<Map<String, dynamic>>();
                      for (var i = 1; i < listman.length; i++) {
                        listMark.add(listman[i]["id"]);
                        listComplex.add(
                            {"variantId": listman[i]["id"], "quantity": 0});
                      }
                      // newList = listMark;
                      changed = true;
                      setState(() {});
                      print(listMark);
                    },
                    child: Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: hp(0.2)),
                            height: hp(3),
                            width: hp(3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(hp(0.5)),
                                border: Border.all(
                                    color: AppColors.DarkWhite, width: 2.2)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: hp(1),
                  ),
                  _searchContainer(),
                  SizedBox(
                    height: hp(1),
                  ),
                  _buildTabs(),
                  SizedBox(height: hp(0.5)),
                  FutureBuilder(
                      future: getProducts(),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          return GridListPin(
                            itemBuilder: (
                                {String text, color, onTap, int index}) {
                              if (index == 0) {
                                return Container(
                                  margin: EdgeInsets.only(top: 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        (tablet ? wp(1.3) : hp(1.9)) * 0.3),
                                    color: AppColors.PrimaryWhite,
                                    boxShadow: [
                                      new BoxShadow(
                                          color: AppColors.DarkGray.withOpacity(
                                              tablet ? 0.6 : 0.8),
                                          offset: new Offset(0.6, 1.0),
                                          blurRadius: 1.0)
                                    ],
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          alignment: Alignment.bottomCenter,
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  (tablet ? wp(1.3) : hp(1.9))),
                                          child: Container(
                                            child: Image.asset(
                                              "assets/packages/plusicon.png",
                                              height:
                                                  (tablet ? wp(1.3) : hp(1.9)) *
                                                      2,
                                              width:
                                                  (tablet ? wp(1.3) : hp(1.9)) *
                                                      2,
                                              color: AppColors.DarkGray,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 12.0,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: tablet ? 0 : wp(2)),
                                          alignment: Alignment.topCenter,
                                          child: FittedBox(
                                            child: Text(
                                              "ADD NEW PRODUCT",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: AppColors.DarkGray,
                                                //fontSize: (tablet ? wp(1.4) : hp(1.9)) * 0.7,
                                                fontWeight: tablet
                                                    ? FontWeight.w700
                                                    : FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return PackageItem(
                                  //onTap: onTap,
                                  text: text,
                                  color: color,
                                  noPrice: true,
                                  noQuant: true,
                                  noPackage: true,
                                  sideName: true,
                                  checkMark: true,
                                  onChecked: (check) {
                                    handleChecked(listman[index]["id"], check);
                                  },
                                  checked:
                                      listMark.indexOf(listman[index]["id"]) !=
                                          -1,
                                  scale: tablet ? wp(1.35) : hp(1.85),
                                );
                              }
                            },
                            totalWidth: tablet ? wp(92) : wp(89),
                            children: listman,
                            gridLength: tablet ? 6 : 3,
                            height: tablet ? hp(20) : hp(16),
                            verticalMargin: hp(1.3),
                          );
                        } else {
                          return Container();
                        }
                      }),
                  //_gridList(),
                ],
              ),
            ),
          );
  }
}
