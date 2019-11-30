import 'dart:convert' as JSON;
import 'dart:io';

import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/data/initial/countries/api_service.dart';
import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:epaisa_pos/data/models/country_dao.dart';
import 'package:epaisa_pos/data/models/manufacturers_dao.dart';
import 'package:epaisa_pos/data/models/products_dao.dart';
import 'package:epaisa_pos/src/bloc/location_bloc.dart';
import 'package:epaisa_pos/src/models/Location.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/countries.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/validators/Validator.dart';
import 'package:epaisa_pos/src/views/distributors/add_distributors/widgets/item_product.dart';
import 'package:epaisa_pos/src/views/packages/add_packages/widgets/add_product_dialog.dart';
import 'package:epaisa_pos/src/views/categories/add_categories/widgets/item_add.dart';
import 'package:epaisa_pos/src/views/packages/widgets/package_item.dart';
import 'package:epaisa_pos/src/views/point_of_sale/widgets/grid_list_pin.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_camera.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/textfields/texfield_number.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_dropdown.dart';
import 'package:epaisa_pos/src/widgets/texts/text_blue.dart';
import 'package:epaisa_pos/src/widgets/texts/text_gray.dart';
import 'package:epaisa_pos/src/widgets/utils/dialogs_helper.dart';
import 'package:epaisa_pos/src/widgets/utils/image_helper.dart';
import 'package:epaisa_pos/src/widgets/utils/request_helper.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import './widgets/arrow_card.dart';

class AddManufacturersScreen extends StatefulWidget {
  AddManufacturersScreen({this.manufacturer});
  Manufacturer manufacturer;
  var isIOS = Platform.isIOS;

  @override
  _AddManufacturersScreenState createState() => _AddManufacturersScreenState();
}

class _AddManufacturersScreenState extends State<AddManufacturersScreen> {
  GlobalKey<TextfieldClassicState> manu =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> email =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldNumberState> mobile =
      new GlobalKey<TextfieldNumberState>();
  GlobalKey<TextfieldClassicState> gstin =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> address =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> address2 =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> pincode =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> city =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> country =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> state =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> district =
      new GlobalKey<TextfieldClassicState>();
  var stateIdValue = '5dc31e76b955ba01a75022cb';
  var cityIdValue = '5dc31e76b955ba01a75022cb';
  var stateNameValue = 'Delhi';
  var cityNameValue = 'North Delhi';
  Validators valid = new Validators();
  BehaviorSubject<String> mailStream = BehaviorSubject<String>();
  BehaviorSubject<String> mobileStream = BehaviorSubject<String>();

  Stream<String> get mail => mailStream.stream.transform(valid.validateEmail);
  Stream<String> get nmobile =>
      mobileStream.stream.transform(valid.validateNumber);
  Stream<bool> get validUpdate =>
      Observable.combineLatest2(mail, nmobile, (mk, mo) => true);
  ManufacturersDao dao = new ManufacturersDao(db);
  String countryId;
  String countryName;
  ProductsDao pdao = new ProductsDao(db);
  File imagePending = null;
  var productsChanged = false;
  var listman;
  List<String> tempMarked = new List<String>();
  Future getCountry() async {
    var dao = CountryDao(db);
    var countries = await dao.getAll();
    return countries.map((x) => {"name": x.name, "value": x.id}).toList();
  }

  @override
  void dispose() {
    mailStream.close();
    mobileStream.close();
    super.dispose();
  }

