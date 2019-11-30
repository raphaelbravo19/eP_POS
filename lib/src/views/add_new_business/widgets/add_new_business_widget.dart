import 'dart:convert';
import 'dart:io';

import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/data/initial/countries/api_service.dart';
import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:epaisa_pos/data/models/currentcompanys_dao.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/validators/Validator.dart';
import 'package:epaisa_pos/src/views/add_new_business/details/details_screen.dart';
import 'package:epaisa_pos/src/views/add_new_business/finential_info/add_business_financial_info.dart';
import 'package:epaisa_pos/src/views/add_new_business/information/add_business_info_screen.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/dialogs/dialog_classic.dart';
import 'package:epaisa_pos/src/widgets/header_card/header_widget.dart';
import 'package:epaisa_pos/src/widgets/utils/dialogs_helper.dart';
import 'package:epaisa_pos/src/widgets/utils/image_helper.dart';
import 'package:epaisa_pos/src/widgets/utils/request_helper.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class AddNewBusinessWidget extends StatefulWidget {
  CurrentCompany company;
  Function onBack;
  AddNewBusinessWidget({Key key, this.company, this.onBack}) : super(key: key);
  @override
  AddNewBusinessWidgetState createState() => AddNewBusinessWidgetState();
}

class AddNewBusinessWidgetState extends State<AddNewBusinessWidget> {
  int _selectedIndex = 0;
  bool valid = false;

  AddBusinessBloc bloc = AddBusinessBloc();
  void create({callback}) async {
    if (valid) {
      showLoading(context);
      await bloc.createBusiness(context, () {
        if (widget.onBack != null) {
          widget.onBack();
        }
        if (callback != null) {
          callback();
        }
      });
      //Navigator.pop(context);
      //Navigator.pop(context);
    } else {
      showDialogMessage(context, "Enter valid fields", () {});
    }
  }

