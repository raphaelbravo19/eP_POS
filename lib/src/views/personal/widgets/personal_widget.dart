import 'dart:convert';

import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/data/initial/countries/api_service.dart';
import 'package:epaisa_pos/data/models/country_dao.dart';
import 'package:epaisa_pos/data/models/currentusers_dao.dart';
import 'package:epaisa_pos/src/bloc/bloc.dart';
import 'package:epaisa_pos/src/logic/navigation_logic/Navigation.dart';
import 'package:epaisa_pos/src/logic/personal_bloc/personal_bloc.dart';
import 'package:epaisa_pos/src/models/Location.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/countries.dart';
import 'package:epaisa_pos/src/utility/progress_dialog.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/validators/Validator.dart';
import 'package:epaisa_pos/src/views/employee/widgets/row_structure.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/dialogs/dialog_classic.dart';
import 'package:epaisa_pos/src/widgets/header_card/header_widget.dart';
import 'package:epaisa_pos/src/widgets/textfields/texfield_number.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_dropdown.dart';
import 'package:epaisa_pos/src/widgets/utils/dialogs_helper.dart';
import 'package:epaisa_pos/src/widgets/utils/request_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class PersonalWidget extends StatefulWidget {
  PersonalWidget({Key key}) : super(key: key);
  @override
  PersonalWidgetState createState() => PersonalWidgetState();
}

class PersonalWidgetState extends State<PersonalWidget> {
  final locationBloc = LocationBloc();
  var loading = false;
  List<CountryData> countries = [];
  ProfileBloc bloc = ProfileBloc();
  GlobalKey<TextfieldNumberState> mobilekey = GlobalKey<TextfieldNumberState>();
  GlobalKey<TextfieldClassicState> cityKey = GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> stateKey =
      GlobalKey<TextfieldClassicState>();

