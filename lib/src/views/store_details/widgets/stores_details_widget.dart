import 'dart:convert';

import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/data/initial/countries/api_service.dart';
import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:epaisa_pos/data/models/country_dao.dart';
import 'package:epaisa_pos/data/models/currencys_dao.dart';
import 'package:epaisa_pos/data/models/currentcompanys_dao.dart';
import 'package:epaisa_pos/data/models/currentstores_dao.dart';
import 'package:epaisa_pos/src/logic/personal_bloc/personal_bloc.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
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

class StoreDetailsWidget extends StatefulWidget {
  CurrentStore store;
  Function onBack;
  StoreDetailsWidget({Key key, this.store, this.onBack}) : super(key: key);

  @override
  StoreDetailsWidgetState createState() => StoreDetailsWidgetState();
}

class StoreDetailsWidgetState extends State<StoreDetailsWidget> {
  CurrentCompanysDao companyDao = new CurrentCompanysDao(db);
  CurrentStore cstore;
  CurrentStoresDao storesDao = new CurrentStoresDao(db);
  ApiService api = ApiService.create();
  GlobalKey<TextfieldClassicState> namekey =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> address1key =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> address2key =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> pincodekey =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> citykey =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> stateKey =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldDropdownState> keyBusiness =
      GlobalKey<TextfieldDropdownState>();
  GlobalKey<TextfieldClassicState> keyName = GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> keyAddress1 =
      GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> keyAddress2 =
      GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> keyPinCode =
      GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> keyInvoicePrefix =
      GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> keyInvoiceStart =
      GlobalKey<TextfieldClassicState>();
  var languageVal;
  var countryVal;
  var currencyVal;

  BehaviorSubject<bool> invoiceStream;
  @override
  void initState() {
    if (widget.store != null) {
      cstore = widget.store;
      languageVal = widget.store.language;
      countryVal = ""; //widget.store.country;
      currencyVal = widget.store.currency;

      invoiceStream = new BehaviorSubject<bool>.seeded(widget.store.invoice);
    } else {
      invoiceStream = BehaviorSubject<bool>.seeded(false);
    }
    super.initState();
  }

  Future getData() async {
    var list = await companyDao.getAll();
    return list.map((item) => {"name": item.name, "value": item.id}).toList();
  }

