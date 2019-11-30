import 'dart:convert';

import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/data/initial/countries/api_service.dart';
import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:epaisa_pos/data/models/attributes_dao.dart';
import 'package:epaisa_pos/data/models/categories_dao.dart';
import 'package:epaisa_pos/data/models/distributors_dao.dart';
import 'package:epaisa_pos/data/models/products_dao.dart';
import 'package:epaisa_pos/data/models/variants_dao.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/products/add_products/bloc/add_product_bloc.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:epaisa_pos/src/widgets/utils/dialogs_helper.dart';
import 'package:epaisa_pos/src/widgets/utils/image_helper.dart';
import 'package:epaisa_pos/src/widgets/utils/request_helper.dart';
import './add_product_info.dart';
import './add_product_price.dart';
import './add_product_taxes.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/widgets/texts/text_blue.dart';
import 'package:epaisa_pos/src/widgets/texts/text_gray.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  Product product;
  AddProductScreen({this.product});
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  int _selectedIndex;
  ProductsDao dao = new ProductsDao(db);

  VariantsDao daoV = new VariantsDao(db);
  DistributorsDao daoD = new DistributorsDao(db);
  CategoriesDao daoC = new CategoriesDao(db);
  ProductAttributesDao daoA = new ProductAttributesDao(db);
  AddProductBloc bloc = new AddProductBloc();
  @override
  void initState() {
    _selectedIndex = 0;
    if (widget.product != null) {
      fillLocal();
    } else {
      fillStart();
    }

    super.initState();
  }

  Future fillLocal() async {
    bloc.changeName(widget.product.name);
    bloc.changeDescription(widget.product.description);
    if (widget.product.images != null) {
      print("IMAGE FETCHED");
      var images = widget.product.images.split(',');
      bloc.changeImageUrl(images[0]);
    }
    bloc.changeDescription(widget.product.description);
    if (widget.product.hsn != null) bloc.changeHSN(widget.product.hsn);
    var variantsb = widget.product.variants;
    print("VARIANTS DETECTEDB: $variantsb");
    var variants = json.decode(variantsb);
    print("VARIANTS DETECTED: $variants");
    List<Map<String, dynamic>> list = new List<Map<String, dynamic>>();
    for (var i = 0; i < variants.length; i++) {
      print("TO UPDATE ${variants[i]}");
      Variant v = await daoV.getOne(variants[i]);

      list.add(await getTemplate(data: v));
    }

    print("First RAPHAEL: ${widget.product.images}");
    bloc.changeVariants(list);
    bloc.changeUnit(widget.product.unitId);
    bloc.changeManufacturer(widget.product.manufacturerId);
    List<int> cantDist = new List<int>();
    var temp = json.decode(widget.product.distributors);

    List<String> dist = new List<String>();
    for (var i = 0; i < temp.length; i++) {
      String s = temp[i].toString();
      dist.add(s);
    }
    print("DECODED $dist");
    List<Distributor> listDist = await daoD.getAll();
    for (var i = 0; i < dist.length; i++) {
      var j = listDist.indexWhere((x) => x.id == dist[i]);
      cantDist.add(j);
    }
    print(cantDist);
    bloc.changeDistributors(cantDist);
    List<int> cantCat = new List<int>();
    var temp2 = json.decode(widget.product.categories);

    List<String> cate = new List<String>();
    for (var i = 0; i < temp2.length; i++) {
      String s = temp2[i].toString();
      cate.add(s);
    }
    print("DECODED $cate");
    List<Categorie> listCate = await daoC.getAll();
    for (var i = 0; i < cate.length; i++) {
      var j = listCate.indexWhere((x) => x.id == cate[i]);
      cantCat.add(j);
    }
    print(cantCat);
    bloc.changeCategories(cantCat);
  }

  Future fillStart() async {
    var template = await getTemplate();

    bloc.changeVariants([template]);
  }

  Future getTemplate({Variant data}) async {
    print("CAA");
    var customAttributes = await daoA.getAll();
    var attributes = customAttributes
        .where((x) => x.name != "Product")
        .map((x) => {"k": x.name, "v": ""})
        .toList();
    var firstObject = {
      "name": data != null ? data.name : "",
      "barcode": data != null ? data.barcode : "",
      "attributes": data != null ? jsonDecode(data.attributes) : attributes,
      "sku": data != null ? data.sku.toString() : "",
      "inventory": data != null ? data.inventory.toString() : "",
      "threshold": data != null ? data.threshold.toString() : "",
      "mrp": data != null ? data.mrp.toString() : "",
      "price": data != null ? data.price.toString() : ""
    };
    if (data != null) {
      firstObject["id"] = data.id;
    }
    return firstObject;
  }

  @override
  void dispose() {
    //bloc.dispose();
    super.dispose();
  }

  void addProduct() async {
    print("here");
    showLoading(context);
    await getToken((val) async {
      print(val);
      try {
        var params;
        var dist = await daoD.getAll();
        var cate = await daoC.getAll();
        print("DIST");
        var listDist = bloc.streamDistributors.value.map((x) {
          return dist[x].id;
        }).toList();
        print("Cat${bloc.streamCategories.value}");
        var listCate = bloc.streamCategories.value.map((x) {
          return cate[x].id;
        }).toList();
        if (bloc.streamVariants.value.length == 1) {
          var newVariants = bloc.streamVariants.value;
          newVariants[0]["name"] = bloc.streamName.value;
          bloc.changeVariants(newVariants);
        }
        params = {
          "name": bloc.streamName.value,
          "description": bloc.streamDescription.value,
          "distributors": listDist,
          "manufacturerId": bloc.streamManufacturers.value,
          "categories": listCate,
          "unitId": bloc.streamUnit.value,
          "hsn": bloc.streamHsn.value,
          "gst": 5,
          "vat": 8,
          "cess": 19,
          "variants": bloc.streamVariants.value
        };

        print(params);
        var productResponse = await ApiService.create()
            .createProductWithVariants(authKey: val, body: params);

        var product = productResponse.body;
        if (bloc.streamImageChanged.value) {
          product["images"] = [bloc.streamImage.value.toString()];
          await UploadImage(
              "upload/products/${product["id"]}", bloc.streamImage.value);
        }
        print("CREATED - $product");
        product["product"]["variants"] =
            product["variants"].map((x) => (x["id"] as String)).toList();
        dao.add(ProductsDao.fromMap(product["product"]));

        for (var i = 0; i < product["variants"].length; i++) {
          daoV.add(VariantsDao.fromMap(product["variants"][i]));
        }
        Navigator.pop(context);
        Navigator.pop(context);
      } catch (e) {
        print(e);
        if (e.body != null) {
          print(e.body);

          Navigator.pop(context);
          showDialogMessage(
              context, json.decode(e.body)["message"] ?? "", () {});
        } else {
          Navigator.pop(context);
        }
      }
    });
  }

  void updateProduct() async {
    print("here");
    showLoading(context);
    await getToken((val) async {
      print(val);
      try {
        Map<String, dynamic> params = new Map<String, dynamic>();
        var dist = await daoD.getAll();
        var cate = await daoC.getAll();
        print("DIST");
        var listDist = bloc.streamDistributors.value.map((x) {
          return dist[x].id;
        }).toList();
        print("Cat${bloc.streamCategories.value}");
        var listCate = bloc.streamCategories.value.map((x) {
          return cate[x].id;
        }).toList();
        if (bloc.streamVariants.value.length == 1) {
          var newVariants = bloc.streamVariants.value;
          newVariants[0]["name"] = bloc.streamName.value;
          bloc.changeVariants(newVariants);
        }
        var parameters = {
          "name": bloc.streamName.value,
          "description": bloc.streamDescription.value,
          "distributors": listDist,
          "manufacturerId": bloc.streamManufacturers.value,
          "categories": listCate,
          "unitId": bloc.streamUnit.value,
          "hsn": bloc.streamHsn.value,
          "gst": 5,
          "vat": 8,
          "cess": 19,
          "variants": bloc.streamVariants.value
        };
        params = widget.product.toJson();
        params.addAll(parameters);
        print("PARAMETERS $params");
        var productResponse = await ApiService.create()
            .updateProductWithVariants(
                authKey: val, body: params, id: widget.product.id);

        var product = productResponse.body;
        print("PRODUCT UPDATE: $product");
        if (bloc.streamImageChanged.value) {
          product["images"] = [bloc.streamImage.value.toString()];
          await UploadImage(
              "upload/products/${product["id"]}", bloc.streamImage.value);
        }
        var productToStore = product["product"];
        print("GET PRODUCT $product");
        productToStore.addAll(widget.product.toJson());
        productToStore["variants"] =
            json.decode(product["product"]["variants"]);
        productToStore["distributors"] = json
            .decode(product["product"]["distributors"])
            .map((x) => x as String)
            .toList();
        productToStore["categories"] = json
            .decode(product["product"]["categories"])
            .map((x) => x as String)
            .toList();
        print("LAST PRODUCT UPDATE: $productToStore");
        if (bloc.streamImageChanged.value) {
          productToStore["images"] = [bloc.streamImage.value.toString()];
          await UploadImage("upload/products/${productToStore["id"]}",
              bloc.streamImage.value);
        }
        dao.edit(ProductsDao.fromMap(productToStore));
        for (var i = 0; i < bloc.streamVariants.value.length; i++) {
          var prev = await daoV.getOne(bloc.streamVariants.value[i]["id"]);
          print("Step 1");
          var prevjson = prev.toJson();
          print("Step 2");

          prevjson.addAll(bloc.streamVariants.value[i]);
          prevjson["inventory"] = int.parse(prevjson["inventory"]);
          prevjson["mrp"] = int.parse(prevjson["mrp"]);
          prevjson["threshold"] = int.parse(prevjson["threshold"]);
          var t = VariantsDao.fromMap(prevjson);
          daoV.edit(t);
        }
        Navigator.pop(context);
        Navigator.pop(context);
      } catch (e) {
        print(e);
        if (e.body != null) {
          print(e.body);

          Navigator.pop(context);
          showDialogMessage(
              context, json.decode(e.body)["message"] ?? "", () {});
        } else {
          Navigator.pop(context);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));

    Widget _getScreen() {
      switch (_selectedIndex) {
        case 0:
          return AddProductInfoScreen(
              bloc: bloc,
              changeTab: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              });
        case 1:
          return AddProductPriceScreen(
              bloc: bloc,
              changeTab: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              getTemplate: () async {
                return getTemplate();
              });
        case 2:
          return AddProductTaxesScreen(
            addProduct: () {
              if (widget.product != null) {
                updateProduct();
              } else {
                addProduct();
              }
            },
          );
        default:
          return AddProductInfoScreen();
      }
    }

    Widget _getScreenTablet() {
      switch (_selectedIndex) {
        case 0:
          return Row(
            children: <Widget>[
              Expanded(
                child: AddProductInfoScreen(
                  bloc: bloc,
                ),
              ),
              Expanded(
                child: Opacity(
                  opacity: 0.5,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      AddProductPriceScreen(),
                      GestureDetector(
                        child: Container(
                          color: Colors.transparent,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        case 1:
          return Row(
            children: <Widget>[
              Expanded(
                child: AddProductPriceScreen(),
              ),
              Expanded(
                  child: Opacity(
                opacity: 0.5,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    AddProductTaxesScreen(),
                    GestureDetector(
                      child: Container(
                        color: Colors.transparent,
                      ),
                    )
                  ],
                ),
              ))
            ],
          );
        case 2:
          return Row(
            children: <Widget>[
              Expanded(
                child: Opacity(
                    opacity: 0.5,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        AddProductPriceScreen(),
                        GestureDetector(
                          child: Container(
                            color: Colors.transparent,
                          ),
                        )
                      ],
                    )),
              ),
              Expanded(
                child: AddProductTaxesScreen(
                  addProduct: addProduct,
                ),
              )
            ],
          );
        default:
          return Row(
            children: <Widget>[
              Expanded(
                child: AddProductInfoScreen(),
              ),
              Expanded(
                child: AddProductPriceScreen(),
              )
            ],
          );
      }
    }

    Widget _tabNavigator() {
      List<String> options = ["Product Info", "Price and Inventory", "Taxes"];
      List<Widget> tabs = new List<Widget>();
      //var counter = 0;
      for (var i = 0; i < options.length; i++) {
        bool isSelected = i == _selectedIndex;
        var x = options[i];
        tabs.add(Expanded(
          flex: tablet ? 1 : i == 2 ? 3 : 5,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = i;
              });
              print(_selectedIndex);
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: isSelected
                              ? AppColors.PrimaryBlue
                              : AppColors.DisabledBorder,
                          width: 4))),
              alignment: Alignment.center,
              child: isSelected
                  ? TextBlue(
                      title: x,
                      fontSize: tablet ? hp(2) : hp(1.6),
                      fontWeight: FontWeight.w700,
                    )
                  : TextGray(
                      title: x,
                      fontSize: tablet ? hp(2) : hp(1.6),
                      fontWeight: FontWeight.w700,
                      opacity: 0.6,
                    ),
            ),
          ),
        ));
      }
      return Container(
        height: tablet ? hp(7) : hp(5.5),
        child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
          Container(
            color: AppColors.PrimaryWhite,
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
        title: "ADD PRODUCT",
        back: true,
      ),
      body: Column(
        children: <Widget>[
          _tabNavigator(),
          Expanded(
            child: tablet ? _getScreenTablet() : _getScreen(),
          )
        ],
      ),
    );
  }
}
