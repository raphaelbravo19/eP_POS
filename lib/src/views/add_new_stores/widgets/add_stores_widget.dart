import 'dart:convert';

import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/data/initial/countries/api_service.dart';
import 'package:epaisa_pos/data/models/country_dao.dart';
import 'package:epaisa_pos/data/models/currencys_dao.dart';
import 'package:epaisa_pos/data/models/currentcompanys_dao.dart';
import 'package:epaisa_pos/data/models/currentmerchants_dao.dart';
import 'package:epaisa_pos/data/models/currentstores_dao.dart';
import 'package:epaisa_pos/src/logic/personal_bloc/personal_bloc.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/validators/Validator.dart';
import 'package:epaisa_pos/src/models/Location.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/cards/toggle_card.dart';
import 'package:epaisa_pos/src/widgets/dialogs/dialog_classic.dart';
import 'package:epaisa_pos/src/widgets/header_card/header_widget.dart';
import 'package:epaisa_pos/src/views/employee/widgets/row_structure.dart';
import 'package:epaisa_pos/src/widgets/textfields/texfield_number.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_dropdown.dart';
import 'package:epaisa_pos/src/widgets/utils/dialogs_helper.dart';
import 'package:epaisa_pos/src/widgets/utils/request_helper.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:epaisa_pos/src/bloc/bloc.dart';

class AddStoreWidget extends StatefulWidget {
  final Function onBack;
  CurrentStore store;
  AddStoreWidget({Key key, this.onBack, this.store}) : super(key: key);
  @override
  AddStoreWidgetState createState() => AddStoreWidgetState();
}

class AddStoreWidgetState extends State<AddStoreWidget> {
  final locationBloc = LocationBloc();

  AddStoreBloc bloc = AddStoreBloc();
  CurrentCompanysDao companyDao = CurrentCompanysDao(db);
  GlobalKey<TextfieldClassicState> cityKey = GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> stateKey =
      GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> districtKey =
      GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> countryKey =
      GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> addressKey =
      GlobalKey<TextfieldClassicState>();

  GlobalKey<TextfieldClassicState> address2Key =
      GlobalKey<TextfieldClassicState>();

  void create({callback}) async {
    await bloc.createStore(context, widget.onBack, callback);
  }

  void update({callback}) async {
    await bloc.updateStore(context, widget.onBack, callback, widget.store);
  }

  @override
  void initState() {
    if (widget.store != null) {
      bloc.changeStore(widget.store.name);
      bloc.changeCompany(widget.store.companyId);
      bloc.changeAddress1(widget.store.address1);
      bloc.changeAddress2(widget.store.address2);
      bloc.changePincode(widget.store.pinCode);
      bloc.changeCity(widget.store.cityId);
      bloc.changeState(widget.store.stateId);
      bloc.changeCountry(widget.store.countryId);
      bloc.changeCityName(widget.store.cityName);
      bloc.changeStateName(widget.store.stateName);
      bloc.changeCountryName(widget.store.countryName);
      bloc.changeDistrict(widget.store.district);
      //bloc.changeCity(widget.store.city);
      bloc.changeLanguage(widget.store.language);
      bloc.changeCurrency(widget.store.currency);
    }
    super.initState();
  }

  Future getData() async {
    var list = await companyDao.getAll();
    return list.map((item) => {"name": item.name, "value": item.id}).toList();
  }

  Future getCurrencys() async {
    var dao = CurrencysDao(db);
    var currencys = await dao.getAll();
    return currencys.map((x) => {"name": x.name, "value": x.id}).toList();
  }

