import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:epaisa_pos/data/models/categories_dao.dart';
import 'package:epaisa_pos/src/utility/code_scanner.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/point_of_sale/widgets/grid_list.dart';
import 'package:epaisa_pos/src/views/point_of_sale/widgets/grid_view_list.dart';
import 'package:epaisa_pos/src/views/point_of_sale/widgets/horizontal_list.dart';
import 'package:epaisa_pos/src/views/point_of_sale/widgets/item_category.dart';
import 'package:epaisa_pos/src/views/point_of_sale/widgets/item_product.dart';
import 'package:epaisa_pos/src/views/screen_with_cart/screen_with_cart.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_qrscanner.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_with_icon.dart';
import 'package:epaisa_pos/src/widgets/epaisa/total_amount.dart';
import 'package:epaisa_pos/src/widgets/dialogs/dialog_with_header.dart';
import 'package:epaisa_pos/src/widgets/general/add_customer.dart';
import 'package:epaisa_pos/src/widgets/icons/cart_number.dart';
import 'package:epaisa_pos/src/widgets/icons/stack_number.dart';
import 'package:epaisa_pos/src/widgets/textfields/search_field.dart';
import 'package:flutter/material.dart';
import 'package:epaisa_pos/src/widgets/dialogs/dialog_common.dart';

class PointOfSaleScreen extends StatefulWidget {
  PointOfSaleScreen({this.navigate});
  final Function navigate;

  @override
  _PointOfSaleScreenState createState() => _PointOfSaleScreenState();
}

class _PointOfSaleScreenState extends State<PointOfSaleScreen> {
  int indexState = 0;
  int _selected = -1;
  int _selectedView = 0;
  int sized = 0;
  GlobalKey<DialogWithHeaderState> _modal = GlobalKey();
  List<Map<String, dynamic>> lw;
  List<Map<String, dynamic>> listman = new List<Map<String, dynamic>>();
  List<Categorie> categories;
  CategoriesDao categoriesDao = new CategoriesDao(db);
  List<Map<String, dynamic>> listsub = new List<Map<String, dynamic>>();
  @override
  void initState() {
    var abc = [
      "A",
      "B",
      "C",
      "D",
      "E",
      "F",
      "G",
      "H",
      "I",
      "J",
      "K",
      "L",
      "M",
      "N",
      "O",
      "P",
      "Q",
      "R",
      "S",
      "T",
      "U",
      "V",
      "W",
      "X",
      "Y",
      "Z",
      "#"
    ];
    lw = List.generate(abc.length, (index) {
      return {
        "text": "${abc[index]}ruits & Vegetables",
        "color": baseColors[index % 10],
        "count": 0
      };
    });
    super.initState();
  }

  Future getCategoriesParents() async {
    print("SI");
    listman = new List<Map<String, dynamic>>();
    categories = await categoriesDao.getParents();
    listman = categories.map((x) {
      var y = x.toJson();
      y["text"] = y["name"];
      y["color"] = AppColors.PrimaryBlue;
      y["price"] = 100.0;
      y["cant"] = 33;
      y["count"] = 0;
      return y;
    }).toList();
    print(listman);
    return listman;
  }

  Future getChildrenCategories(String id) async {
    print("SI");
    listsub = new List<Map<String, dynamic>>();
    categories = await categoriesDao.getChildren(id);
    listsub = categories.map((x) {
      var y = x.toJson();
      y["text"] = y["name"];
      y["color"] = AppColors.PrimaryBlue;
      y["price"] = 100.0;
      y["cant"] = 33;
      return y;
    }).toList();
    print(listsub);
    return listsub;
  }

