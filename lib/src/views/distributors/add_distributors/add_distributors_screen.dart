import 'dart:convert';

import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/data/initial/countries/api_service.dart';
import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:epaisa_pos/data/models/country_dao.dart';
import 'package:epaisa_pos/data/models/distributors_dao.dart';
import 'package:epaisa_pos/data/models/products_dao.dart';
import 'package:epaisa_pos/src/bloc/location_bloc.dart';
import 'package:epaisa_pos/src/models/Location.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/countries.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/validators/Validator.dart';
import 'package:epaisa_pos/src/views/categories/add_categories/widgets/item_add.dart';
import 'package:epaisa_pos/src/views/point_of_sale/widgets/grid_list_pin.dart';
import 'package:epaisa_pos/src/views/transactions/transactions_screen.dart';
import 'package:epaisa_pos/src/widgets/utils/dialogs_helper.dart';
import 'package:epaisa_pos/src/widgets/utils/image_helper.dart';
import 'package:epaisa_pos/src/widgets/utils/request_helper.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import './widgets/item_product.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_camera.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/cards/arrow_card.dart';
import 'package:epaisa_pos/src/widgets/textfields/texfield_number.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_dropdown.dart';
import 'package:epaisa_pos/src/widgets/texts/text_blue.dart';
import 'package:epaisa_pos/src/widgets/texts/text_gray.dart';
import 'package:flutter/material.dart';
import 'package:epaisa_pos/src/views/packages/add_packages/widgets/add_product_dialog.dart';
import 'dart:io';

class AddDistributorsScreen extends StatefulWidget {
  Distributor distributor;
  AddDistributorsScreen({this.distributor});
  @override
  _AddDistributorsScreenState createState() => _AddDistributorsScreenState();
}

class _AddDistributorsScreenState extends State<AddDistributorsScreen> {
  Validators valid = new Validators();
  GlobalKey<TextfieldClassicState> dist =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> fname =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> lname =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> email =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldNumberState> mobile =
      new GlobalKey<TextfieldNumberState>();
  GlobalKey<TextfieldClassicState> gstin =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> since =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> address =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> address2 =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> pincode =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> city =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> state =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> district =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> country =
      new GlobalKey<TextfieldClassicState>();
  var stateIdValue = '5dc31e76b955ba01a75022cb';
  var cityIdValue = '5dc31e76b955ba01a75022cb';
  var stateNameValue = 'Delhi';
  var cityNameValue = 'North Delhi';
  BehaviorSubject<String> mailStream = BehaviorSubject<String>();
  BehaviorSubject<String> mobileStream = BehaviorSubject<String>();
  BehaviorSubject<String> cityId = BehaviorSubject<String>();
  String countryId;
  Stream<String> get mail => mailStream.stream.transform(valid.validateEmail);
  Stream<String> get nmobile =>
      mobileStream.stream.transform(valid.validateNumber);
  Stream<bool> get validUpdate =>
      Observable.combineLatest2(mail, nmobile, (mk, mo) => true);
  DistributorsDao dao = new DistributorsDao(db);
  ProductsDao pdao = new ProductsDao(db);
  Distributor cdistributor;
  File imagePending = null;
  var productsChanged = false;
  var listman;
  List<String> tempMarked = new List<String>();
  Future getCountry() async {
    var dao = CountryDao(db);
    var countries = await dao.getAll();
    return countries.map((x) => {"name": x.name, "value": x.id}).toList();
  }