  void update({callback}) async {
    if (valid) {
      showLoading(context);
      await bloc.updateBusiness(context, widget.company.id, () {
        if (widget.onBack != null) {
          widget.onBack();
        }
        if (callback != null) {
          callback();
        }
      });
      //Navigator.pop(context);
      //Navigator.pop(context);
    } else {
      showDialogMessage(context, "Enter valid fields", () {});
    }
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
                        "Are you sure you want to\n${widget.company != null ? "update" : "save"} the business?",
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
                                if (widget.company != null) {
                                  await update(callback: callback);
                                } else {
                                  await create(callback: callback);
                                }
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
  void initState() {
    bloc.createValid.listen((s) {
      print("VALID$s");
      valid = s;
    });
    if (widget.company != null) {
      bloc.changeCompany(widget.company.name);
      bloc.changeID(widget.company.id);
      bloc.changeMail(widget.company.email != null ? widget.company.email : "");
      bloc.changePhone(widget.company.mobile != null
          ? widget.company.mobile.substring(widget.company.mobile.length - 10)
          : "");
      bloc.changeCode(widget.company.mobile != null
          ? widget.company.mobile
              .substring(1, widget.company.mobile.length - 10)
          : "91");
      bloc.changeType(widget.company.businessTypeId);
      if (widget.company.currency != null)
        bloc.changeCurrency(widget.company.currency);
      if (widget.company.country != null)
        bloc.changeCountry(widget.company.country);
      if (widget.company.panNumber != null)
        bloc.changePan(widget.company.panNumber);
      if (widget.company.gstin != null) bloc.changeGstin(widget.company.gstin);
      if (widget.company.address1 != null)
        bloc.changeAddress1(widget.company.address1);
      if (widget.company.address2 != null)
        bloc.changeAddress2(widget.company.address2);
      if (widget.company.pinCode != null)
        bloc.changePincode(widget.company.pinCode);
      if (widget.company.stateName != null)
        bloc.changeStateName(widget.company.stateName);
      if (widget.company.industryId != null)
        bloc.changeIndustry(widget.company.industryId);
      if (widget.company.cityName != null)
        bloc.changeCityName(widget.company.cityName);
      if (widget.company.district != null)
        bloc.changeDistrict(widget.company.district);
      if (widget.company.city != null) bloc.changeCity(widget.company.city);
      if (widget.company.state != null) bloc.changeState(widget.company.state);
      if (widget.company.language != null)
        bloc.changeLanguage(widget.company.language == "English" ? "0" : "1");

      getFiles();
      //bloc.changeType(widget.company.);
    }
    super.initState();
  }

  Future<File> getFiles() async {
    /*  File doc = document.body; 
    downloadFile("download/companies/${widget.company.id}/kyc/businessPan",
        (File file) async {*/
    /* 
    final directory = await getApplicationDocumentsDirectory();
    File f = File('${directory.path}/businessPan.pdf');
    var by = await file.readAsBytes();
    f.writeAsBytes(by); 
      //bloc.changeBP(file);
      print("CHANGED BUSINESS");
    }); */
    //print(doc.toString());
  }

  @override
  void dispose() async {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool tablet = isTablet(MediaQuery.of(context));
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;

    Widget _getScreenTablet() {
      switch (_selectedIndex) {
        case 0:
          return Row(
            children: <Widget>[
              Expanded(
                child: AddBusinessInfoScreen(
                  bloc: bloc,
                ),
              ),
            ],
          );
        case 1:
          return Row(
            children: <Widget>[
              Expanded(
                child: AddBusinessDetailsScreen(
                  bloc: bloc,
                ),
              ),
            ],
          );
        case 2:
          return Row(
            children: <Widget>[
              Expanded(
                child: AddBusinessFinancialInfoScreen(
                  bloc: bloc,
                ),
              ),
            ],
          );
        default:
          return Row(
            children: <Widget>[
              Expanded(
                child: AddBusinessInfoScreen(),
              ),
            ],
          );
      }
    }

    Widget _tabNavigator() {
      List<String> options = ["Information", "Details", "Financial Info"];
      List<Widget> tabs = new List<Widget>();
      //var counter = 0;
      for (var i = 0; i < options.length; i++) {
        bool isSelected = i == _selectedIndex;
        var x = options[i];
        tabs.add(Expanded(
          flex: 1,
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
                                : AppColors.PrimaryWhite,
                            width: 4))),
                alignment: Alignment.center,
                child: Text(
                  x,
                  style: TextStyle(
                      fontSize: tablet ? hp(2.2) : wp(4),
                      fontWeight: FontWeight.w700,
                      color: isSelected
                          ? AppColors.PrimaryBlue
                          : AppColors.DisabledText.withOpacity(0.6)),
                )),
          ),
        ));
      }
      return Container(
        height: tablet ? hp(7) : hp(6),
        decoration: BoxDecoration(
          color: AppColors.PrimaryWhite,
          boxShadow: [
            BoxShadow(
                color: AppColors.DarkGray.withOpacity(0.3),
                offset: Offset(0, 2),
                blurRadius: 1)
          ],
        ),
        child: Container(
          child: Row(
            children: tabs,
          ),
        ),
      );
    }

    Widget _getScreen() {
      switch (_selectedIndex) {
        case 0:
          return AddBusinessInfoScreen(
            bloc: bloc,
          );
        case 1:
          return AddBusinessDetailsScreen(
            bloc: bloc,
          );
        case 2:
          return AddBusinessFinancialInfoScreen(
            bloc: bloc,
          );
        default:
          return AddBusinessInfoScreen();
      }
    }

    Widget buildEmployee() {
      return Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
                child: Column(
              verticalDirection: VerticalDirection.up,
              children: <Widget>[
                tablet ? _getScreenTablet() : _getScreen(),
                _tabNavigator(),
                CommonHeader(
                  account: true,
                  showButton: false,
                  streamName: bloc.companyStream,
                  imageUrl: widget.company != null
                      ? widget.company.image != null
                          ? widget.company.image
                          : null
                      : null,
                  onchange: (val) {
                    bloc.changeImage(val);
                  },
                ),
              ],
            )),
          ),
        ],
      );
    }

    return buildEmployee();
  }
}

