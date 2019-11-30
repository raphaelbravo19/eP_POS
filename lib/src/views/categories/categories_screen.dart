import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:epaisa_pos/data/models/categories_dao.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/remove_over_scroll_glow.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/categories/add_categories/add_categories_screen.dart';
import 'package:epaisa_pos/src/views/point_of_sale/widgets/grid_list_pin.dart';
import 'package:rxdart/rxdart.dart';
import '../point_of_sale/widgets/item_category.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/widgets/textfields/search_field.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:epaisa_pos/data/database.dart';
import 'dart:convert' as JSON;

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Map<String, dynamic>> listman = new List<Map<String, dynamic>>();
  List<Categorie> categories;
  CategoriesDao categoriesDao = new CategoriesDao(db);
  BehaviorSubject<String> categoryStream = BehaviorSubject<String>();

  Future getCategories() async {
    print("SI");
    listman = new List<Map<String, dynamic>>();
    categories = await categoriesDao.getAll();
    listman = categories.map((x) {
      var y = x.toJson();
      y["text"] = y["name"];
      y["color"] =
          y["color"] != null ? HexColor(y["color"]) : AppColors.PrimaryBlue;
      y["products"] =
          JSON.jsonDecode(y["products"] != null ? y["products"] : []);
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

    return EpaisaScaffold(
      appBar: EpaisaAppBar(
        openDrawer: () {
          Scaffold.of(context).openDrawer();
        },
        menu: true,
        title: 'CATEGORIES',
        trailing: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddCategoriesScreen()));
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
            child: SearchField(
              hintText: "${eptxt('search')} ${eptxt('categories')}",
              paddingVertical: hp(1.7),
              paddingHorizontal: tablet ? wp(1.5) : wp(3),
              fontSize: tablet ? wp(1.6) : hp(1.9),
              callback: (str) {
                categoryStream.sink.add(str);
              },
            ),
          ),
          SizedBox(
            height: hp(0.5),
          ),
          FutureBuilder(
              future: getCategories(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return StreamBuilder<String>(
                      stream: categoryStream,
                      builder: (context, snapshot) {
                        List<Map<String, dynamic>> filtered =
                            new List<Map<String, dynamic>>();
                        if (snapshot.data != null) {
                          filtered = listman
                              .where((x) =>
                                  x["text"]
                                      .toLowerCase()
                                      .indexOf(snapshot.data.toLowerCase()) ==
                                  0)
                              .toList();
                        } else {
                          filtered = listman.toList();
                        }
                        return GridListPin(
                            isProducts: true,
                            heightLetters: 80,
                            itemBuilder: (
                                {String text,
                                String products,
                                color,
                                onTap,
                                int index}) {
                              return ItemCategory(
                                onTap: () {
                                  var maincolor = filtered[index];
                                  maincolor["color"] =
                                      '#${maincolor["color"].value.toRadixString(16)}';
                                  Categorie cat =
                                      CategoriesDao.fromMap(maincolor);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AddCategoriesScreen(
                                                category: cat,
                                              )));
                                },
                                text: text,
                                products: products,
                                color: color,
                                scale: tablet ? wp(1.3) : wp(3.9),
                                tablet: tablet,
                              );
                            },
                            children: filtered,
                            gridLength: tablet ? 6 : 3,
                            height: tablet ? hp(20) : hp(12),
                            verticalMargin: hp(1.3),
                            totalWidth: wp(89),
                            onTapFirst: (index) {});
                      });
                } else {
                  return Container();
                }
              }),
        ],
      ),
    );
  }
}