  void addManufacturer() async {
    print("here");
    await getToken((val) async {
      print(val);
      try {
        var distributorData =
            await ApiService.create().createManufacturers(authKey: val, body: {
          "name": manu.currentState.value,
          "mail": email.currentState.value,
          "mobile": mobile.currentState.getNumberString(),
          "gstin": gstin.currentState.value,
          "address1": address.currentState.value,
          "address2": address2.currentState.value,
          "pinCode": pincode.currentState.value,
          "district": district.currentState.value,
          "areaId": "5dc31e7ab955ba01a75031de",
          "cityId": cityIdValue,
          "stateId": stateIdValue,
          "countryId": countryId
        });
        var distributor = distributorData.body;
        print("DISTRIBUTOR RESPONSE $distributor");
        if (productsChanged) {
          distributorData = await ApiService.create().addProductsToManufacturer(
              authKey: val, id: distributor["id"], body: {"ids": tempMarked});
          distributor = distributorData.body;
        }
        if (imagePending != null) {
          distributor["image"] = imagePending.toString();
          await UploadImage(
              "upload/manufacturers/${distributor["id"]}", imagePending);
        }
        distributor["stateName"] = stateNameValue;
        distributor["cityName"] = cityNameValue;
        distributor["countryName"] = countryName;
        dao.add(ManufacturersDao.fromMap(distributor));
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

  void editManufacturer() async {
    print("here");
    await getToken((val) async {
      print(val);
      try {
        var params = widget.manufacturer.toJson();
        params.remove("products");
        params.addAll({
          "name": manu.currentState.value,
          "mail": email.currentState.value,
          "mobile": mobile.currentState.getNumberString(),
          "gstin": gstin.currentState.value,
          "address1": address.currentState.value,
          "address2": address2.currentState.value,
          "pinCode": pincode.currentState.value,
          "district": district.currentState.value,
          "areaId": "5dc31e7ab955ba01a75031de",
          "cityId": cityIdValue,
          "stateId": stateIdValue,
          "countryId": countryId
        });
        params.remove("image");
        print("PARAMS:$params");
        var distributorData = await ApiService.create().updateManufacturers(
            id: widget.manufacturer.id, authKey: val, body: params);
        var distributor = distributorData.body;
        if (productsChanged) {
          print({
            "authKey": val,
            "id": widget.manufacturer.id,
            "body": {"ids": JSON.jsonDecode(widget.manufacturer.products)}
          });
          distributorData = await ApiService.create().addProductsToManufacturer(
              authKey: val,
              id: widget.manufacturer.id,
              body: {"ids": JSON.jsonDecode(widget.manufacturer.products)});
          distributor = distributorData.body;
        }
        if (imagePending != null) {
          distributor["image"] = imagePending.toString();
          await UploadImage(
              "upload/manufacturers/${widget.manufacturer.id}", imagePending);
        }
        distributor["stateName"] = stateNameValue;
        distributor["cityName"] = cityNameValue;
        distributor["countryName"] = countryName;
        dao.edit(ManufacturersDao.fromMap(distributor));
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

  Future<CountryData> getInitial() async {
    var lss = await getWithCode(int.parse(widget.manufacturer.mobile
        .substring(1, (widget.manufacturer.mobile.length - 10))));
    print("AK47");
    print(lss.toJsonString());
    return lss;
  }

  Future getProducts() async {
    print("SI");
    listman = new List<Map<String, dynamic>>();
    var products = await pdao.getAll();

    for (var i = 0; i < products.length; i++) {
      var y = products[i].toJson();

      if (widget.manufacturer != null) {
        if (JSON.jsonDecode(widget.manufacturer.products).indexOf(y["id"]) !=
            -1) {
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
    if (widget.manufacturer != null) {
      stateIdValue = widget.manufacturer.stateId;
      cityIdValue = widget.manufacturer.cityId;

      stateNameValue = widget.manufacturer.stateName;
      cityNameValue = widget.manufacturer.cityName;
      countryId = widget.manufacturer.countryId;
      countryName = widget.manufacturer.countryName;
      mailStream.sink.add(widget.manufacturer.mail);
      mobileStream.sink.add(widget.manufacturer.mobile
          .substring(widget.manufacturer.mobile.length - 10));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var tablet = isTablet(MediaQuery.of(context));
    var selected = 0;
    List pl;
    var productLength;
    if (widget.manufacturer != null) {
      print("ARRAY${widget.manufacturer.products}");

      var str = widget.manufacturer.products != null
          ? widget.manufacturer.products[0] == '"'
              ? widget.manufacturer.products
                  .substring(1, widget.manufacturer.products.length - 1)
                  .replaceAll("\\", "")
              : widget.manufacturer.products
          : "[]";
      pl = widget.manufacturer.products != null ? JSON.jsonDecode(str) : [];
      productLength = 0;
      if (pl is List) {
        productLength = pl.length;
      } else {
        pl = [];
      }
    }
    Widget _tabNavigator() {
      List<String> options = [
        "Manufacturer Info",
        "Products from Manufacturer"
      ];
      List<Widget> tabs = new List<Widget>();
      var counter = 0;
      options.forEach((x) {
        bool isSelected = counter == selected;
        tabs.add(Expanded(
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
                    fontSize: hp(2),
                    fontWeight: FontWeight.w700,
                  )
                : TextGray(
                    title: x,
                    fontSize: hp(2),
                    fontWeight: FontWeight.w700,
                    opacity: 0.6,
                  ),
          ),
        ));
        counter++;
      });
      return Container(
        color: AppColors.PrimaryWhite,
        height: hp(7),
        child: Row(
          children: tabs,
        ),
      );
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
                    onSuccess: (image) {
                      imagePending = image;
                    },
                    uriImage: widget.manufacturer != null
                        ? widget.manufacturer.image != null
                            ? widget.manufacturer.image
                            : ""
                        : "",
                  ),
                  SizedBox(
                    width: tablet ? hp(2) : wp(3),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      child: TextfieldClassic(
                        key: manu,
                        fontSize: fontSize,
                        paddingBottomInput: hp(1),
                        labelText: "Manufacturer Name",
                        initialValue: widget.manufacturer != null
                            ? widget.manufacturer.name
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: separator,
              ),
              TextfieldClassic(
                key: email,
                paddingBottomInput: hp(1),
                fontSize: fontSize,
                labelText: eptxt('email'),
                initialValue: widget.manufacturer != null
                    ? widget.manufacturer.mail
                    : null,
                stream: mail,
                onChanged: (str) {
                  mailStream.sink.add(str);
                },
              ),
              SizedBox(
                height: separator,
              ),
              widget.manufacturer != null
                  ? widget.manufacturer.mobile != null &&
                          widget.manufacturer.mobile != "" &&
                          widget.manufacturer.mobile.length > 10
                      ? FutureBuilder(
                          future: getInitial(),
                          builder: (context, snapshot) {
                            print("DATA:${snapshot.data}");
                            if (snapshot.hasData) {
                              print("DATASecond:${snapshot.data}");
                              return TextfieldNumber(
                                key: mobile,
                                paddingBottomInput: hp(1),
                                fontSize: fontSize,
                                labelText: eptxt('mobile_number'),
                                alwaysFocus: widget.manufacturer.mobile != null,
                                initialCountry: snapshot.data,
                                initialValue: widget.manufacturer.mobile
                                    .substring(
                                        widget.manufacturer.mobile.length - 10),
                                stream: nmobile,
                                onChanged: (str) {
                                  print("a");
                                  mobileStream.sink.add(str);
                                },
                              );
                            } else {
                              return TextfieldNumber(
                                paddingBottomInput: hp(1),
                                fontSize: fontSize,
                                labelText: eptxt('mobile_number'),
                                alwaysFocus: widget.manufacturer.mobile != null,
                                initialValue: widget.manufacturer.mobile
                                    .substring(
                                        widget.manufacturer.mobile.length - 10),
                                stream: nmobile,
                                onChanged: (str) {
                                  print("b");
                                  mobileStream.sink.add(str);
                                },
                              );
                            }
                          })
                      : TextfieldNumber(
                          key: mobile,
                          paddingBottomInput: hp(1),
                          fontSize: fontSize,
                          labelText: eptxt('mobile_number'),
                          stream: nmobile,
                          onChanged: (str) {
                            print("c");
                            mobileStream.sink.add(str);
                          },
                        )
                  : TextfieldNumber(
                      key: mobile,
                      paddingBottomInput: hp(1),
                      fontSize: fontSize,
                      labelText: eptxt('mobile_number'),
                      stream: nmobile,
                      onChanged: (str) {
                        print("d");
                        mobileStream.sink.add(str);
                      },
                    ),
              SizedBox(
                height: separator,
              ),
              TextfieldClassic(
                key: gstin,
                paddingBottomInput: hp(1),
                fontSize: fontSize,
                labelText: "GSTIN",
                initialValue: widget.manufacturer != null
                    ? widget.manufacturer.gstin
                    : null,
              ),
              SizedBox(
                height: separator,
              ),
              TextfieldClassic(
                key: address,
                paddingBottomInput: hp(1),
                fontSize: fontSize,
                labelText: "Address 1",
                animatedItem: (change) {
                  return Container(
                    padding: EdgeInsets.only(top: hp(0)),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: AppColors.PrimaryBlue, width: 1.5))),
                    child: GestureDetector(
                      onTap: () async {
                        showLoading(context);
                        try {
                          Location loc = await getLocation(context);
                          Navigator.pop(context);
                          print("LOCATION $loc");
                          address.currentState.changeText(loc.addressLine);

                          address2.currentState.changeText(loc.cityWithPostal);
                        } catch (e) {
                          Navigator.pop(context);
                          print("CAGAO ${e.toString()}");
                          showDialogMessage(
                              context,
                              e.toString().indexOf("Exception:") != -1
                                  ? e.toString().replaceAll("Exception: ", "")
                                  : "Unable to fetch location",
                              () {});
                        }
                        /* cityKey.currentState.changeText(loc.adminArea);
                  bloc.changeCity(loc.adminArea); */
                      },
                      child: Text(
                        'Detect Location',
                        style: TextStyle(
                          fontSize: hp(1.9),
                          fontWeight: FontWeight.w700,
                          color: AppColors.PrimaryBlue,
                        ),
                      ),
                    ),
                  );
                },
                initialValue: widget.manufacturer != null
                    ? widget.manufacturer.address1
                    : null,
              ),
              SizedBox(
                height: separator,
              ),
              TextfieldClassic(
                hintText: 'Address 2',
                key: address2,
                paddingBottomInput: hp(1),
                fontSize: fontSize,
                initialValue: widget.manufacturer != null
                    ? widget.manufacturer.address2
                    : null,
              ),
              SizedBox(
                height: separator,
              ),
              TextfieldClassic(
                keyType: TextInputType.number,
                key: pincode,
                paddingBottomInput: hp(1),
                fontSize: fontSize,
                hintText: "Pincode",
                initialValue: widget.manufacturer != null
                    ? widget.manufacturer.pinCode
                    : null,
                onFocusChange: (f) async {
                  if (!f && pincode.currentState.value.length == 6) {
                    showLoading(context);
                    print("BLOC ${pincode.currentState.value}");
                    var res = await ApiService.create()
                        .getPincode(pincode.currentState.value);
                    if (res == null ||
                        res.body == null ||
                        res.body['data'] == null) {
                      Navigator.pop(context);
                    } else {
                      print("MOMENT${res.body["data"][0]["city"]}");
                      var resCity = await ApiService.create()
                          .getCity(res.body["data"][0]["city"]);
                      cityIdValue = res.body["data"][0]["city"];
                      countryId = res.body["data"][0]["country"];
                      country.currentState
                          .changeText(res.body["data"][0]["countryName"]);

                      print("RESCITY${resCity.body}");
                      if (resCity.body["data"] != null) {
                        var resState = await ApiService.create()
                            .getState(resCity.body["data"][0]["state"]);
                        stateIdValue = resCity.body["data"][0]["state"];
                        stateNameValue = resState.body["name"];
                        cityNameValue = resCity.body["data"][0]["name"];
                        print("RESSTATE${resState.body}");
                        city.currentState
                            .changeText(resCity.body["data"][0]["name"]);
                        /* address.currentState
                            .changeText(res.body["data"][0]["name"]); */
                        district.currentState
                            .changeText(res.body["data"][0]["taluka"]);
                        state.currentState.changeText(resState.body["name"]);
                      } else {
                        var resState = await ApiService.create()
                            .getState(resCity.body["state"]);
                        stateIdValue = resCity.body["state"];
                        stateNameValue = resState.body["name"];
                        cityNameValue = resCity.body["name"];
                        print("RESSTATE${resState.body}");
                        city.currentState.changeText(resCity.body["name"]);
                        /* address.currentState
                            .changeText(res.body["data"][0]["name"]); */
                        district.currentState
                            .changeText(res.body["data"][0]["taluka"]);
                        state.currentState.changeText(resState.body["name"]);
                      }
                      Navigator.pop(context);
                    }
                  }
                },
              ),
              SizedBox(
                height: separator,
              ),
              TextfieldClassic(
                key: district,
                disabled: true,
                paddingBottomInput: hp(1),
                fontSize: fontSize,
                hintText: "District",
                initialValue: widget.manufacturer != null
                    ? widget.manufacturer.district
                    : null,
              ),
              SizedBox(
                height: separator,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: TextfieldClassic(
                    key: city,
                    hintText: "City",
                    disabled: true,
                    paddingBottomInput: hp(1),
                    fontSize: fontSize,
                    initialValue: widget.manufacturer != null
                        ? widget.manufacturer.cityName
                        : null,
                  )),
                  Expanded(
                      child: TextfieldClassic(
                    key: state,
                    hintText: "State",
                    disabled: true,
                    paddingBottomInput: hp(1),
                    leftBorder: true,
                    fontSize: fontSize,
                    initialValue: widget.manufacturer != null
                        ? widget.manufacturer.stateName
                        : null,
                  )),
                ],
              ),
              SizedBox(
                height: separator,
              ),
              TextfieldClassic(
                key: country,
                hintText: "Country",
                disabled: true,
                paddingBottomInput: hp(1),
                fontSize: fontSize,
                initialValue: widget.manufacturer != null
                    ? widget.manufacturer.countryName
                    : "",
              )
              /* FutureBuilder(
                  future: getCountry(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      if (countryId == null) {
                        countryId = snapshot.data[0]["value"];
                        print("DEFAULT $countryId");
                      }
                      return TextfieldDropdown(
                        items: snapshot.data,
                        paddingBottomInput: hp(0.8),
                        fontSize: fontSize,
                        labelText: "Country",
                        initValue: widget.manufacturer != null
                            ? widget.manufacturer.countryId
                            : null,
                        onChanged: (id) {
                          countryId = id;
                          print("COUNTRY SELECTED $countryId");
                        },
                      );
                    } else {
                      return Container();
                    }
                  }), */
            ],
          ),
        ),
      );
    }

    Widget _buildAddModule() {
      var isIOS = Platform.isIOS;

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
                        return FutureBuilder(
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
                                                      (BuildContext context, _,
                                                          __) {
                                                    return AddProductDialog(
                                                      storeAction: (data) {
                                                        print("xx");
                                                        if (widget
                                                                .manufacturer !=
                                                            null) {
                                                          var newd = widget
                                                              .manufacturer
                                                              .toJson();
                                                          newd["products"] =
                                                              data;
                                                          setState(() {
                                                            productsChanged =
                                                                true;
                                                            widget.manufacturer =
                                                                ManufacturersDao
                                                                    .fromMap(
                                                                        newd);
                                                          });
                                                        } else {
                                                          setState(() {
                                                            productsChanged =
                                                                true;
                                                            tempMarked = data;
                                                            //  data.map((x) => x.toString()).toList();
                                                          });
                                                        }
                                                        /*dao.edit(DistributorsDao.fromMap(data));
                          
                            widget.distributor = DistributorsDao.fromMap(data);
                          */
                                                      },
                                                      marked: widget
                                                                  .manufacturer !=
                                                              null
                                                          ? pl != null
                                                              ? pl
                                                                  .map((x) => x
                                                                      .toString())
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
                            });
                      }
                    })
                : TextBlue(
                    title: "ADD PRODUCTS FROM MANUFACTURER",
                    fontSize: wp(3.5),
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
                          if (widget.manufacturer != null) {
                            var newd = widget.manufacturer.toJson();
                            newd["products"] = data;
                            setState(() {
                              productsChanged = true;
                              widget.manufacturer =
                                  ManufacturersDao.fromMap(newd);
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
                        marked: widget.manufacturer != null
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
                            "${widget.manufacturer != null ? productLength != null ? productLength : 0 : tempMarked.length} Products Selected",
                      )),
            ),
          ],
        ),
      );
    }

    return EpaisaScaffold(
        appBar: EpaisaAppBar(
          back: true,
          title:
              '${widget.manufacturer != null ? "UPDATE" : "ADD"} MANUFACTURER',
        ),
        body: Column(
          verticalDirection: VerticalDirection.up,
          children: <Widget>[
            Expanded(
              child: tablet
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: SingleChildScrollView(
                              child: Column(children: <Widget>[_buildCard()])),
                        ),
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
                                    child: StreamBuilder<bool>(
                                        stream: validUpdate,
                                        builder: (context, snapshot) {
                                          print("error ${snapshot.hasError}");
                                          return ButtonGradient(
                                            disabled: snapshot.hasError,
                                            callback: () async {
                                              print(
                                                  "error ${snapshot.hasError}");
                                              if (!snapshot.hasError) {
                                                showLoading(context);
                                                if (widget.manufacturer !=
                                                    null) {
                                                  await editManufacturer();
                                                } else {
                                                  await addManufacturer();
                                                }
                                              }
                                              print("out");
                                            },
                                            paddingVertical:
                                                tablet ? hp(2.1) : hp(1.8),
                                            borderRadius: hp(2),
                                            fontSize: hp(1.7),
                                            title:
                                                "${widget.manufacturer != null ? "UPDATE" : "ADD"} MANUFACTURER",
                                          );
                                        }),
                                  )
                                ],
                              )
                            ]))
                      ],
                    )
                  : Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: tablet
                                          ? EdgeInsets.only(top: hp(1))
                                          : EdgeInsets.all(0),
                                      child: tablet
                                          ? Row(
                                              children: <Widget>[
                                                Expanded(
                                                    child: Column(
                                                        children: <Widget>[
                                                      _buildCard()
                                                    ])),
                                                Expanded(
                                                    child: Column(
                                                        children: <Widget>[
                                                      _buildAddModule()
                                                    ]))
                                              ],
                                            )
                                          : Column(
                                              children: <Widget>[
                                                _buildCard(),
                                                _buildAddModule()
                                              ],
                                            ),
                                    ),
                                    SizedBox(
                                      height: hp(2),
                                    ),
                                    Container(
                                      height: hp(8),
                                      width: wp(98),
                                      //top: widget.isIOS ? hp(78) : hp(80),
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(
                                            hp(1), 0, 0, hp(2)),
                                        child: StreamBuilder<bool>(
                                            stream: validUpdate,
                                            builder: (context, snapshot) {
                                              print(
                                                  "error ${snapshot.hasError}");
                                              return ButtonGradient(
                                                disabled: snapshot.hasError,
                                                callback: () async {
                                                  print(
                                                      "error ${snapshot.hasError}");
                                                  if (!snapshot.hasError) {
                                                    showLoading(context);
                                                    if (widget.manufacturer !=
                                                        null) {
                                                      await editManufacturer();
                                                    } else {
                                                      await addManufacturer();
                                                    }
                                                  }
                                                  print("out");
                                                },
                                                paddingVertical:
                                                    tablet ? hp(2.1) : hp(1.8),
                                                borderRadius: hp(2),
                                                fontSize: hp(1.7),
                                                title:
                                                    "${widget.manufacturer != null ? "UPDATE" : "ADD"} MANUFACTURER",
                                              );
                                            }),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
            if (tablet)
              SizedBox(
                height: hp(1),
              ),
            if (tablet) _tabNavigator(),
          ],
        ) //ListView(children: <Widget>[],)
        );
  }
}