class AddBusinessBloc extends Object with Validators {
  final companyStream = BehaviorSubject<String>();
  final mailStream = BehaviorSubject<String>();
  final codeStream = BehaviorSubject<String>.seeded("91");
  final phoneStream = BehaviorSubject<String>();
  final industryStream = BehaviorSubject<String>();
  final categoryStream = BehaviorSubject<String>();
  final currencyStream = BehaviorSubject<String>();
  final address1Stream = BehaviorSubject<String>();
  final address2Stream = BehaviorSubject<String>();
  final pincodeStream = BehaviorSubject<String>();
  final cityStream = BehaviorSubject<String>();
  final cityNameStream = BehaviorSubject<String>();
  final stateStream = BehaviorSubject<String>();
  final stateNameStream = BehaviorSubject<String>();
  final districtStream = BehaviorSubject<String>();
  final idStream = BehaviorSubject<String>.seeded("");

  final countryStream = BehaviorSubject<String>();
  final typeStream = BehaviorSubject<String>();
  final panStream = BehaviorSubject<String>();
  final gstinStream = BehaviorSubject<String>();
  final gstStream = BehaviorSubject<bool>.seeded(true);
  final languageStream = BehaviorSubject<String>.seeded("0");
  final imageStream = BehaviorSubject<File>();
  final bpStream = BehaviorSubject<File>();
  final bsStream = BehaviorSubject<File>();
  final cpStream = BehaviorSubject<File>();
  final apStream = BehaviorSubject<File>();
  final api = ApiService.create();
  CurrentCompanysDao companysDao = CurrentCompanysDao(db);

  Stream<String> get mail => mailStream.stream.transform(validateEmail);
  Stream<String> get number => phoneStream.stream.transform(validateNumber);
  Stream<String> get pannumber => panStream.stream.transform(validatePanNumber);

  Stream<bool> get createValid =>
      Observable.combineLatest3(mail, number, pannumber, (pw, nm, pn) => true);

  Function(String) get changeCompany => companyStream.sink.add;
  Function(String) get changeMail => mailStream.sink.add;
  Function(String) get changePhone => phoneStream.sink.add;
  Function(String) get changeCode => codeStream.sink.add;
  Function(String) get changeIndustry => industryStream.sink.add;
  Function(String) get changeCurrency => currencyStream.sink.add;
  Function(String) get changeCountry => countryStream.sink.add;
  Function(String) get changeCategory => categoryStream.sink.add;
  Function(String) get changeType => typeStream.sink.add;
  Function(String) get changePan => panStream.sink.add;
  Function(String) get changeGstin => gstinStream.sink.add;
  Function(bool) get changeGst => gstStream.sink.add;
  Function(String) get changeLanguage => languageStream.sink.add;
  Function(String) get changeAddress1 => address1Stream.sink.add;
  Function(String) get changeAddress2 => address2Stream.sink.add;
  Function(String) get changePincode => pincodeStream.sink.add;
  Function(String) get changeCity => cityStream.sink.add;
  Function(String) get changeState => stateStream.sink.add;
  Function(String) get changeCityName => cityNameStream.sink.add;
  Function(String) get changeStateName => stateNameStream.sink.add;
  Function(String) get changeDistrict => districtStream.sink.add;
  Function(File) get changeImage => imageStream.sink.add;
  Function(File) get changeBP => bpStream.sink.add;
  Function(File) get changeBS => bsStream.sink.add;
  Function(File) get changeCP => cpStream.sink.add;
  Function(File) get changeAP => apStream.sink.add;
  Function(String) get changeID => idStream.sink.add;
  //Function(String) get changePassword => _password.sink.add;