  GlobalKey<TextfieldClassicState> address1Key =
      GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> address2Key =
      GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> districtKey =
      GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> countryKey =
      GlobalKey<TextfieldClassicState>();
  var loaded = false;
  @override
  void dispose() {
    locationBloc.dispose();
    bloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future loadData() async {
    await bloc.getData();

    setState(() {
      loaded = true;
    });
  }

  Future<CountryData> getInitial() async {
    print("HERE:${bloc.callStream.value}");
    var lss = await getWithCode(int.parse(bloc.callStream.value));
    print("AK47");
    print(lss.toJsonString());
    return lss;
  }

  GlobalKey<DialogClassicState> dialog = new GlobalKey<DialogClassicState>();
  showConfirm({callback}) {
    var ctx = context;
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
                        "Are you sure you want to save the information?",
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
                                bloc.saveData(ctx);
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
                                Navigator.pop(ctx);
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
    final bool tablet = isTablet(MediaQuery.of(context));
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    double fontSize = tablet ? hp(2.8) : hp(2.00);
    Widget name() {
      return RowStructure(
        imagePath: 'assets/employee/Name.png',
        child: Row(
          children: <Widget>[
            Expanded(
                child: TextfieldClassic(
              paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
              fontSize: tablet ? hp(2.7) : hp(2.1),
              labelText: "First Name",
              initialValue: bloc.fnameStream.value,
              stream: bloc.fname,
              onChanged: (str) {
                bloc.changeFirstName(str);
              },
            )),
            Expanded(
                child: TextfieldClassic(
              leftBorder: true,
              paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
              fontSize: tablet ? hp(2.7) : hp(2.1),
              labelText: "Last Name",
              initialValue: bloc.lnameStream.value,
              stream: bloc.lname,
              onChanged: (str) {
                bloc.changeLastName(str);
              },
            )),
          ],
        ),
      );
    }

    Widget email() {
      return RowStructure(
        imagePath: 'assets/employee/Email.png',
        child: TextfieldClassic(
          fontSize: tablet ? hp(2.7) : hp(2.1),
          paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
          labelText: eptxt('email'),
          initialValue: bloc.mailStream.value,
          stream: bloc.mail,
          onChanged: (str) {
            bloc.changeMail(str);
          },
        ),
      );
    }

    Widget mobNo() {
      return RowStructure(
          imagePath: 'assets/employee/MobileNumber.png',
          child: FutureBuilder(
              future: getInitial(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return TextfieldNumber(
                    stream: bloc.mobile,
                    key: mobilekey,
                    fontSize: tablet ? hp(2.7) : hp(2.1),
                    paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
                    labelText: eptxt('mobile_number'),
                    initialCountry: snapshot.data,
                    initialValue: bloc.mobileStream.value,
                    onChanged: (val) {
                      bloc.changeMobile(val);
                    },
                    onChangedCountry: (val) {
                      bloc.changeCall("$val");
                    },
                  );
                } else {
                  return TextfieldNumber(
                    stream: bloc.mobile,
                    fontSize: tablet ? hp(2.7) : hp(2.1),
                    paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
                    labelText: eptxt('mobile_number'),
                    onChanged: (val) {
                      bloc.changeMobile(val);
                    },
                    onChangedCountry: (val) {
                      bloc.changeCall("$val");
                    },
                  );
                }
              }));
    }

    Widget birthDate() {
      return RowStructure(
        imagePath: 'assets/employee/Birthdate.png',
        child: TextfieldClassic(
          fontSize: tablet ? hp(2.7) : hp(2.1),
          paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
          labelText: "Birthdate",
        ),
      );
    }

    Widget country() {
      return RowStructure(
        imagePath: 'assets/my_account/Country.png',
        child: TextfieldClassic(
          key: countryKey,
          fontSize: tablet ? hp(2.7) : hp(2.1),
          paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
          labelText: "Country",
          disabled: true,
          initialValue: bloc.countryNameStream.value,
          onChanged: (str) {
            bloc.changeCountryName(str);
          },
          //onChanged: personlBloc.personAddress2Sink,
          //stream: personlBloc.personAddress2Stream,
        ),
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
          initialValue: bloc.address1Stream.value,
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
                stream: bloc.cityNameStream,
                paddingBottomInput: hp(1),
                fontSize: fontSize,
                disabled: true,
                hintText: "City",
                initialValue: bloc.cityNameStream.value,
              )),
              Expanded(
                  child: TextfieldClassic(
                key: stateKey,
                stream: bloc.stateNameStream,
                leftBorder: true,
                paddingBottomInput: hp(1),
                fontSize: fontSize,
                disabled: true,
                hintText: "State",
                initialValue: bloc.stateNameStream.value,
              ))
            ],
          ));
    }

    Widget pinCode() {
      return RowStructure(
        imagePath: '',
        child: TextfieldClassic(
          fontSize: tablet ? hp(2.7) : hp(2.1),
          paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
          alwaysFocus: true,
          hintText: "Pincode",
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
          initialValue: bloc.pincodeStream.value,
          onChanged: (str) {
            print(str);
            bloc.changePincode(str);
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
          disabled: true,
          initialValue: bloc.districtStream.value,
          onChanged: (str) {
            bloc.changeDistrict(str);
          },
          //onChanged: personlBloc.personAddress2Sink,
          //stream: personlBloc.personAddress2Stream,
        ),
      );
    }

    Widget buildEmployee() {
      return Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
                child: loaded
                    ? Column(
                        children: <Widget>[
                          CommonHeader(
                            account: true,
                            showButton: false,
                          ),
                          SizedBox(
                            height: hp(1),
                          ),
                          name(),
                          email(),
                          mobNo(),
                          birthDate(),
                          /*...locationModule(
                            locationBloc: locationBloc,
                            context: context,
                            data: {}),*/
                          address1(),
                          address2(),
                          pinCode(),
                          district(),
                          cityState(),
                          country(),
                          SizedBox(
                            height: hp(12),
                          )
                          //countryWithoutLabel+(),
                        ],
                      )
                    : Container()),
          )
        ],
      );
    }

    return buildEmployee();
  }
}

