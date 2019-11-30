import 'dart:convert';
import 'dart:io';

import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/data/initial/countries/api_service.dart';
import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:epaisa_pos/data/models/packages_dao.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/validators/Validators.dart';
import 'package:epaisa_pos/src/views/packages/add_packages/add_package_info.dart';
import 'package:epaisa_pos/src/views/packages/add_packages/add_package_price.dart';
import 'package:epaisa_pos/src/views/packages/add_packages/add_package_taxes.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/widgets/texts/text_blue.dart';
import 'package:epaisa_pos/src/widgets/texts/text_gray.dart';
import 'package:epaisa_pos/src/widgets/utils/dialogs_helper.dart';
import 'package:epaisa_pos/src/widgets/utils/request_helper.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class AddPackageScreen extends StatefulWidget {
  Package package;
  AddPackageScreen({this.package});
  @override
  _AddPackageScreenState createState() => _AddPackageScreenState();
}

class _AddPackageScreenState extends State<AddPackageScreen> {
  int _selectedIndex;
  AddPackageBloc bloc = new AddPackageBloc();

  @override
  void initState() {
    _selectedIndex = 0;
    if (widget.package != null) {
      bloc.changeDetails(widget.package.id);
      var list = [];
      if (widget.package.list.length > 10) {
        list = json.decode(widget.package.list
            .substring(1)
            .substring(0, widget.package.list.length - 2)
            .replaceAll("\\", ""));
      }

      List<Map<String, dynamic>> newList = new List<Map<String, dynamic>>();
      for (var i = 0; i < list.length; i++) {
        newList.add({
          "variantId": list[i]["variantId"],
          "quantity": list[i]["quantity"]
        });
      }
      var categories = [];
      if (widget.package.categories != null && widget.package.categories != "")
        categories = widget.package.categories.split(",");
      if (categories.length != 0) {
        print("CATEGORIES${categories.length}");
        bloc.changeCategory(categories[0]);
        if (categories.length > 1) {
          bloc.changeSubCategory(categories[1]);
        }
      }
      //print("CURRENT PACKAGE: ${list[0]["variantId"]}");
      //bloc.changeCategory()
      bloc.changeProducts(newList);
      bloc.changeName(widget.package.name);
      bloc.changeDescription(widget.package.description);
      bloc.changePrice(widget.package.price.toString());
      bloc.changeInventory(widget.package.inventory.toString());
      bloc.changeThreshold(widget.package.threshold.toString());
      bloc.changeSKU(widget.package.sku);
      if (widget.package.isGst != null) bloc.changeIsGST(widget.package.isGst);
      if (widget.package.isVat != null) bloc.changeIsVAT(widget.package.isVat);
      bloc.changeBarcode(widget.package.barcode);
      bloc.changeUnit(widget.package.unitId);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    Widget _getScreen() {
      switch (_selectedIndex) {
        case 0:
          return AddPackageInfoScreen(
              bloc: bloc,
              callback: (selected) {
                if (selected == 1) {
                  setState(() {
                    _selectedIndex = 1;
                  });
                }
              });
        case 1:
          return AddPackagePriceScreen(
              bloc: bloc,
              callback: (selected) {
                if (selected == 2) {
                  setState(() {
                    _selectedIndex = 2;
                  });
                }
              });
        case 2:
          return AddPackageTaxesScreen(bloc: bloc);
      }
    }

    Widget _getScreenTablet() {
      switch (_selectedIndex) {
        case 0:
          return Row(
            children: <Widget>[
              Expanded(
                child: AddProducttoPackage(
                  productList: bloc.products,
                  changeProduct: (val) {
                    bloc.changeProducts(val);
                  },
                ),
              ),
              Expanded(
                child: Opacity(
                    opacity: 1,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        AddPackageInfoScreen(
                            bloc: bloc,
                            callback: (selected) {
                              if (selected == 1) {
                                setState(() {
                                  _selectedIndex = tablet ? 2 : 1;
                                });
                              }
                            }),
                        GestureDetector(
                          child: Container(
                              //color: Colors.transparent,
                              ),
                        )
                      ],
                    )),
              )
            ],
          );
        case 1:
          return Row(
            children: <Widget>[
              Expanded(
                child: AddPackageInfoScreen(
                    bloc: bloc,
                    callback: (selected) {
                      if (selected == 1) {
                        setState(() {
                          _selectedIndex = 1;
                        });
                      }
                    }),
              ),
              Expanded(
                child: Opacity(
                    opacity: 0.5,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        AddPackagePriceScreen(
                            bloc: bloc,
                            callback: (selected) {
                              if (selected == 2) {
                                setState(() {
                                  _selectedIndex = 2;
                                });
                              }
                            }),
                        GestureDetector(
                          child: Container(
                            color: Colors.transparent,
                          ),
                        )
                      ],
                    )),
              )
            ],
          );
        case 2:
          return Row(
            children: <Widget>[
              Expanded(
                child: AddPackagePriceScreen(
                    bloc: bloc,
                    callback: (selected) {
                      if (selected == 2) {
                        setState(() {
                          _selectedIndex = 2;
                        });
                      }
                    }),
              ),
              Expanded(
                child: Opacity(
                    opacity: 1,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        AddPackageTaxesScreen(bloc: bloc),
                      ],
                    )),
              )
            ],
          );
        case 3:
          return Row(
            children: <Widget>[
              Expanded(
                child: Opacity(
                    opacity: 0.5,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        AddPackagePriceScreen(
                            bloc: bloc,
                            callback: (selected) {
                              if (selected == 2) {
                                setState(() {
                                  _selectedIndex = 2;
                                });
                              }
                            }),
                        GestureDetector(
                          child: Container(
                            color: Colors.transparent,
                          ),
                        )
                      ],
                    )),
              ),
              Expanded(
                child: AddPackageTaxesScreen(bloc: bloc),
              )
            ],
          );
      }
    }

    Widget _tabNavigator() {
      List<String> options = tablet
          ? [
              "Products in Package",
              "Package Info",
              "Price and Inventory",
              "Taxes"
            ]
          : ["Package Info", "Price and Inventory", "Taxes"];
      List<Widget> tabs = new List<Widget>();
      //var counter = 0;
      for (var i = 0; i < options.length; i++) {
        bool isSelected = i == _selectedIndex;
        var x = options[i];
        tabs.add(Expanded(
          flex: tablet ? 1 : i == 2 ? 3 : 5,
          child: GestureDetector(
            onTap: () {
              print(_selectedIndex);

              if (_selectedIndex > i) {
                setState(() {
                  _selectedIndex = i;
                });
              }
              print(_selectedIndex);
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: isSelected
                              ? AppColors.PrimaryBlue
                              : AppColors.DisabledBorder,
                          width: 2.1))),
              alignment: Alignment.center,
              child: isSelected
                  ? TextBlue(
                      title: x,
                      fontSize: tablet ? hp(2) : hp(1.7),
                      fontWeight: FontWeight.w700,
                    )
                  : TextGray(
                      title: x,
                      fontSize: tablet ? hp(2) : hp(1.7),
                      fontWeight: FontWeight.w700,
                      opacity: 0.6,
                    ),
            ),
          ),
        ));
      }
      return Container(
        height: tablet ? hp(7) : hp(5.7),
        child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
          Container(
            width: tablet ? wp(100) : wp(110),
            child: Row(
              children: tabs,
            ),
          ),
        ]),
      );
    }

    return EpaisaScaffold(
      appBar: EpaisaAppBar(
        back: true,
        title: widget.package != null ? "EDIT PACKAGE" : "ADD PACKAGE",
      ),
      body: Column(
        children: <Widget>[
          _tabNavigator(),
          Expanded(child: tablet ? _getScreenTablet() : _getScreen()),
        ],
      ),
    );
  }
}