  void addDistributor() async {
    print("here");
    await getToken((val) async {
      print(val);
      try {
        var parameters = {
          "name": dist.currentState.value,
          "firstName": fname.currentState.value,
          "lastName": lname.currentState.value,
          "mail": email.currentState.value,
          "mobile": mobile.currentState.value.length == 10
              ? mobile.currentState.getNumberString()
              : "",
          "gstin": gstin.currentState.value,
          "since": since.currentState.value,
          "address1": address.currentState.value,
          "address2": address2.currentState.value,
          "pinCode": pincode.currentState.value,
          "district": district.currentState.value,
          "areaId": "5dc31e7ab955ba01a75031de",
          "cityId": cityIdValue,
          "stateId": stateIdValue,
          "countryId": countryId
        };
        print("PARAMS HERE: $parameters");
        var distributorData = await ApiService.create()
            .createDistributor(authKey: val, body: parameters);
        var distributor = distributorData.body;
        if (productsChanged) {
          distributorData = await ApiService.create().addProductsToDistributor(
              authKey: val, id: distributor["id"], body: {"ids": tempMarked});
          distributor = distributorData.body;
        }
        if (imagePending != null) {
          distributor["image"] = imagePending.toString();
          await UploadImage(
              "upload/distributors/${distributor["id"]}", imagePending);
        }
        distributor["stateName"] = stateNameValue;
        distributor["cityName"] = cityNameValue;
        distributor["countryName"] = country.currentState.value;
        dao.add(DistributorsDao.fromMap(distributor));
        Navigator.pop(context);
        Navigator.pop(context);
      } catch (e) {
        print(e);
        if (e.body != null) {
          print(e.body);

          Navigator.pop(context);
          showDialogMessage(
              context, json.decode(e.body)["message"] ?? "Error", () {});
        } else {
          Navigator.pop(context);
        }
      }
    });
  }

  void initState() {
    if (widget.distributor != null) {
      cdistributor = widget.distributor;
      if (widget.distributor != null) {
        stateIdValue = widget.distributor.stateId;
        cityIdValue = widget.distributor.cityId;
        stateNameValue = widget.distributor.stateName;
        cityNameValue = widget.distributor.cityName;
        countryId = widget.distributor.countryId;
        mailStream.sink.add(widget.distributor.mail);
        mobileStream.sink.add(widget.distributor.mobile
            .substring(widget.distributor.mobile.length - 10));
      }
      List pl;
      var productLength;
      if (widget.distributor != null) {
        pl = widget.distributor.products != null
            ? json.decode(widget.distributor.products)
            : [];
        productLength = 0;
        if (pl is List) {
          productLength = pl.length;
        } else {
          pl = [];
        }
      }
      tempMarked = pl.map((x) => x.toString()).toList();
      print("DIST ${widget.distributor.toJson()}");
    }
    super.initState();
  }

  Future<CountryData> getInitial() async {
    var lss = await getWithCode(int.parse(widget.distributor.mobile
        .substring(1, (widget.distributor.mobile.length - 10))));
    print("AK47");
    print(lss.toJsonString());
    return lss;
  }

  void editDistributor() async {
    print("here");
    await getToken((val) async {
      print(val);
      try {
        var params = widget.distributor.toJson();
        //params["name"] = nameKey.currentState.value;

        params.remove("products");
        params.addAll({
          "name": dist.currentState.value,
          "firstName": fname.currentState.value,
          "lastName": lname.currentState.value,
          "mail": email.currentState.value,
          "mobile": mobile.currentState.getNumberString(),
          "gstin": gstin.currentState.value,
          "address1": address.currentState.value,
          "address2": address2.currentState.value,
          "pinCode": pincode.currentState.value,
          "since": since.currentState.value,
          "district": district.currentState.value,
          "areaId": "5dc31e7ab955ba01a75031de",
          "cityId": cityIdValue,
          "stateId": stateIdValue,
          "countryId": countryId
        });
        params.remove("image");
        print("PARAMS:$params");
        var distributorData = await ApiService.create().updateDistributor(
            id: widget.distributor.id, authKey: val, body: params);
        var distributor = distributorData.body;
        //if (productsChanged) {
        distributorData = await ApiService.create().addProductsToDistributor(
            authKey: val, id: widget.distributor.id, body: {"ids": tempMarked});
        distributor = distributorData.body;
        //}
        if (imagePending != null) {
          distributor["image"] = imagePending.toString();
          print("IMAGEADDED ${imagePending.toString()}");
          await UploadImage(
              "upload/distributors/${widget.distributor.id}", imagePending);
        }
        distributor["stateName"] = stateNameValue;
        distributor["cityName"] = cityNameValue;
        distributor["countryName"] = country.currentState.value;
        dao.edit(DistributorsDao.fromMap(distributor));
        /*if (parentKey.currentState.getValue()["value"] != 0) {
          var cat = await dao.getOne(parentKey.currentState.getValue()["id"]);
          var temp = cat.toJson();
          temp["children"] = category.body["id"];
          dao.edit(CategoriesDao.fromMap(temp));
        }else{

        }*/

        Navigator.pop(context);
        Navigator.pop(context);
      } catch (e) {
        print(e);
        if (e.body != null) {
          print(e.body);

          Navigator.pop(context);
          showDialogMessage(
              context, json.decode(e.body)["message"] ?? "Error", () {});
        } else {
          Navigator.pop(context);
        }
      }
    });
  }

