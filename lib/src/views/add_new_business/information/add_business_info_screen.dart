import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/data/initial/countries/api_service.dart';
import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:epaisa_pos/data/models/country_dao.dart';
import 'package:epaisa_pos/data/models/currencys_dao.dart';
import 'package:epaisa_pos/src/bloc/location_bloc.dart';
import 'package:epaisa_pos/src/models/Location.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/countries.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/add_new_business/widgets/add_new_business_widget.dart';
import 'package:epaisa_pos/src/widgets/header_card/header_widget.dart';
import 'package:epaisa_pos/src/views/employee/widgets/row_structure.dart';
import 'package:epaisa_pos/src/widgets/textfields/texfield_number.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_dropdown.dart';
import 'package:epaisa_pos/src/widgets/utils/dialogs_helper.dart';
import 'package:flutter/material.dart';

class AddBusinessInfoScreen extends StatefulWidget {
  AddBusinessInfoScreen({this.bloc});
  AddBusinessBloc bloc;

  @override
  _AddBusinessInfoScreenState createState() => _AddBusinessInfoScreenState();
}

class _AddBusinessInfoScreenState extends State<AddBusinessInfoScreen> {
  GlobalKey<TextfieldClassicState> address1Key =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> address2Key =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> districtKey =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> cityKey =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> stateKey =
      new GlobalKey<TextfieldClassicState>();
  Future<CountryData> getInitial() async {
    var lss = await getWithCode(int.parse(widget.bloc.codeStream.value));
    print(lss.toJsonString());
    return lss;
  }

  Future getCurrencys() async {
    var dao = CurrencysDao(db);
    var currencys = await dao.getAll();
    return currencys.map((x) => {"name": x.name, "value": x.id}).toList();
  }

  Future getCountry() async {
    var dao = CountryDao(db);
    var countries = await dao.getAll();
    return countries.map((x) => {"name": x.name, "value": x.id}).toList();
  }

  @override
  Widget build(BuildContext context) {
    final bool tablet = isTablet(MediaQuery.of(context));
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    double fontSize = tablet ? hp(2.8) : hp(2.00);

    Widget companyName() {
      return RowStructure(
        imagePath: 'assets/my_account/Business.png',
        child: TextfieldClassic(
          fontSize: tablet ? hp(2.5) : hp(2.1),
          paddingBottomInput: tablet ? hp(1.3) : hp(1.2),
          labelText: "Company Name",
          initialValue: widget.bloc.companyStream.value,
          onChanged: (str) {
            print("Name $str");
            widget.bloc.changeCompany(str);
          },
        ),
      );
    }

    Widget email() {
      return RowStructure(
        imagePath: 'assets/employee/Email.png',
        child: TextfieldClassic(
          stream: widget.bloc.mail,
          fontSize: tablet ? hp(2.5) : hp(2.1),
          paddingBottomInput: tablet ? hp(1.3) : hp(1.2),
          labelText: 'E-mail',
          initialValue: widget.bloc.mailStream.value,
          onChanged: (str) {
            print("Mail $str");
            widget.bloc.changeMail(str);
          },
        ),
      );
    }

    Widget mobNo() {
      return RowStructure(
          imagePath: 'assets/employee/MobileNumber.png',
          child: FutureBuilder<Object>(
              future: getInitial(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return TextfieldNumber(
                    stream: widget.bloc.number,
                    fontSize: tablet ? hp(2.5) : hp(2.1),
                    paddingBottomInput: tablet ? hp(1.3) : hp(1.2),
                    labelText: "Business " + eptxt('mobile_number'),
                    alwaysFocus: true,
                    initialValue: widget.bloc.phoneStream.value,
                    initialCountry: snapshot.data,
                    onChangedCountry: (str) {
                      print("CODE $str");
                      widget.bloc.changeCode("$str");
                    },
                    onChanged: (str) {
                      print("Number $str");
                      widget.bloc.changePhone(str);
                    },
                  );
                } else {
                  return Container();
                }
              }));
    }