class AddPackageBloc extends Object with Validators {
  final api = ApiService.create();
  PackagesDao packagesDao = PackagesDao(db);

  final nameStream = BehaviorSubject<String>.seeded("");
  final descriptionStream = BehaviorSubject<String>.seeded("");
  final skuStream = BehaviorSubject<String>.seeded("");
  final priceStream = BehaviorSubject<String>.seeded("");
  final inventoryStream = BehaviorSubject<String>.seeded("");
  final barcodeStream = BehaviorSubject<String>.seeded("");
  final thresholdStream = BehaviorSubject<String>.seeded("");
  final unitStream = BehaviorSubject<String>();
  final categoryStream = BehaviorSubject<String>();
  final subcategoryStream = BehaviorSubject<String>();
  final productsStream = BehaviorSubject<List<Map<String, dynamic>>>.seeded([]);
  final detailsStream = BehaviorSubject<String>.seeded("");
  final isGSTStream = BehaviorSubject<bool>.seeded(false);
  final isVATStream = BehaviorSubject<bool>.seeded(false);
  final imageStream = BehaviorSubject<File>();
  Stream<String> get name => nameStream.stream;
  Stream<String> get description => descriptionStream.stream;
  Stream<String> get sku => skuStream.stream;
  Stream<List<Map<String, dynamic>>> get products => productsStream.stream;