  GlobalKey<DialogClassicState> dialog = new GlobalKey<DialogClassicState>();
  showConfirm({callback}) {
    Navigator.of(context).push(new PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return DialogClassic(
            key: dialog,
            content: () {
              return Container(
                  padding: EdgeInsets.symmetric(
                      vertical: tablet ? hp(2.5) : hp(2.2),
                      horizontal: tablet ? hp(3) : wp(5)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(hp(1)),
                      border: Border.all(color: AppColors.PrimaryWhite),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.Black.withOpacity(0.4),
                          offset: new Offset(3, 3),
                          blurRadius: 6,
                        )
                      ],
                      color: AppColors.PrimaryWhite),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Confirm",
                        style: TextStyle(
                            fontSize: tablet ? hp(3.6) : wp(5.5),
                            color: AppColors.DarkGray,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: hp(.5),
                      ),
                      Text(
                        "Are you sure you want to save the store?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: tablet ? hp(2.6) : wp(3.5),
                            color: AppColors.DarkGray,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: hp(3.5),
                      ),
                      Container(
                        width: tablet ? hp(45) : wp(55),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: ButtonGradient(
                              callback: () async {
                                dialog.currentState.closeModal();
                                if (widget.store != null) {
                                  update(callback: callback);
                                } else
                                  create(callback: callback);
                              },
                              shadowLevel: 1.5,
                              title: "YES",
                              borderRadius: hp(3),
                              paddingVertical: hp(1.7),
                              fontSize: tablet ? hp(3) : wp(3.5),
                            )),
                            SizedBox(
                              width: wp(2),
                            ),
                            Expanded(
                                child: ButtonGradient(
                              callback: () {
                                dialog.currentState.closeModal();
                                widget.onBack();
                                if (callback != null) {
                                  callback();
                                }
                              },
                              shadowLevel: 1.5,
                              title: "NO",
                              borderRadius: hp(3),
                              paddingVertical: hp(1.7),
                              fontSize: tablet ? hp(3) : wp(3.5),
                            ))
                          ],
                        ),
                      )
                    ],
                  ));
            });
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    //final personlBloc = PersonalBloc();
    final bool tablet = isTablet(MediaQuery.of(context));
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    double fontSize = tablet ? hp(2.8) : hp(2.00);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var layoutwidth = tablet ? height * 0.55 : width * 0.85;
    var layoutHeight = tablet ? height : height * 0.8;

    Widget preFixSeriesWidget() {
      return RowStructure(
        imagePath: 'assets/my_account/Invoice.png',
        child: Row(
          children: <Widget>[
            Expanded(
                child: TextfieldClassic(
              paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
              fontSize: tablet ? hp(2.7) : hp(2.1),
              labelText: "Prefix",
              onChanged: (str) {
                bloc.changeInvoicePrefix(str);
              },
            )),
            Expanded(
                child: TextfieldClassic(
              leftBorder: true,
              paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
              fontSize: tablet ? hp(2.7) : hp(2.1),
              labelText: "Series Start",
              onChanged: (str) {
                bloc.changeInvoiceStart(str);
              },
            )),
          ],
        ),
      );
    }

    Widget businessName() {
      return RowStructure(
        imagePath: 'assets/my_account/Business.png',
        child: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                if (bloc.companyStream.value == null) {
                  bloc.changeCompany(snapshot.data[0]["value"]);
                  print("CHANGED");
                }
                print("BUSINESS: ${bloc.companyStream.value}");
                return TextfieldDropdown(
                  items: snapshot.data,
                  paddingBottomInput: hp(0.8),
                  fontSize: fontSize,
                  labelText: "Business Name",
                  onChanged: (str) {
                    print(str);
                    bloc.changeCompany(str);
                  },
                );
              } else {
                return TextfieldDropdown(
                  items: [
                    {"name": "Item Example", "value": "0"}
                  ],
                  paddingBottomInput: hp(0.8),
                  fontSize: fontSize,
                  labelText: "Business Name",
                  //initValue: widget.company.industryId,
                );
              }
            },
            future: getData()),
      );
    }

    Widget storeName() {
      return RowStructure(
        imagePath: 'assets/my_account/Store.png',
        child: TextfieldClassic(
          fontSize: tablet ? hp(2.7) : hp(2.1),
          paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
          labelText: "Store Name",
          initialValue: bloc.storeStream.value,
          onChanged: (str) {
            bloc.changeStore(str);
          },
        ),
      );
    }

    Future loading() {
      return Future.delayed(
          Duration.zero,
          () => showDialog(
              context: context,
              child: Container(
                color: Colors.transparent,
                child: Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )),
              )));
    }

    Widget address1() {
      // return StreamBuilder<bool>(
      //     stream: personlBloc.loadingAddressStream,
      //     builder: (context, snapshotLoading) {
      //       if (snapshotLoading.data == false) {
      //         print("snapshotLoading address called");
      //         Navigator.pop(context);
      //         personlBloc.loadingAddressSink.add(true);
      //       }
      return RowStructure(
        imagePath: 'assets/employee/Address.png',
        child: TextfieldClassic(
          key: addressKey,
          fontSize: tablet ? hp(2.7) : hp(2.1),
          paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
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
                    addressKey.currentState.changeText(loc.addressLine);
                    bloc.changeAddress1(loc.addressLine);
                    address2Key.currentState.changeText(loc.cityWithPostal);
                    bloc.changeAddress2(loc.cityWithPostal);
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
          onChanged: (str) {
            bloc.changeAddress1(str);
          },
          initialValue: bloc.address1Stream.value,
          //onChanged: personlBloc.personAddressSink,
          //stream: personlBloc.personAddressStream,
        ),
      );
      // });
    }

    Widget address2() {
      return RowStructure(
        imagePath: '',
        child: TextfieldClassic(
          key: address2Key,
          fontSize: tablet ? hp(2.7) : hp(2.1),
          paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
          hintText: "Address 2",
          initialValue: bloc.address2Stream.value,
          onChanged: (str) {
            bloc.changeAddress2(str);
          },
          //onChanged: personlBloc.personAddress2Sink,
          //stream: personlBloc.personAddress2Stream,
        ),
      );
    }

    Widget cityState() {
      return RowStructure(
          imagePath: '',
          child: Row(
            children: <Widget>[
              Expanded(
                  child: TextfieldClassic(
                key: cityKey,
                stream: bloc.cityStream,
                paddingBottomInput: hp(1),
                fontSize: fontSize,
                hintText: "City",
                initialValue: bloc.cityNameStream.value,
              )),
              Expanded(
                  child: TextfieldClassic(
                key: stateKey,
                stream: bloc.stateStream,
                leftBorder: true,
                paddingBottomInput: hp(1),
                fontSize: fontSize,
                initialValue: bloc.stateNameStream.value,
                hintText: "State",
              ))
            ],
          ));
    }

    Widget pinCode() {
      return RowStructure(
        imagePath: '',
        child: TextfieldClassic(
          stream: bloc.pincodeStream,
          fontSize: tablet ? hp(2.7) : hp(2.1),
          paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
          alwaysFocus: true,
          hintText: "Pincode",
          initialValue: bloc.pincodeStream.value,
          onFocusChange: (f) async {
            if (!f && bloc.pincodeStream.value.length == 6) {
              showLoading(context);
              print("BLOC ${bloc.pincodeStream.value}");
              var res = await ApiService.create()
                  .getPincode(bloc.pincodeStream.value);
              if (res == null || res.body == null || res.body['data'] == null) {
                Navigator.pop(context);
              } else {
                print("MOMENT${res.body["data"][0]["city"]}");
                var resCity = await ApiService.create()
                    .getCity(res.body["data"][0]["city"]);
                bloc.changeCity(res.body["data"][0]["city"]);
                bloc.changeCountry(res.body["data"][0]["country"]);
                bloc.changeCountryName(res.body["data"][0]["countryName"]);
                countryKey.currentState
                    .changeText(res.body["data"][0]["countryName"]);
                print("RESCITY${resCity.body}");
                if (resCity.body["data"] != null) {
                  var resState = await ApiService.create()
                      .getState(resCity.body["data"][0]["state"]);
                  bloc.changeState(resCity.body["data"][0]["state"]);
                  print("RESSTATE${resState.body}");
                  bloc.changeCityName(resCity.body["data"][0]["name"]);
                  cityKey.currentState
                      .changeText(resCity.body["data"][0]["name"]);
                  bloc.changeDistrict(res.body["data"][0]["taluka"]);
                  districtKey.currentState
                      .changeText(res.body["data"][0]["taluka"]);
                  bloc.changeStateName(resState.body["name"]);
                  stateKey.currentState.changeText(resState.body["name"]);
                } else {
                  var resState =
                      await ApiService.create().getState(resCity.body["state"]);
                  bloc.changeState(resCity.body["state"]);
                  print("RESSTATE${resState.body}");
                  bloc.changeCityName(resCity.body["name"]);
                  cityKey.currentState.changeText(resCity.body["name"]);
                  districtKey.currentState
                      .changeText(res.body["data"][0]["taluka"]);
                  bloc.changeDistrict(res.body["data"][0]["taluka"]);
                  bloc.changeStateName(resState.body["name"]);
                  stateKey.currentState.changeText(resState.body["name"]);
                }
                Navigator.pop(context);
              }
            }
          },
          onChanged: (str) {
            bloc.changePincode(str);
            print("CHANGE CHANGE CHANGE ${bloc.pincodeStream.value}");
            //bloc.changeCity(str);
          },
        ),
      );
    }

    Future getCountries() async {
      CountryDao dao = CountryDao(db);
      var countries = await dao.getAll();
      var res = countries.map((f) => {"name": f.name, "value": f.id}).toList();
      return res;
    }

    Widget country() {
      return RowStructure(
          imagePath: 'assets/employee/Country.png',
          extraShadow: true,
          child: TextfieldClassic(
            key: countryKey,
            disabled: true,

            //stream: bloc.countryStream,
            labelText: "Country",
            paddingBottomInput: hp(1),
            fontSize: fontSize,
            initialValue: bloc.countryNameStream.value,
          ));
    }

    Widget district() {
      return RowStructure(
          imagePath: '',
          child: TextfieldClassic(
            key: districtKey,
            disabled: true,

            //stream: bloc.countryStream,
            hintText: "District",
            paddingBottomInput: hp(1),
            fontSize: fontSize,
            initialValue: bloc.districtStream.value,
          ));
    }

    Widget language() {
      return RowStructure(
        imagePath: 'assets/my_account/Language.png',
        child: TextfieldDropdown(
          items: [
            {"name": "English", "value": "0"},
            {"name": "Español", "value": "1"},
          ],
          paddingBottomInput: hp(0.8),
          fontSize: fontSize,
          labelText: "Language",
          onChanged: (str) {
            bloc.changeLanguage(str);
          },
        ),
      );
    }

    Widget currency() {
      return RowStructure(
        imagePath: 'assets/my_account/Currency.png',
        child: FutureBuilder(
            future: getCurrencys(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                if (bloc.currencyStream.value == null &&
                    snapshot.data.length > 0) {
                  bloc.changeCurrency(snapshot.data[0]["value"]);
                }
                return TextfieldDropdown(
                  items: snapshot.data,
                  paddingBottomInput: hp(0.8),
                  fontSize: fontSize,
                  //initValue: widget.bloc.currencyStream.value,
                  initValue: bloc.currencyStream.value,
                  labelText: "Currency",
                  onChanged: (val) {
                    bloc.changeCurrency(val);
                  },
                );
              } else {
                return Container();
              }
            }),
      );
    }

    Widget invoice() {
      return Container(
        padding: EdgeInsets.only(top: hp(1)),
        child: Text(
          "INVOICE",
          style: TextStyle(
            color: AppColors.PrimaryBlue,
            fontSize: tablet ? hp(2.6) : wp(4.5),
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    Widget customInvoice() {
      return Padding(
        padding: EdgeInsets.only(
          left: tablet ? wp(2) : wp(4),
          right: wp(3),
          top: tablet ? hp(1) : wp(1),
          bottom: tablet ? hp(1) : wp(1),
        ),
        child: ToggleCard(
          fontSize: tablet ? hp(2.2) : wp(4.5),
          paddingHorizontal: tablet ? hp(2) : wp(3),
          paddingVertical: tablet ? hp(2.2) : wp(3),
          spaceBeforeDesc: tablet ? hp(3) : wp(3),
          description: "Enable Custom Invoice",
          toggleSize: hp(1.6),
          onChanged: (val) {
            bloc.changeInvoice(val);
          },
        ),
      );
    }

    Widget buildEmployee() {
      return SingleChildScrollView(
        padding: EdgeInsets.only(right: tablet ? 0 : wp(1.5)),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: wp(tablet ? 1 : 4),
            ),
            //name(),
            businessName(),
            storeName(),
            address1(),
            address2(),
            pinCode(),
            district(),
            cityState(),
            country(),
            language(),
            currency(),
            invoice(),
            customInvoice(),
            StreamBuilder<bool>(
                stream: bloc.invoiceStream,
                builder: (context, snapshot) {
                  if (snapshot.data) {
                    return preFixSeriesWidget();
                  } else {
                    return SizedBox();
                  }
                }),
            SizedBox(
              height: wp(tablet ? 1 : 3),
            ),
            //updateButton(),
            SizedBox(
              height: wp(tablet ? 1 : 4),
            ),
          ],
        ),
      );
    }

    return buildEmployee();
  }
}