  void editStore({callback}) async {
    showLoading(context);
    try {
      var objStore = cstore.toJson();
      print("X");
      //objStore[] = value;
      objStore["name"] = keyName.currentState.value;
      objStore["companyId"] = keyBusiness.currentState.getValue()["value"];
      objStore["address1"] = keyAddress1.currentState.value;
      objStore["address2"] = keyAddress2.currentState.value;
      objStore["pinCode"] = keyPinCode.currentState.value;
      objStore["city"] = citykey.currentState.value;
      objStore["state"] = stateKey.currentState.value;

      objStore["invoice"] = invoiceStream.value;
      objStore["currency"] = currencyVal;
      objStore["country"] = countryVal;
      objStore["language"] = languageVal;
      if (invoiceStream.value) {
        objStore["invoicePrefix"] = keyInvoicePrefix.currentState.value;
        objStore["invoiceStart"] = keyInvoiceStart.currentState.value;
      }
      print(objStore["companyId"]);

      await getToken((val) async {
        print("dixe");
        var res =
            await api.updateStore(id: cstore.id, body: objStore, authKey: val);
        storesDao.edit(CurrentStoresDao.fromMap(res.body));
        print(res.body);
        Navigator.pop(context);
        showDialogMessage(context, "Store Successfully Created", () {
          if (!tablet) Navigator.pop(context);
          if (callback != null) {
            callback();
          }
        });
      });
      cstore = CurrentStoresDao.fromMap(objStore);
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
  }

  Future getCurrencys() async {
    var dao = CurrencysDao(db);
    var currencys = await dao.getAll();
    return currencys.map((x) => {"name": x.name, "value": x.id}).toList();
  }

  Future getCountries() async {
    CountryDao dao = CountryDao(db);
    var countries = await dao.getAll();
    var res = countries.map((f) => {"name": f.name, "value": f.id}).toList();
    return res;
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
                                editStore(callback: callback);
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
    final personlBloc = PersonalBloc();
    final bool tablet = isTablet(MediaQuery.of(context));
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    double fontSize = tablet ? hp(2.2) : hp(2.00);
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
              key: keyInvoicePrefix,
              paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
              fontSize: tablet ? hp(2.7) : hp(2.1),
              labelText: "Prefix",
              initialValue: widget.store != null ? cstore.invoicePrefix : "",
            )),
            Expanded(
                child: TextfieldClassic(
              key: keyInvoiceStart,
              leftBorder: true,
              keyType: TextInputType.number,
              paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
              fontSize: tablet ? hp(2.7) : hp(2.1),
              labelText: "Series Start",
              initialValue: widget.store != null ? cstore.invoiceStart : "",
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
              if (snapshot.hasData) {
                return TextfieldDropdown(
                  key: keyBusiness,
                  items: snapshot.data,
                  paddingBottomInput: hp(0.8),
                  fontSize: fontSize,
                  labelText: "Business Name",
                  initValue: widget.store != null ? widget.store.companyId : "",
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
            future:
                getData() /* ()async {
            return await industries
                .map((item) => {"name": item.name, "value": item.id})
                .toList();*/

            ),
      );
    }

    Widget storeName() {
      return RowStructure(
        imagePath: 'assets/my_account/Store.png',
        child: TextfieldClassic(
          key: keyName,
          fontSize: fontSize,
          paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
          labelText: "Store Name",
          initialValue: widget.store != null ? cstore.name : "",
          alwaysFocus: true,
          onFocusChange: (val) {
            /*if (!val) {
              updateStore("name", namekey.currentState.value);
            }*/
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
          key: keyAddress1,
          fontSize: tablet ? hp(2.5) : hp(2.1),
          paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
          labelText: "Address",
          initialValue: widget.store != null ? cstore.address1 : "",
          alwaysFocus: true,

          /*onFocusChange: (val) {
            if (!val) {
              updateStore("address1", address1key.currentState.value);
            }
          },*/
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
          key: keyAddress2,
          fontSize: tablet ? hp(2.7) : hp(2.1),
          paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
          initialValue: widget.store != null ? cstore.address2 : "",
          hintText: "Address 2",
        ),
      );
    }

    Widget pinCode() {
      return RowStructure(
        imagePath: '',
        child: TextfieldClassic(
          keyType: TextInputType.number,
          key: keyPinCode,
          fontSize: tablet ? hp(2.7) : hp(2.1),
          paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
          onFocusChange: (f) async {
            if (!f && keyPinCode.currentState.value.length == 6) {
              showLoading(context);
              print("BLOC ${keyPinCode.currentState.value}");
              var res = await ApiService.create()
                  .getPincode(keyPinCode.currentState.value);
              if (res == null || res.body == null || res.body['data'] == null) {
                Navigator.pop(context);
              } else {
                print("MOMENT${res.body["data"][0]["city"]}");
                var resCity = await ApiService.create()
                    .getCity(res.body["data"][0]["city"]);
                print("RESCITY${resCity.body}");
                if (resCity.body["data"] != null) {
                  var resState = await ApiService.create()
                      .getState(resCity.body["data"][0]["state"]);
                  print("RESSTATE${resState.body}");

                  citykey.currentState
                      .changeText(resCity.body["data"][0]["name"]);

                  stateKey.currentState.changeText(resState.body["name"]);
                } else {
                  var resState =
                      await ApiService.create().getState(resCity.body["state"]);
                  print("RESSTATE${resState.body}");

                  citykey.currentState.changeText(resCity.body["name"]);

                  stateKey.currentState.changeText(resState.body["name"]);
                }
                Navigator.pop(context);
              }
            }
          },
          initialValue: widget.store != null ? cstore.pinCode : "",
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
                      key: citykey,
                      paddingBottomInput: hp(1),
                      fontSize: fontSize,
                      hintText: "City",
                      disabled: true,
                      initialValue:
                          "" //widget.store != null ? cstore.city : "",
                      )),
              Expanded(
                  child: TextfieldClassic(
                      key: stateKey,
                      leftBorder: true,
                      paddingBottomInput: hp(1),
                      fontSize: fontSize,
                      hintText: "State",
                      disabled: true,
                      initialValue:
                          "" //widget.store != null ? cstore.state : "",
                      )),
            ],
          ));
    }

    Widget country() {
      return RowStructure(
        imagePath: 'assets/my_account/Country.png',
        child: FutureBuilder(
            future: getCountries(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return TextfieldDropdown(
                  items: snapshot.data,
                  labelText: "Country",
                  paddingBottomInput: hp(0.8),
                  fontSize: fontSize,
                  initValue: "" //widget.store != null
                  ,
                  onChanged: (val) {
                    countryVal = val;
                  },
                  //labelText: "Business Name",
                );
              } else {
                return Container();
              }
            }),
      );
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
          onChanged: (val) {
            languageVal = val == "0" ? "English" : "Español";
          },
          initValue: widget.store != null
              ? widget.store.language != null
                  ? widget.store.language == "English" ? "0" : "1"
                  : null
              : null,
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
                return TextfieldDropdown(
                  items: snapshot.data,
                  paddingBottomInput: hp(0.8),
                  fontSize: fontSize,
                  //initValue: widget.bloc.currencyStream.value,
                  initValue: widget.store != null
                      ? widget.store.currency != null
                          ? widget.store.currency
                          : null
                      : null,
                  labelText: "Currency",
                  onChanged: (val) {
                    currencyVal = val;
                  },
                );
              } else {
                return Container();
              }
            }),
      );
    }

    Widget invoice() {
      return Text(
        "INVOICE",
        style: TextStyle(
          color: AppColors.PrimaryBlue,
          fontSize: tablet ? hp(2.7) : wp(4.5),
          fontWeight: FontWeight.bold,
        ),
      );
    }

    Widget customInvoice() {
      return Padding(
        padding: EdgeInsets.only(
            left: wp(4),
            right: wp(3),
            top: wp(tablet ? 0.8 : 1),
            bottom: wp(tablet ? 0 : 1)),
        child: ToggleCard(
          fontSize: tablet ? hp(2.1) : wp(4.5),
          paddingHorizontal: tablet ? hp(1) : wp(3),
          paddingVertical: tablet ? hp(3) : wp(3),
          spaceBeforeDesc: tablet ? hp(3) : wp(3),
          toggleSize: tablet ? hp(1.7) : wp(2.7),
          sized: tablet ? hp(2) : wp(0),
          initial: widget.store != null ? cstore.invoice : false,
          description: "Enable Custom Invoice",
          onChanged: (val) {
            invoiceStream.sink.add(val);
          },
        ),
      );
    }

    Widget updateButton() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: tablet ? hp(2) : wp(6)),
        child: ButtonGradient(
          borderRadius: tablet ? hp(2) : wp(5),
          title: 'UPDATE',
          callback: () async {
            showLoading(context);
            await editStore();
          },
          paddingVertical: hp(1.5),
          fontSize: tablet ? hp(2.5) : wp(4),
        ),
      );

      /* hp(1.8),
        wp(35),
        'UPDATE',
        textStyle: TextStyle(
            fontSize: tablet ? hp(2.5) : layoutHeight * 0.025,
            color: AppColors.PrimaryWhite,
            fontWeight: FontWeight.w600),
        onPressed: () {},
      );*/
    }

    Widget buildEmployee() {
      return SingleChildScrollView(
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
            cityState(),
            country(),
            language(),
            currency(),
            SizedBox(
              height: hp(1),
            ),
            invoice(),
            customInvoice(),
            StreamBuilder<bool>(
                stream: invoiceStream,
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    if (snapshot.data) {
                      return preFixSeriesWidget();
                    } else {
                      return Container();
                    }
                  } else {
                    return Container();
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