  Function(String) get changeName => nameStream.sink.add;
  Function(String) get changeDescription => descriptionStream.sink.add;
  Function(String) get changeUnit => unitStream.sink.add;
  Function(String) get changeCategory => categoryStream.sink.add;
  Function(String) get changeSubCategory => subcategoryStream.sink.add;
  Function(String) get changeSKU => skuStream.sink.add;
  Function(String) get changePrice => priceStream.sink.add;
  Function(String) get changeInventory => inventoryStream.sink.add;
  Function(String) get changeThreshold => thresholdStream.sink.add;
  Function(String) get changeBarcode => barcodeStream.sink.add;
  Function(bool) get changeIsGST => isGSTStream.sink.add;
  Function(bool) get changeIsVAT => isVATStream.sink.add;
  Function(String) get changeDetails => detailsStream.sink.add;
  Function(List<Map<String, dynamic>>) get changeProducts =>
      productsStream.sink.add;
  Function(File) get changeImage => imageStream.sink.add;

  createPackage(context) async {
    var categories = [];
    categories.add(categoryStream.value);
    if (subcategoryStream.value != null && subcategoryStream.value != "") {
      categories.add(subcategoryStream.value);
    }
    var params = {
      "name": nameStream.value,
      "description": descriptionStream.value,
      "unitId": unitStream.value != null ? unitStream.value : "",
      "categories": categories,
      "price": priceStream.value,
      "inventory": inventoryStream.value,
      "barcode": barcodeStream.value,
      "isGst": isGSTStream.value,
      "isVat": isVATStream.value,
      "threshold": thresholdStream.value,
      "sku": skuStream.value != null ? skuStream.value : "",
      "list": productsStream.value
    };
    print(params);
    showLoading(context);
    await getToken((str) async {
      try {
        var package = await api.createPackages(authKey: str, body: params);
        var pack = package.body;
        /* if (imageStream.value != null) {
          //pack["image"] = imageStream.value.toString();
          await UploadImage(
              "upload/packages/${package.body["id"]}", imageStream.value);
        } */

        print(package.body);
        packagesDao.add(PackagesDao.fromMap(package.body));
        Navigator.pop(context);
        showDialogMessage(context, "Package successfully created", () {
          Navigator.pop(context);
        });
      } catch (e) {
        print(e);
        if (e.body != null) {
          var error = json.decode(e.body);
          print(error);
          Navigator.pop(context);
          showDialogMessage(context, error["message"], () {});
        }
      }
    });
  }

  updatePackage(context, id) async {
    //var c = await packagesDao.getOne(id);
    //var current = c.toJson();
    var categories = [];
    categories.add(categoryStream.value);
    if (subcategoryStream.value != null && subcategoryStream.value != "") {
      categories.add(subcategoryStream.value);
    }
    var params = {
      "name": nameStream.value,
      "description": descriptionStream.value,
      "unitId": unitStream.value != null ? unitStream.value : "",
      "price": priceStream.value,
      "categories": categories,
      "inventory": inventoryStream.value,
      "barcode": barcodeStream.value,
      "threshold": thresholdStream.value,
      "isGst": isGSTStream.value,
      "isVat": isVATStream.value,
      "sku": skuStream.value != null ? skuStream.value : "",
      "list": productsStream.value
    };
    //current.addAll(params);
    print("PAPAPA${params}");
    showLoading(context);
    await getToken((str) async {
      try {
        print("ID PA CHRISTIAN $id");
        var package =
            await api.updatePackages(authKey: str, body: params, id: id);
        print("RESPONSE${package.body}");
        packagesDao.edit(PackagesDao.fromMap(package.body));
        Navigator.pop(context);
        showDialogMessage(context, "Package successfully updated", () {
          Navigator.pop(context);
        });
      } catch (e) {
        print(e);
        if (e.body != null) {
          var error = json.decode(e.body);
          print(error);
          Navigator.pop(context);
          showDialogMessage(context, error["message"], () {});
        }
      }
    });
  }

  dispose() {
    print('dispose');
    nameStream.close();
    descriptionStream.close();
    unitStream.close();
    categoryStream.close();
    subcategoryStream.close();
    skuStream.close();
    productsStream.close();
    detailsStream.close();
    imageStream.close();
    thresholdStream.close();
    priceStream.close();
    barcodeStream.close();
    inventoryStream.close();
    isGSTStream.close();
    isVATStream.close();
  }
}