class AddStoreBloc extends Object with Validators {
  final companyStream = BehaviorSubject<String>();
  final storeStream = BehaviorSubject<String>();
  final pincodeStream = BehaviorSubject<String>();
  final address1Stream = BehaviorSubject<String>();
  final address2Stream = BehaviorSubject<String>();
  final cityStream = BehaviorSubject<String>();
  final stateStream = BehaviorSubject<String>();
  final cityNameStream = BehaviorSubject<String>();
  final districtStream = BehaviorSubject<String>();
  final stateNameStream = BehaviorSubject<String>();
  final invoiceStream = BehaviorSubject<bool>.seeded(false);
  final invoicePrefixStream = BehaviorSubject<String>();
  final invoiceStartStream = BehaviorSubject<String>();
  final currencyStream = BehaviorSubject<String>();
  final countryStream = BehaviorSubject<String>();
  final countryNameStream = BehaviorSubject<String>();
  final languageStream = BehaviorSubject<String>.seeded("0");

  final api = ApiService.create();
  CurrentStoresDao storesDao = CurrentStoresDao(db);

  Stream<String> get company => companyStream.stream.transform(validateEmpty);
  Stream<String> get store => storeStream.stream.transform(validateEmpty);
  Stream<String> get pincode => pincodeStream.stream.transform(validateEmpty);
  Stream<String> get address1 => address1Stream.stream.transform(validateEmpty);
  Stream<String> get address2 => address2Stream.stream.transform(validateEmpty);
  Stream<String> get city => cityStream.stream.transform(validateEmpty);
  Stream<String> get state => stateStream.stream.transform(validateEmpty);
  Stream<String> get prefix =>
      invoicePrefixStream.stream.transform(validateEmpty);
  Stream<String> get start =>
      invoiceStartStream.stream.transform(validateEmpty);

