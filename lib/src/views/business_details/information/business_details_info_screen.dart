import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/data/initial/countries/api_service.dart';
import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:epaisa_pos/data/models/currentcompanys_dao.dart';
import 'package:epaisa_pos/src/utility/countries.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart' as prefix0;
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/add_new_business/widgets/add_new_business_widget.dart';
import 'package:epaisa_pos/src/widgets/header_card/header_widget.dart';
import 'package:epaisa_pos/src/views/employee/widgets/row_structure.dart';
import 'package:epaisa_pos/src/widgets/textfields/texfield_number.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_dropdown.dart';
import 'package:epaisa_pos/src/widgets/utils/request_helper.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class BusinessInfoScreen extends StatefulWidget {
  CurrentCompany company;
  Function changeName;
  AddBusinessBloc bloc;
  BusinessInfoScreen({this.company, this.changeName, this.bloc});

  @override
  _BusinessInfoScreenState createState() => _BusinessInfoScreenState();
}

class _BusinessInfoScreenState extends State<BusinessInfoScreen> {
  CurrentCompany ccompany;
  CurrentCompanysDao companyDao = new CurrentCompanysDao(db);
  ApiService api = ApiService.create();
  GlobalKey<TextfieldClassicState> namekey =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> emailkey =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldNumberState> mobilekey =
      new GlobalKey<TextfieldNumberState>();
  @override
  void initState() {
    print("HERE ${widget.company}");
    ccompany = widget.company;
    super.initState();
  }

  void updateCompany(String field, dynamic value) async {
    /* var objCompany = ccompany.toJson();
    objCompany['$field'] = value;
    companyDao.edit(CurrentCompanysDao.fromMapOwn(objCompany));
    await getToken((val) async {
      try {
        var res = await api.updateCompany(
            id: ccompany.id,
            body: CurrentCompanysDao.toAPI(objCompany),
            authKey: val);
        print(res.body);
      } catch (e) {
        print(e.body);
      }
    });
    ccompany = CurrentCompanysDao.fromMapOwn(objCompany); */
  }

  Future<CountryData> getInitial() async {
    var lss = await getWithCode(
        int.parse(ccompany.mobile.substring(1, ccompany.mobile.length - 10)));
    print("AK47");
    print(lss.toJsonString());
    return lss;
  }