class ProfileBloc extends Object with Validators {
  final api = ApiService.create();
  CurrentUsersDao userDao = CurrentUsersDao(db);
  CurrentUser cuser;
  final fnameStream = BehaviorSubject<String>.seeded("");
  final lnameStream = BehaviorSubject<String>.seeded("");
  final mailStream = BehaviorSubject<String>();
  final callStream = BehaviorSubject<String>.seeded("");
  final mobileStream = BehaviorSubject<String>();
  final address1Stream = BehaviorSubject<String>.seeded("");
  final address2Stream = BehaviorSubject<String>.seeded("");
  final pincodeStream = BehaviorSubject<String>.seeded("");
  final cityStream = BehaviorSubject<String>.seeded("");
  final stateStream = BehaviorSubject<String>.seeded("");
  final cityNameStream = BehaviorSubject<String>.seeded("");
  final stateNameStream = BehaviorSubject<String>.seeded("");
  final districtStream = BehaviorSubject<String>.seeded("");
  final countryStream = BehaviorSubject<String>.seeded("");
  final countryNameStream = BehaviorSubject<String>.seeded("");

  Stream<String> get fname => fnameStream.stream;
  Stream<String> get lname => fnameStream.stream;
  Stream<String> get mail => mailStream.stream.transform(validateEmail);
  Stream<String> get call => callStream.stream;
  Stream<String> get mobile => mobileStream.stream.transform(validateNumber);
  Stream<String> get address1 => address1Stream.stream;
  Stream<String> get address2 => address2Stream.stream;
  Stream<String> get city => cityStream.stream;

  Function(String) get changeFirstName => fnameStream.sink.add;
  Function(String) get changeLastName => lnameStream.sink.add;
  Function(String) get changeMail => mailStream.sink.add;
  Function(String) get changeCall => callStream.sink.add;
  Function(String) get changeMobile => mobileStream.sink.add;
  Function(String) get changeAddress1 => address1Stream.sink.add;
  Function(String) get changeAddress2 => address2Stream.sink.add;
  Function(String) get changePincode => pincodeStream.sink.add;
  Function(String) get changeCity => cityStream.sink.add;
  Function(String) get changeState => stateStream.sink.add;
  Function(String) get changeCityName => cityNameStream.sink.add;
  Function(String) get changeStateName => stateNameStream.sink.add;
  Function(String) get changeDistrict => districtStream.sink.add;
  Function(String) get changeCountry => countryStream.sink.add;
  Function(String) get changeCountryName => countryNameStream.sink.add;
  getData() async {
    var users = await userDao.getAll();
    var user = users[0];
    cuser = user;
    changeFirstName(user.firstName);
    changeLastName(user.lastName);
    changeMail(user.username);
    changeCall(user.mobile.substring(1, user.mobile.length - 10));
    changeMobile(user.mobile.substring(user.mobile.length - 10));
    changeAddress1(user.address1);
    changeAddress2(user.address2);
    changeCity(user.city);
    changeState(user.state);
    changeCityName(user.cityName);
    changeStateName(user.stateName);
    changePincode(user.pinCode);
    changeDistrict(user.district);
    changeCountryName(user.countryName);
    changeCountry(user.country);
  }

  saveData(context) async {
    showLoading(context);
    var authkey = await getauthkey();

    try {
      var params = {
        "firstName": fnameStream.value,
        "lastName": lnameStream.value,
        "address1": address1Stream.value,
        "address2": address2Stream.value,
        "city": cityStream.value,
        "state": stateStream.value,
        "country": countryStream.value,
        "district": districtStream.value,
        "pinCode": pincodeStream.value,
      };

      Map<String, dynamic> prev = cuser.toJson();
      prev.addAll(params);
      print("STORE update $prev");
      var res =
          await api.updateUsers(authKey: authkey, body: prev, id: prev["id"]);
      print("REPSPONSE${res.body}");
      var value = res.body;
      value["district"] = districtStream.value;
      value["countryName"] = countryNameStream.value;
      print(value);
      userDao.edit(CurrentUsersDao.fromMap(value));
      Navigator.pop(context);
      showDialogMessage(context, "Profile Successfully Updated", () {
        if (!tablet) Navigator.pop(context);
        /* if (oncall != null) {
            oncall();
          } */
      });
      //print(res.body);
    } catch (e) {
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

  dispose() {
    print('dispose');
    fnameStream.close();
    lnameStream.close();
    mailStream.close();
    callStream.close();
    mobileStream.close();
    address1Stream.close();
    address2Stream.close();
    cityStream.close();
    pincodeStream.close();
    stateStream.close();
    cityNameStream.close();
    stateNameStream.close();
    districtStream.close();
    countryNameStream.close();
    countryStream.close();
  }
}