  Stream<bool> get createValid =>
      Observable.combineLatest2(company, store, (cp, st) => true);

  Function(String) get changeCompany => companyStream.sink.add;
  Function(String) get changeStore => storeStream.sink.add;
  Function(String) get changePincode => pincodeStream.sink.add;
  Function(String) get changeAddress1 => address1Stream.sink.add;
  Function(String) get changeAddress2 => address2Stream.sink.add;
  Function(String) get changeCity => cityStream.sink.add;
  Function(String) get changeState => stateStream.sink.add;
  Function(bool) get changeInvoice => invoiceStream.sink.add;
  Function(String) get changeInvoicePrefix => invoicePrefixStream.sink.add;
  Function(String) get changeInvoiceStart => invoiceStartStream.sink.add;
  Function(String) get changeCurrency => currencyStream.sink.add;
  Function(String) get changeCountry => countryStream.sink.add;
  Function(String) get changeLanguage => languageStream.sink.add;
  Function(String) get changeCityName => cityNameStream.sink.add;
  Function(String) get changeCountryName => countryNameStream.sink.add;
  Function(String) get changeStateName => stateNameStream.sink.add;
  Function(String) get changeDistrict => districtStream.sink.add;
  //Function(String) get changePassword => _password.sink.add;

  createStore(context, callback, oncall) async {
    showLoading(context);
    await getToken((val) async {
      try {
        var params = {
          "name": storeStream.value,
          "companyId": companyStream.value,
          "pinCode": pincodeStream.value,
          "address1": address1Stream.value,
          "address2": address2Stream.value,
          "invoice": invoiceStream.value,
          "cityId": cityStream.value,
          "stateId": stateStream.value,
          "district": districtStream.value,
          "countryId": countryStream.value,
          "invoicePrefix": invoicePrefixStream.value,
          "invoiceStart": invoiceStartStream.value,
          "currency": currencyStream.value,
          "language": languageStream.value == "0" ? "English" : "Español"
        };
        print("STORE NEW $params");
        var res = await api.createStore(authKey: val, body: params);
        print(res.body);
        var value = res.body;
        value["district"] = districtStream.value;
        value["countryName"] = countryNameStream.value;
        storesDao.add(CurrentStoresDao.fromMap(res.body));
        Navigator.pop(context);
        showDialogMessage(context, "Store Successfully Created", () {
          if (!tablet) Navigator.pop(context);
          /* if (oncall != null) {
            oncall();
          } */
        });
        //print(res.body);
      } catch (e) {
        print(e);
        if (e.body != null) {
          Navigator.pop(context);
          showDialogMessage(context, json.decode(e.body)["message"], () {
            /* if (!tablet)
              Navigator.pop(context);
            else if (callback != null) callback(); */
          });
        }
      }
    });
  }