  @override
  Widget build(BuildContext context) {
    final bool tablet = isTablet(MediaQuery.of(context));
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    double fontSize = tablet ? hp(2.5) : hp(2.00);

    Widget companyName() {
      return RowStructure(
        imagePath: 'assets/my_account/Business.png',
        child: TextfieldClassic(
          stream: widget.bloc.companyStream,
          key: namekey,
          fontSize: tablet ? hp(2.4) : hp(2.1),
          paddingBottomInput: tablet ? hp(1.3) : hp(1.2),
          labelText: "Company Name",
          alwaysFocus: true,

          initialValue: ccompany.name,
          onChanged: (val) {
            widget.bloc.changeCompany(val);
          },
          //hintText: "Expresso Café",
        ),
      );
    }

    Widget email() {
      return RowStructure(
        imagePath: 'assets/employee/Email.png',
        child: TextfieldClassic(
          stream: widget.bloc.mail,
          key: emailkey,
          fontSize: tablet ? hp(2.5) : hp(2.1),
          paddingBottomInput: tablet ? hp(1) : hp(1.2),
          labelText: 'Business ' + eptxt('email'),
          alwaysFocus: ccompany.email != null,
          initialValue: ccompany.email,
          onChanged: (val) {
            widget.bloc.changeMail(val);
          },
          //alwaysFocus: true,
          //hintText: "abc@xyz.com",
        ),
      );
    }

    Widget mobNo() {
      return RowStructure(
          imagePath: 'assets/employee/MobileNumber.png',
          child: ccompany.mobile != null
              ? ccompany.mobile.length > 5
                  ? FutureBuilder(
                      future: getInitial(),
                      builder: (context, snapshot) {
                        print("DATA:${snapshot.data}");
                        if (snapshot.hasData) {
                          print("DATASecond:${snapshot.data}");
                          return TextfieldNumber(
                            stream: widget.bloc.number,
                            key: mobilekey,
                            fontSize: tablet ? hp(2.5) : hp(2.1),
                            paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
                            labelText: 'Business ' + eptxt('mobile_number'),
                            alwaysFocus: ccompany.mobile != null,
                            initialCountry: snapshot.data,
                            initialValue: ccompany.mobile
                                .substring(ccompany.mobile.length - 10),
                            onChanged: (val) {
                              widget.bloc.changePhone(
                                  mobilekey.currentState.getNumberString());
                            },
                            onChangedCountry: (val) {
                              widget.bloc.changePhone(
                                  mobilekey.currentState.getNumberString());
                            },
                          );
                        } else {
                          return TextfieldNumber(
                            fontSize: tablet ? hp(2.5) : hp(2.1),
                            paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
                            labelText: 'Business ' + eptxt('mobile_number'),
                            alwaysFocus: ccompany.mobile != null,
                            initialValue: ccompany.mobile
                                .substring(ccompany.mobile.length - 10),
                            onChangedCountry: (v) {
                              updateCompany("mobile",
                                  mobilekey.currentState.getNumberString());
                            },
                            onFocusChange: (val) {
                              if (!val) {
                                updateCompany("mobile",
                                    mobilekey.currentState.getNumberString());
                              }
                            },
                          );
                        }
                      })
                  : TextfieldNumber(
                      key: mobilekey,
                      fontSize: tablet ? hp(2.5) : hp(2.1),
                      paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
                      labelText: 'Business ' + eptxt('mobile_number'),
                      alwaysFocus: ccompany.mobile != null,
                      onChangedCountry: (v) {
                        updateCompany(
                            "mobile", mobilekey.currentState.getNumberString());
                      },
                      onFocusChange: (val) {
                        if (!val) {
                          updateCompany("mobile",
                              mobilekey.currentState.getNumberString());
                        }
                      },
                    )
              : TextfieldNumber(
                  key: mobilekey,
                  fontSize: tablet ? hp(2.5) : hp(2.1),
                  paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
                  labelText: 'Business ' + eptxt('mobile_number'),
                  alwaysFocus: ccompany.mobile != null,
                  onChangedCountry: (v) {
                    updateCompany(
                        "mobile", mobilekey.currentState.getNumberString());
                  },
                  onFocusChange: (val) {
                    if (!val) {
                      updateCompany(
                          "mobile", mobilekey.currentState.getNumberString());
                    }
                  },
                ));
    }

    Widget country() {
      return RowStructure(
        imagePath: 'assets/my_account/country_sh.png',
        child: TextfieldDropdown(
          items: [
            {"name": "India", "value": 0},
            {"name": "US", "value": 1},
            {"name": "Canada", "value": 2}
          ],
          paddingBottomInput: hp(0.8),
          fontSize: fontSize,
          labelText: "Country",
        ),
      );
    }

    Widget currency() {
      return RowStructure(
        imagePath: 'assets/my_account/Currency.png',
        child: TextfieldDropdown(
          items: [
            {"name": "(INR) Indian Rupee", "value": 0},
            {"name": "(DOLLER) US", "value": 1}
          ],
          paddingBottomInput: hp(0.8),
          fontSize: fontSize,
          labelText: "Currency",
        ),
      );
    }

    Widget language() {
      return RowStructure(
        imagePath: 'assets/my_account/Language.png',
        child: TextfieldDropdown(
          items: multilang.getSelected() == 'en'
              ? [
                  {"name": "English", "value": 0},
                  {"name": "Español", "value": 1}
                ]
              : [
                  {"name": "Español", "value": 0},
                  {"name": "English", "value": 1}
                ],
          paddingBottomInput: hp(0.8),
          fontSize: fontSize,
          labelText: "Language",
          onChanged: (value) {
            String lang = value == 'English' ? 'en' : 'es';
            multilangBloc.changeLanguage(
              context: context,
              path: 'assets/json/$lang.json',
            );
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
            country(),
            currency(),
            language(),
            SizedBox(
              height: hp(16),
            )
          ],
        ),
      );
    }

    return buildEmployee();
  }
}