  createBusiness(context, callback) async {
    await getToken((val) async {
      try {
        var params = {
          "name": companyStream.value,
          "email": mailStream.value,
          "mobile": "+${codeStream.value}${phoneStream.value}",
          "country": countryStream.value,
          "industry": industryStream.value,
          "type": typeStream.value,
          "address1": address1Stream.value,
          "address2": address2Stream.value,
          "pinCode": pincodeStream.value,
          "district": districtStream.value,
          "state": stateStream.value,
          "city": cityStream.value,
          "panNumber": panStream.value,
          "gstin": gstinStream.value,
          "currency": currencyStream.value,
          "language": languageStream.value == "0" ? "English" : "Español"
        };
        print(params);
        var res = await api.createCompany(authKey: val, body: params);
        var compa = res.body;
        if (imageStream.value != null) {
          compa["image"] = imageStream.value.toString();
          await UploadImage(
              "upload/companies/${compa["id"]}", imageStream.value);
        }
        companysDao.add(CurrentCompanysDao.fromMap(compa));
        Navigator.pop(context);
        showDialogMessage(context, "Business Successfully Created", () {
          if (!tablet)
            Navigator.pop(context);
          else if (callback != null) callback();
        });
      } catch (e) {
        print(e);
        if (e.body != null) {
          Navigator.pop(context);
          showDialogMessage(context, json.decode(e.body)["message"], () {});
        }
      }
    });
  }

  updateBusiness(context, id, callback) async {
    await getToken((val) async {
      try {
        var current = await companysDao.getOne(id);
        var sendObj = current.toJson();

        var params = {
          "name": companyStream.value,
          "email": mailStream.value,
          "mobile": "+${codeStream.value}${phoneStream.value}",
          "country": countryStream.value,
          "industry": industryStream.value,
          "type": typeStream.value,
          "address1": address1Stream.value,
          "address2": address2Stream.value,
          "pinCode": pincodeStream.value,
          "district": districtStream.value,
          "state": stateStream.value,
          "city": cityStream.value,
          "panNumber": panStream.value,
          "gstin": gstinStream.value,
          "currency": currencyStream.value,
          "language": languageStream.value == "0" ? "English" : "Español"
        };
        sendObj.addAll(params);
        print(params);

        var res = await api.updateCompany(authKey: val, body: sendObj, id: id);
        var compa = res.body;
        if (imageStream.value != null) {
          compa["image"] = imageStream.value.toString();
          await UploadImage("upload/companies/$id", imageStream.value);
        }
        if (bpStream.value != null) {
          //compa["image"] = imageStream.value.toString();
          await UploadFiles(
              "upload/companies/$id/kyc/businessPan", bpStream.value);
        }
        if (bsStream.value != null) {
          //compa["image"] = imageStream.value.toString();
          await UploadFiles(
              "upload/companies/$id/kyc/bankStatement", bsStream.value);
        }
        if (cpStream.value != null) {
          //compa["image"] = imageStream.value.toString();
          await UploadFiles(
              "upload/companies/$id/kyc/companyProof", cpStream.value);
        }
        if (apStream.value != null) {
          //compa["image"] = imageStream.value.toString();
          await UploadFiles(
              "upload/companies/$id/kyc/addressProof", apStream.value);
        }
        var necomp = res.body;
        necomp["stateName"] = stateNameStream.value;
        necomp["cityName"] = cityNameStream.value;
        companysDao.edit(CurrentCompanysDao.fromMap(res.body));
        Navigator.pop(context);
        showDialogMessage(context, "Business Successfully Updated", () {
          if (!tablet)
            Navigator.pop(context);
          else if (callback != null) callback();
        });
      } catch (e) {
        print(e);
        if (e.body != null) {
          Navigator.pop(context);
          showDialogMessage(context, json.decode(e.body)["message"], () {});
        }
      }
    });
  }

  dispose() {
    print('dispose');
    companyStream.close();
    mailStream.close();
    phoneStream.close();
    codeStream.close();
    industryStream.close();
    currencyStream.close();
    countryStream.close();
    categoryStream.close();
    typeStream.close();
    panStream.close();
    gstinStream.close();
    gstStream.close();
    languageStream.close();
    address1Stream.close();
    address2Stream.close();
    pincodeStream.close();
    cityStream.close();
    cityNameStream.close();
    stateStream.close();
    stateNameStream.close();
    districtStream.close();
    imageStream.close();
    bpStream.close();
    bsStream.close();
    cpStream.close();
    apStream.close();
    idStream.close();
  }
}
