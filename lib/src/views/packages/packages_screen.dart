import 'dart:convert' as JSON;

import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:epaisa_pos/data/models/packages_dao.dart';
import 'package:epaisa_pos/src/utility/code_scanner.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/packages/add_packages/add_package_screen.dart';
import 'package:epaisa_pos/src/views/packages/widgets/package_item.dart';
import 'package:epaisa_pos/src/views/point_of_sale/widgets/grid_list_pin.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_qrscanner.dart';
import 'package:epaisa_pos/src/widgets/textfields/search_field.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class PackagesScreen extends StatefulWidget {
  @override
  _PackagesScreenState createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  List<Map<String, dynamic>> listman = new List<Map<String, dynamic>>();
  List<Package> packages;
  PackagesDao packagesDao = new PackagesDao(db);
  BehaviorSubject<String> packageStream = BehaviorSubject<String>();

  Future getCategories() async {
    print("SI");
    listman = new List<Map<String, dynamic>>();
    packages = await packagesDao.getAll();
    print("PACKAGES $packages");
    listman = packages.map((x) {
      var y = x.toJson();
      var length = 0;
      if (y["list"] != "") {
        length = JSON.jsonDecode(y["list"]).length;
      }

      y["text"] = y["name"];
      y["color"] = AppColors.PrimaryBlue;
      y["cant"] = length;
      return y;
    }).toList();
    print("Listman $listman");
    return listman;
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
                hintText:
                    "${eptxt('search')} ${eptxt('categories')} | ${eptxt('products')} | ${eptxt('packages')}",
                paddingVertical: hp(1.7),
                paddingHorizontal: tablet ? wp(1.5) : wp(3),
                fontSize: tablet ? wp(1.6) : hp(1.9),
                callback: (str) {
                  packageStream.sink.add(str);
                },
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
          title: "PACKAGES",
          trailing: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPackageScreen(),
                  ),
                );
                //_showDialog();
              },
              child: Image.asset(
                "assets/header/plusicon.png",
                height: tablet ? hp(3.5) : hp(2.4),
                width: tablet ? hp(3.5) : hp(2.4),
              ),
            )
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
              FutureBuilder(
                  future: getCategories(),
                  builder: (context, snap) {
                    if (snap.data != null) {
                      return StreamBuilder<String>(
                          stream: packageStream,
                          builder: (context, snapshot) {
                            List<Map<String, dynamic>> filtered =
                                new List<Map<String, dynamic>>();
                            if (snapshot.data != null) {
                              filtered = listman
                                  .where((x) =>
                                      x["text"].toLowerCase().indexOf(
                                          snapshot.data.toLowerCase()) ==
                                      0)
                                  .toList();
                            } else {
                              filtered = listman.toList();
                            }

                            return GridListPin(
                                heightLetters: 80,
                                itemBuilder: (
                                    {String text,
                                    String products,
                                    color,
                                    onTap,
                                    int index}) {
                                  return PackageItem(
                                    onTap: () {
                                      Package p =
                                          PackagesDao.fromMap(listman[index]);
                                      print("PAPA");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AddPackageScreen(package: p),
                                        ),
                                      );
                                    },
                                    text: text,
                                    color: color,
                                    scale: tablet ? wp(1.3) : wp(3.8),
                                    price: 25,
                                    products:
                                        filtered[index]["cant"].toString(),
                                    quantity: filtered[index]["cant"],
                                    gridLength: tablet ? 6 : 3,
                                    bottomPadding: hp(0.3),
                                  );
                                },
                                children: filtered,
                                gridLength: tablet ? 6 : 3,
                                height: tablet ? hp(21) : hp(18),
                                verticalMargin: hp(1.3),
                                totalWidth: wp(91),
                                onTapFirst: (index) {});
                          });
                    } else {
                      return Container();
                    }
                  }),
            ],
          ),
        ),
      );
    }

    return _buildContent();
  }
}