  Future getProducts() async {
    print("BRAVODEDO");
    var listProd = new List<Map<String, dynamic>>();
    var products = await pdao.getAll();
    for (var i = 0; i < products.length; i++) {
      var y = products[i].toJson();

      if (tempMarked.indexOf(y["id"]) != -1) {
        y["text"] = y["name"];
        y["color"] = AppColors.PrimaryBlue;
        y["count"] = 0;
        y["id"] = y["id"];
        listProd.add(y);
      }
    }

    listProd.add({"text": "Add"});
    print("LISTA PRODUCTOS $listProd");
    return listProd;
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    var selected = 0;
    List pl;
    var productLength;
    if (widget.distributor != null) {
      pl = widget.distributor.products != null
          ? json.decode(widget.distributor.products)
          : [];
      productLength = 0;
      if (pl is List) {
        productLength = pl.length;
      } else {
        pl = [];
      }
    }
    Widget _tabNavigator() {
      List<String> options = ["Distributor Info", "Products from Distributor"];
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
      double fontSize = tablet ? hp(2.4) : wp(4.3);
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
                    uriImage: widget.distributor != null
                        ? widget.distributor.image != null
                            ? widget.distributor.image
                            : null
                        : "",
                  ),
                  SizedBox(
                    width: tablet ? hp(2) : wp(3),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      child: TextfieldClassic(
                        key: dist,
                        fontSize: fontSize,
                        paddingBottomInput: hp(1),
                        initialValue: widget.distributor != null
                            ? widget.distributor.name != ""
                                ? widget.distributor.name
                                : null
                            : null,
                        labelText: "Distributor Name",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: separator,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: TextfieldClassic(
                    key: fname,
                    paddingBottomInput: hp(1),
                    fontSize: fontSize,
                    initialValue: widget.distributor != null
                        ? widget.distributor.firstName != ""
                            ? widget.distributor.firstName
                            : null
                        : null,
                    labelText: "First Name",
                  )),
                  Expanded(
                      child: TextfieldClassic(
                    key: lname,
                    leftBorder: true,
                    paddingBottomInput: hp(1),
                    fontSize: fontSize,
                    initialValue: widget.distributor != null
                        ? widget.distributor.lastName != ""
                            ? widget.distributor.lastName
                            : null
                        : null,
                    labelText: "Last Name",
                  )),
                ],
              ),
              TextfieldClassic(
                key: email,
                paddingBottomInput: hp(1),
                fontSize: fontSize,
                labelText: eptxt('email'),
                initialValue: widget.distributor != null
                    ? widget.distributor.mail != ""
                        ? widget.distributor.mail
                        : null
                    : null,
                stream: mail,
                onChanged: (str) {
                  mailStream.sink.add(str);
                },
              ),
              SizedBox(
                height: separator,
              ),
              widget.distributor != null
                  ? widget.distributor.mobile != null &&
                          widget.distributor.mobile != "" &&
                          widget.distributor.mobile.length > 10
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
                                alwaysFocus: widget.distributor.mobile != null,
                                initialCountry: snapshot.data,
                                initialValue: widget.distributor.mobile
                                    .substring(
                                        widget.distributor.mobile.length - 10),
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
                                alwaysFocus: widget.distributor.mobile != null,
                                initialValue: widget.distributor.mobile
                                    .substring(
                                        widget.distributor.mobile.length - 10),
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
                key: since,
                disabled: true,
                onTap: () async {
                  final DateTime picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1955),
                      lastDate: DateTime(2020),
                      footerBuilder: datePickerFooter,
                      width: tablet ? wp(45) : wp(80),
                      headerBuilder: datePickerHeader,
                      builder: (ct, child) {
                        return child;
                      });
                  if (picked != null) {
                    print("caca");
                    since.currentState
                        .changeText(DateFormat.yMd().format(picked));
                  }
                },
                paddingBottomInput: hp(1),
                fontSize: fontSize,
                labelText: "Distributor Since",
                initialValue: widget.distributor != null
                    ? widget.distributor.since != ""
                        ? widget.distributor.since
                        : null
                    : null,
                /*initialValue: widget.distributor != null
                    ? widget.distributor.gstin != ""
                        ? widget.distributor.gstin
                        : null
                    : null,*/
              ),
              SizedBox(
                height: separator,
              ),
              TextfieldClassic(
                key: gstin,
                paddingBottomInput: hp(1),
                fontSize: fontSize,
                labelText: "GSTIN",
                initialValue: widget.distributor != null
                    ? widget.distributor.gstin != ""
                        ? widget.distributor.gstin
                        : null
                    : null,
              ),
              SizedBox(
                height: separator,
              ),
              TextfieldClassic(
                key: address,
                paddingBottomInput: hp(1),
                fontSize: fontSize,
                labelText: "Address",
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
                initialValue: widget.distributor != null
                    ? widget.distributor.address1 != ""
                        ? widget.distributor.address1
                        : null
                    : null,
              ),
              SizedBox(
                height: separator,
              ),
              TextfieldClassic(
                key: address2,
                hintText: "Address 2",
                paddingBottomInput: hp(1),
                fontSize: fontSize,
                initialValue: widget.distributor != null
                    ? widget.distributor.address2 != ""
                        ? widget.distributor.address2
                        : null
                    : null,
              ),
              SizedBox(
                height: separator,
              ),
              TextfieldClassic(
                key: pincode,
                paddingBottomInput: hp(1),
                fontSize: fontSize,
                hintText: "Pincode",
                initialValue: widget.distributor != null
                    ? widget.distributor.pinCode != ""
                        ? widget.distributor.pinCode
                        : null
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
                        print("RESSTATE${resState.body}");
                        city.currentState.changeText(resCity.body["name"]);
                        stateNameValue = resState.body["name"];
                        cityNameValue = resCity.body["name"];
                        /* address.currentState
                            .changeText(res.body["data"][0]["name"]); */
                        district.currentState
                            .changeText(res.body["data"][0]["taluka"]);
                        state.currentState.changeText(resState.body["name"]);
                        stateIdValue = resCity.body["state"];
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
                initialValue: widget.distributor != null
                    ? widget.distributor.district != ""
                        ? widget.distributor.district
                        : null
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
                    disabled: true,
                    paddingBottomInput: hp(1),
                    fontSize: fontSize,
                    hintText: "City",
                    initialValue: widget.distributor != null
                        ? widget.distributor.cityName != ""
                            ? widget.distributor.cityName
                            : null
                        : null,
                  )),
                  Expanded(
                      child: TextfieldClassic(
                    key: state,
                    disabled: true,
                    paddingBottomInput: hp(1),
                    leftBorder: true,
                    hintText: "State",
                    fontSize: fontSize,
                    initialValue: widget.distributor != null
                        ? widget.distributor.stateName != ""
                            ? widget.distributor.stateName
                            : null
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
                initialValue: widget.distributor != null
                    ? widget.distributor.countryName
                    : "",
              )
            ],
          ),
        ),
      );
    }

    Widget _buildAddModule() {
      var isIOS = Platform.isIOS;

      return Container(
        padding: EdgeInsets.only(
            right: tablet ? wp(1) : 0, bottom: tablet ? hp(4) : 0),
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
                                                print("DATAPRODUCT$data");

                                                setState(() {
                                                  productsChanged = true;
                                                  tempMarked = data;
                                                  //  data.map((x) => x.toString()).toList();
                                                });

                                                /*dao.edit(DistributorsDao.fromMap(data));
                          
                            widget.distributor = DistributorsDao.fromMap(data);
                          */
                                              },
                                              marked: tempMarked,
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
                        return Expanded(
                          child: Container(),
                        );
                      }
                    },
                  )
                : TextBlue(
                    title: "ADD PRODUCTS FROM DISTRIBUTOR",
                    fontSize: hp(2),
                    fontWeight: FontWeight.w700,
                  ),
            tablet
                ? Container()
                : SizedBox(
                    height: hp(0.5),
                  ),
            if (!tablet)
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(new PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (BuildContext context, _, __) {
                        return AddProductDialog(
                          storeAction: (data) {
                            print("DATA${data.runtimeType}");
                            if (widget.distributor != null) {
                              var newd = widget.distributor.toJson();
                              newd["products"] = data;
                              setState(() {
                                productsChanged = true;
                                widget.distributor =
                                    DistributorsDao.fromMap(newd);
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
                          marked: widget.distributor != null
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
                              "${widget.distributor != null ? productLength != null ? productLength : 0 : tempMarked.length} Products Selected",
                        )),
              ),
            tablet
                ? Container()
                : SizedBox(
                    height: hp(0.5),
                  ),
            //tablet ? Spacer(flex: 1) : Container(),
            Container(
              padding: EdgeInsets.fromLTRB(hp(1), 0, hp(1), hp(0)),
              child: StreamBuilder<bool>(
                  stream: validUpdate,
                  builder: (context, snapshot) {
                    print("error ${snapshot.hasError}");
                    return ButtonGradient(
                      disabled: snapshot.hasError,
                      callback: () async {
                        if (!snapshot.hasError) {
                          showLoading(context);

                          if (widget.distributor != null) {
                            await editDistributor();
                          } else {
                            await addDistributor();
                          }
                        }
                      },
                      paddingVertical: tablet ? hp(2.1) : hp(1.8),
                      borderRadius: hp(2),
                      fontSize: hp(1.7),
                      title:
                          "${widget.distributor != null ? "UPDATE" : "ADD"} DISTRIBUTOR",
                    );
                  }),
            ),
          ],
        ),
      );
    }

    return EpaisaScaffold(
        appBar: EpaisaAppBar(
            back: true,
            title:
                "${widget.distributor != null ? "UPDATE" : "ADD"} DISTRIBUTOR"),
        body: Column(
          children: <Widget>[
            if (tablet) _tabNavigator(),
            Expanded(
                child: Container(
              padding: EdgeInsets.only(top: tablet ? hp(2) : hp(0.5)),
              child: tablet
                  ? Row(
                      children: <Widget>[
                        Expanded(
                            child: SingleChildScrollView(
                                child: Column(children: <Widget>[
                          _buildCard(),
                        ]))),
                        Expanded(child: Container(child: _buildAddModule()))
                      ],
                    )
                  : SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: hp(2)),
                      child: Column(
                        children: <Widget>[_buildCard(), _buildAddModule()],
                      )),
            )),
          ],
        ) //ListView(children: <Widget>[],)
        );
  }
}