  @override
  Widget build(BuildContext context) {
    // BarcodeScanner.scan().then((onValue) {
    //   print(onValue);
    // }).catchError((onError) {
    //   print(onError);
    // });
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
                hintText:
                    "${eptxt('search')} ${eptxt('categories')} | ${eptxt('products')} | ${eptxt('packages')}",
                paddingVertical: hp(1.7),
                paddingHorizontal: tablet ? wp(1.5) : wp(3),
                fontSize: tablet ? wp(1.6) : hp(1.9),
              ),
            ),
            SizedBox(
              width: tablet ? wp(2) : wp(2),
            ),
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
            if (indexState == 1)
              SizedBox(
                width: tablet ? wp(2) : wp(2),
              ),
            if (indexState == 1)
              Container(
                alignment: Alignment.center,
                //color: Colors.red,
                height: tablet ? hp(3.4) + wp(1.8) : hp(5.6),
                width: tablet ? hp(3.4) + wp(1.8) : hp(5.6),
                child: ButtonWithIcon(
                  icon: Icon(Icons.format_align_center),
                  onTap: () {},
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

    Widget _buildTabs() {
      var first = _selectedView == 0;
      return Container(
        padding: EdgeInsets.symmetric(horizontal: tablet ? wp(1) : wp(2.5)),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
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
              flex: tablet ? 2 : 1,
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

    Widget _buildContent() {
      return EpaisaScaffold(
        appBar: EpaisaAppBar(
          openDrawer: () {
            Scaffold.of(context).openDrawer();
          },
          menu: true,
          title: eptxt('point_of_sale').toUpperCase(),
          trailing: <Widget>[
            Container(
              child: GestureDetector(
                onTap: () {
                  widget.navigate(14);
                },
                child: StackNumber(
                  number: 5,
                  size: tablet ? wp(2.5) : hp(3.5),
                ),
              ),
            ),
            if (!tablet)
              GestureDetector(
                onTap: () {
                  Scaffold.of(context).openEndDrawer();
                },
                child: Container(
                    margin: EdgeInsets.only(left: wp(3), right: wp(.5)),
                    child: CartNumber(
                      number: 3,
                      size: tablet ? hp(3) : wp(7),
                    )),
              )
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              tablet
                  ? Container()
                  : TotalAmount(
                      context: context,
                      value: '1570.00',
                    ),
              SizedBox(
                height: hp(1),
              ),
              _searchContainer(),
              SizedBox(
                height: hp(1),
              ),
              tablet || indexState == 2 ? _buildTabs() : Container(),
              tablet || indexState == 2
                  ? SizedBox(height: hp(0.5))
                  : Container(),
              indexState == 0
                  ? FutureBuilder(
                      future: getCategoriesParents(),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          return GridViewList(
                            itemBuilder: ({item, onTap, int index}) {
                              return ItemCategory(
                                onTap: onTap,
                                text: item['text'],
                                color: baseColors[index % 10],
                                scale: tablet ? wp(1.3) : hp(1.9),
                                tablet: tablet,
                              );
                            },
                            items: listman,
                            gridLength: tablet ? 4 : 3,
                            height: tablet
                                ? hp(indexState == 2 ? 23 : 20)
                                : hp(indexState == 2 ? 18 : 13),
                            //selectedView: _selectedView,
                            selected: _selected,
                            //indexState: indexState,
                            verticalMargin: hp(1.3),
                            onTapFirst: (index) {
                              print(index);
                              setState(() {
                                if (listman[index]["children"] == null) {
                                  indexState = 2;
                                } else {
                                  indexState = 1;
                                }

                                _selected = index;
                              });
                            },
                          );
                        } else {
                          return Container();
                        }
                      })
                  : indexState == 1
                      ? FutureBuilder(
                          future:
                              getChildrenCategories(listman[_selected]["id"]),
                          builder: (context, subCategories) {
                            if (subCategories.data != null) {
                              return GridViewList(
                                itemBuilder: ({item, onTap, int index}) {
                                  return ItemCategory(
                                    onTap: onTap,
                                    text: item['text'],
                                    color: baseColors[index % 10],
                                    scale: tablet ? wp(1.3) : hp(1.9),
                                    tablet: tablet,
                                  );
                                },
                                items: listsub,
                                topItems: listman,
                                gridLength: tablet ? 4 : 3,
                                height: tablet
                                    ? hp(indexState == 2 ? 23 : 20)
                                    : hp(indexState == 2 ? 18 : 13),
                                selected: _selected,
                                indexState: indexState,
                                verticalMargin: hp(1.3),
                                onTapTab: (index) {
                                  setState(() {
                                    _selected = index;
                                    if (listman[_selected]["children"] ==
                                        null) {
                                      indexState = 2;
                                    }
                                  });
                                },
                                onTapFirst: (index) {
                                  print(index);
                                  setState(() {
                                    indexState = 2;
                                    _selected = index;
                                  });
                                },
                                onTapSecond: (index) {
                                  print(index);
                                },
                              );
                            } else {
                              return Container();
                            }
                          },
                        )
                      : indexState == 2
                          ? GridViewList(
                              itemBuilder: ({item, onTap, int index}) {
                                return ItemProduct(
                                  view: ItemProductViewType.ItemProductViewGrid,
                                  onTap: () {
                                    setState(() {
                                      listman[index]['count'] = 1;
                                    });
                                  },
                                  counter: listman[index]['count'],
                                  onAdd: () {
                                    setState(() {
                                      listman[index]['count'] =
                                          listman[index]['count'] + 1;
                                    });
                                  },
                                  onSub: () {
                                    if (listman[index]['count'] <= -1) return;

                                    setState(() {
                                      listman[index]['count'] =
                                          listman[index]['count'] - 1;
                                    });
                                  },
                                  name: "PARLE MARIE GOLD",
                                  stock: 44,
                                  price: 120.00,
                                );
                              },
                              items: listman,
                              gridLength: tablet ? 4 : 3,
                              height: tablet
                                  ? hp(indexState == 2 ? 23 : 20)
                                  : hp(indexState == 2 ? 18 : 13),
                              selected: _selected,
                              indexState: indexState,
                              verticalMargin: hp(1.3),
                              onTapTab: (index) {
                                setState(() {
                                  _selected = index;
                                });
                              },
                              onTapFirst: (index) {
                                print(index);
                                setState(() {
                                  //indexState = indexState + 1;
                                  _selected = index;
                                });
                              },
                              onTapSecond: (index) {
                                print(index);
                              },
                            )
                          : Container(),
              Container(
                height: tablet ? 0 : hp(6),
                child: tablet
                    ? Container()
                    : AddCustomer(
                        hp: hp,
                      ),
              )
            ],
          ),
        ),
      );
    }

    return tablet
        ? ScreenWithCart(
            body: _buildContent(),
          )
        : _buildContent();
  }
}
