import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:epaisa_pos/data/models/products_dao.dart';
import 'package:epaisa_pos/src/utility/code_scanner.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/remove_over_scroll_glow.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/packages/widgets/package_item.dart';
import 'package:epaisa_pos/src/views/point_of_sale/widgets/grid_list_pin.dart';
import 'package:epaisa_pos/src/views/products/add_products/add_product_screen.dart';
import 'package:epaisa_pos/src/views/products/widgets/item_product.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_qrscanner.dart';
import 'package:epaisa_pos/src/widgets/textfields/search_field.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  GlobalKey<SearchFieldState> _keySearch = GlobalKey();
  List<Map<String, dynamic>> listman = new List<Map<String, dynamic>>();
  List<Product> products;
  ProductsDao dao = new ProductsDao(db);
  Future getProducts() async {
    print("SI");
    listman = new List<Map<String, dynamic>>();
    products = await dao.getAll();
    listman = products.map((x) {
      var y = x.toJson();
      y["text"] = y["name"];
      y["color"] = AppColors.PrimaryBlue;
      y["price"] = 100.0;
      y["cant"] = 33;
      return y;
    }).toList();
    print(listman);
    return listman;
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));

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
    List<Map<String, dynamic>> lw = List.generate(abc.length, (index) {
      return {
        "text": "${abc[index]}arle marie gold",
        "price": 100.0,
        "cant": 33,
        "color": AppColors.PrimaryBlue
      };
    });
    return EpaisaScaffold(
      appBar: EpaisaAppBar(
        openDrawer: () {
          Scaffold.of(context).openDrawer();
        },
        menu: true,
        title: 'PRODUCTS',
        trailing: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProductScreen(),
                ),
              );
            },
            child: Image.asset(
              "assets/header/plusicon.png",
              height: tablet ? hp(3.5) : hp(2.4),
              width: tablet ? hp(3.5) : hp(2.4),
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: hp(0.5),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: tablet ? wp(1) : wp(2.5)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: SearchField(
                    key: _keySearch,
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
                          _keySearch.currentState.changeText(code);
                          //ScreenUtils(MediaQuery.of(context).size)
                          //  .showCustomDialog(code, context);
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
          ),
          SizedBox(
            height: hp(0.5),
          ),
          FutureBuilder(
              future: getProducts(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return GridListPin(
                      itemBuilder: ({String text, color, onTap, int index}) {
                        return PackageItem(
                          onTap: () async {
                            var product =
                                await dao.getOne(listman[index]["id"]);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddProductScreen(
                                  product: product,
                                ),
                              ),
                            );
                          },
                          text: text,
                          products: "5",
                          color: color,
                          scale: tablet ? wp(1.5) : wp(3.4),
                          price: 0,
                          image: listman[index]["images"] != null
                              ? listman[index]["images"].split(',')[0]
                              : null,
                          sideName: true,
                          quantity: listman[index]["cant"],
                          gridLength: tablet ? 6 : 3,
                          noPackage: true,
                          noPrice: true,
                        );
                      },
                      children: listman,
                      gridLength: tablet ? 6 : 3,
                      height: tablet ? hp(20) : hp(18),
                      indexState: 0,
                      totalWidth: wp(91),
                      selected: 0,
                      selectedView: 0,
                      verticalMargin: hp(1.3),
                      onTapFirst: (index) {});
                } else {
                  return Container();
                }
              }),
        ],
      ),
    );
  }
}
