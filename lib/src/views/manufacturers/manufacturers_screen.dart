import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:epaisa_pos/data/models/manufacturers_dao.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/remove_over_scroll_glow.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/manufacturers/add_manufacturers/add_manufacturers_screen.dart';
import 'package:epaisa_pos/src/views/manufacturers/widgets/item_manu.dart';
import 'package:epaisa_pos/src/views/packages/widgets/package_item.dart';
import 'package:epaisa_pos/src/views/point_of_sale/widgets/grid_list_pin.dart';
import 'package:epaisa_pos/src/views/products/widgets/item_product.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/widgets/textfields/search_field.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert' as JSON;

class ManufacturersScreen extends StatefulWidget {
  @override
  _ManufacturersScreenState createState() => _ManufacturersScreenState();
}

class _ManufacturersScreenState extends State<ManufacturersScreen> {
  List<Map<String, dynamic>> listman = new List<Map<String, dynamic>>();
  List<Manufacturer> manufacturers;
  ManufacturersDao manufacturersDao = new ManufacturersDao(db);
  BehaviorSubject<String> manufacturersStream = BehaviorSubject<String>();
  Future getManufacturers() async {
    print("SI");
    listman = new List<Map<String, dynamic>>();
    manufacturers = await manufacturersDao.getAll();
    listman = manufacturers.map((x) {
      var y = x.toJson();
      y["text"] = y["name"];
      y["color"] = AppColors.PrimaryBlue;
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
        "text": "${abc[index]}arle marie butter",
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
        title: 'MANUFACTURERS',
        trailing: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddManufacturersScreen()));
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
              hintText: "${eptxt('search')} ${eptxt('manufacturers')}",
              paddingVertical: hp(1.7),
              paddingHorizontal: tablet ? wp(1.5) : wp(3),
              fontSize: tablet ? wp(1.6) : hp(1.9),
              callback: (str) {
                manufacturersStream.sink.add(str);
              },
            ),
          ),
          SizedBox(
            height: hp(0.5),
          ),
          FutureBuilder(
              future: getManufacturers(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return StreamBuilder<String>(
                      stream: manufacturersStream,
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
                            itemBuilder: (
                                {String text,
                                String products,
                                color,
                                onTap,
                                int index}) {
                              return PackageItem(
                                onTap: () {
                                  Manufacturer man =
                                      ManufacturersDao.fromMap(filtered[index]);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AddManufacturersScreen(
                                                manufacturer: man,
                                              )));
                                },
                                text: text,
                                products: products,
                                color: color,
                                scale: tablet ? wp(1.5) : wp(3.4),
                                price: 0,
                                image: filtered[index]["image"],
                                sideName: true,
                                quantity: filtered[index]["cant"],
                                gridLength: tablet ? 6 : 3,
                                noPackage: true,
                                noPrice: true,
                              );
                            },
                            children: filtered,
                            gridLength: tablet ? 6 : 3,
                            height: tablet ? hp(18) : hp(16),
                            indexState: 0,
                            totalWidth: wp(91),
                            selected: 0,
                            selectedView: 0,
                            verticalMargin: hp(1.3),
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