    Widget country() {
      return RowStructure(
        imagePath: 'assets/my_account/country_sh.png',
        child: FutureBuilder(
            future: getCountry(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                if (widget.bloc.countryStream.value == null) {
                  widget.bloc.changeCountry(snapshot.data[0]["value"]);
                }
                return TextfieldDropdown(
                  items: snapshot.data,
                  paddingBottomInput: hp(0.8),
                  fontSize: fontSize,
                  labelText: "Country",
                  initValue: widget.bloc.countryStream.value,
                  onChanged: (val) {
                    widget.bloc.changeCountry(val);
                  },
                );
              } else {
                return Container();
              }
            }),
      );
    }

    Widget currency() {
      return RowStructure(
        imagePath: 'assets/my_account/Currency.png',
        child: FutureBuilder(
            future: getCurrencys(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                if (widget.bloc.currencyStream.value == null) {
                  widget.bloc.changeCurrency(snapshot.data[0]["value"]);
                }
                return TextfieldDropdown(
                  items: snapshot.data,
                  paddingBottomInput: hp(0.8),
                  fontSize: fontSize,
                  initValue: widget.bloc.currencyStream.value,
                  labelText: "Currency",
                  onChanged: (val) {
                    widget.bloc.changeCurrency(val);
                  },
                );
              } else {
                return Container();
              }
            }),
      );
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
          key: address1Key,
          fontSize: tablet ? hp(2.7) : hp(2.1),
          paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
          labelText: "Address",
          initialValue: widget.bloc.address1Stream.value,
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
                    address1Key.currentState.changeText(loc.addressLine);
                    widget.bloc.changeAddress1(loc.addressLine);
                    address2Key.currentState.changeText(loc.cityWithPostal);
                    widget.bloc.changeAddress2(loc.cityWithPostal);
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
            widget.bloc.changeAddress1(str);
          },
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
          initialValue: widget.bloc.address2Stream.value,
          onChanged: (str) {
            widget.bloc.changeAddress2(str);
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
                stream: widget.bloc.cityNameStream,
                paddingBottomInput: hp(1),
                fontSize: fontSize,
                hintText: "City",
                initialValue: widget.bloc.cityNameStream.value,
              )),
              Expanded(
                  child: TextfieldClassic(
                key: stateKey,
                stream: widget.bloc.stateNameStream,
                leftBorder: true,
                paddingBottomInput: hp(1),
                fontSize: fontSize,
                hintText: "State",
                initialValue: widget.bloc.stateNameStream.value,
              ))
            ],
          ));
    }

    Widget pinCode() {
      return RowStructure(
        imagePath: '',
        child: TextfieldClassic(
          stream: widget.bloc.pincodeStream,
          fontSize: tablet ? hp(2.7) : hp(2.1),
          paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
          alwaysFocus: true,
          hintText: "Pincode",
          onFocusChange: (f) async {
            if (!f && widget.bloc.pincodeStream.value.length == 6) {
              showLoading(context);

              var res = await ApiService.create()
                  .getPincode(widget.bloc.pincodeStream.value);

              if (res == null || res.body == null || res.body['data'] == null) {
                Navigator.pop(context);
              } else {
                widget.bloc.changeDistrict(res.body["data"][0]["taluka"]);
                districtKey.currentState
                    .changeText(res.body["data"][0]["taluka"]);
                var resCity = await ApiService.create()
                    .getCity(res.body["data"][0]["city"]);
                widget.bloc.changeCity(res.body["data"][0]["city"]);
                print("RESCITY${resCity.body}");
                if (resCity.body["data"] != null) {
                  var resState = await ApiService.create()
                      .getState(resCity.body["data"][0]["state"]);
                  widget.bloc.changeState(resCity.body["data"][0]["state"]);
                  print("RESSTATE${resState.body}");
                  widget.bloc.changeCityName(resCity.body["data"][0]["name"]);
                  cityKey.currentState
                      .changeText(resCity.body["data"][0]["name"]);
                  widget.bloc.changeStateName(resState.body["name"]);
                  stateKey.currentState.changeText(resState.body["name"]);
                } else {
                  var resState =
                      await ApiService.create().getState(resCity.body["state"]);
                  widget.bloc.changeState(resCity.body["state"]);
                  print("RESSTATE${resState.body}");
                  widget.bloc.changeCityName(resCity.body["name"]);
                  cityKey.currentState.changeText(resCity.body["name"]);
                  widget.bloc.changeStateName(resState.body["name"]);
                  stateKey.currentState.changeText(resState.body["name"]);
                }
                Navigator.pop(context);
              }
            }
          },
          initialValue: widget.bloc.pincodeStream.value,
          onChanged: (str) {
            widget.bloc.changePincode(str);
          },
        ),
      );
    }

    Widget district() {
      return RowStructure(
        imagePath: '',
        child: TextfieldClassic(
          key: districtKey,
          fontSize: tablet ? hp(2.7) : hp(2.1),
          paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
          hintText: "District",
          initialValue: widget.bloc.districtStream.value,
          onChanged: (str) {
            widget.bloc.changeDistrict(str);
          },
          //onChanged: personlBloc.personAddress2Sink,
          //stream: personlBloc.personAddress2Stream,
        ),
      );
    }

    Widget language() {
      return RowStructure(
        imagePath: 'assets/my_account/Language.png',
        child: TextfieldDropdown(
          items: [
            {"name": "English", "value": "0"},
            {"name": "Español", "value": "1"}
          ],
          paddingBottomInput: hp(0.8),
          fontSize: fontSize,
          labelText: "Language",
          initValue: widget.bloc.languageStream.value,
          onChanged: (val) {
            widget.bloc.changeLanguage(val);
          },
        ),
      );
    }

    Widget buildEmployee() {
      return Padding(
        padding: EdgeInsets.only(top: tablet ? wp(0) : wp(2)),
        child: Column(
          children: <Widget>[
            companyName(),
            email(),
            mobNo(),
            address1(),
            address2(),
            pinCode(),
            district(),
            cityState(),
            country(),
            currency(),
            language(),
            SizedBox(
              height: hp(12),
            )
          ],
        ),
      );
    }

    return buildEmployee();
  }
}