  updateStore(context, callback, oncall, CurrentStore previous) async {
    showLoading(context);
    await getToken((val) async {
      try {
        var params = {
          "name": storeStream.value,
          "companyId": companyStream.value,
          "pinCode": pincodeStream.value,
          "address1": address1Stream.value,
          "address2": address2Stream.value,
          "invoice": invoiceStream.value,
          "cityId": cityStream.value,
          "stateId": stateStream.value,
          "district": districtStream.value,
          "countryId": countryStream.value,
          "invoicePrefix": invoicePrefixStream.value,
          "invoiceStart": invoiceStartStream.value,
          "currency": currencyStream.value,
          "language": languageStream.value == "0" ? "English" : "Español"
        };

        Map<String, dynamic> prev = previous.toJson();
        prev.addAll(params);
        print("STORE update $prev");
        var res =
            await api.updateStore(authKey: val, body: prev, id: prev["id"]);
        print(res.body);
        var value = res.body;
        value["district"] = districtStream.value;
        value["countryName"] = countryNameStream.value;
        print(value);
        storesDao.edit(CurrentStoresDao.fromMap(value));
        Navigator.pop(context);
        showDialogMessage(context, "Store Successfully Updated", () {
          if (!tablet) Navigator.pop(context);
          /* if (oncall != null) {
            oncall();
          } */
        });
        //print(res.body);
      } catch (e) {
        print(e);
        if (e.body != null) {
          Navigator.pop(context);
          showDialogMessage(context, json.decode(e.body)["message"], () {
            /* if (!tablet)
              Navigator.pop(context);
            else if (callback != null) callback(); */
          });
        }
      }
    });
  }

  dispose() {
    print('dispose');
    companyStream.close();
    storeStream.close();
    pincodeStream.close();
    address1Stream.close();
    address2Stream.close();
    cityStream.close();
    stateStream.close();
    invoiceStream.close();
    invoicePrefixStream.close();
    invoiceStartStream.close();
    currencyStream.close();
    countryStream.close();
    languageStream.close();
    cityNameStream.close();
    stateNameStream.close();
    countryNameStream.close();
    districtStream.close();
  }
}
