import 'dart:convert';

import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/data/models/business_type_dao.dart';
import 'package:epaisa_pos/data/models/industry_dao.dart';
import 'package:epaisa_pos/data/user/user_repository.dart';
import 'package:epaisa_pos/src/bloc/bloc.dart';
import 'package:epaisa_pos/src/logic/create_account_bloc/create_account_bloc.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/remove_over_scroll_glow.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/create_account/widgets/account_created_dialog.dart';
import 'package:epaisa_pos/src/views/create_account/widgets/agreements_dialog.dart';
import 'package:epaisa_pos/src/views/create_account/widgets/confirmation_dialog.dart';
import 'package:epaisa_pos/src/views/create_account/widgets/consent_dialog.dart';
import 'package:epaisa_pos/src/views/create_account/widgets/otp_dialog.dart';
import 'package:epaisa_pos/src/views/create_account/widgets/resend_opt_dialog.dart';
import 'package:epaisa_pos/src/views/create_account/widgets/row_industry.dart';
import 'package:epaisa_pos/src/views/login/widgets/background_image.dart';
import 'package:epaisa_pos/src/views/login/widgets/learn_more.dart';
import 'package:epaisa_pos/src/views/login/widgets/logo.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/dialogs/dialog_common.dart';
import 'package:epaisa_pos/src/widgets/textfields/texfield_number.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_dropdown.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_password.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CreateAccountScreen extends StatefulWidget {
  final UserRepository _userRepository = UserRepository();

  CreateAccountScreen()
  // : assert(userRepository != null),
  // : _userRepository = userRepository,
  ;
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

final db = AppDatabase();

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool accept = false;
  bool seller = false;
  bool consent = false;
  BehaviorSubject<String> industrySelected = new BehaviorSubject<String>();
  BehaviorSubject<String> typeSelected = new BehaviorSubject<String>();
  GlobalKey<TextfieldClassicState> fnamekey =
      new GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldNumberState> numberKey =
      new GlobalKey<TextfieldNumberState>();
  List<BusinessTypeData> businessTypes = [];
  List<IndustryData> industries = [];
  final businessTypeDao = BusinessTypeDao(db);
  GlobalKey<DialogCommonState> modal = GlobalKey<DialogCommonState>();
  final industryDao = IndustryDao(db);
  List<Map<String, dynamic>> listIndustries = List<Map<String, dynamic>>();
  List<Map<String, dynamic>> listTypes = List<Map<String, dynamic>>();
  CreateAccountBloc registerBloc = new CreateAccountBloc();

  initState() {
    // registerBloc = RegisterBloc(userRepository: widget._userRepository);

    getD();

    super.initState();
  }

  bool open = false;

  void closeInfo() {
    setState(() {
      open = false;
    });
  }

  Future getD() async {
    industryDao.getParent().then((data) async {
      for (var i = 0; i < data.length; i++) {
        var temp = await industryDao.getChildren(data[i].id);

        listIndustries.add({
          "id": i,
          "name": data[i].name,
          "children": temp.map((x) => {"name": x.name, "id": x.id}).toList()
        });
      }
      setState(() {
        industries = data;
      });
    });

    businessTypeDao.getAll().then((data) async {
      for (var i = 0; i < data.length; i++) {
        listTypes.add({
          "id": data[i].id,
          "name": data[i].name,
        });
      }
      setState(() {
        businessTypes = data;
      });
    });
  }

  Widget _ModalIndustry({isType = false}) {
    Navigator.of(context).push(
      new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return DialogCommon(
            key: modal,
            padding: false,
            fontSize: tablet ? hp(2.8) : hp(2.2),
            title: isType ? "Select Type" : "Select Industry",
            width: tablet ? hp(65) : wp(88),
            child: isType
                ? new TableType(
                    listIndustries: listTypes,
                    modal: modal,
                    industrySelected: typeSelected,
                    industries: businessTypes)
                : new TableIndustries(
                    listIndustries: listIndustries,
                    modal: modal,
                    industrySelected: industrySelected,
                    industries: industries),
          );
        },
        transitionsBuilder: (c, anim, a2, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: Duration(milliseconds: 150),
      ),
    );
  }

  Widget _buildCardbackground(
      double width, BuildContext context, double height) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final bool tablet = ScreenUtils.of(context).isTablet;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: hp(3),
        ),
        Logo(tablet ? hp(7) : hp(5.5)),
        SizedBox(
          height: hp(0.3),
        ),
        LearnMore(
          wp(100),
          tablet,
          fontSize: tablet ? hp(2.5) : hp(1.88),
        ),
        SizedBox(
          height: hp(2),
        ),
        Container(
            child: Card(
                margin:
                    EdgeInsets.symmetric(horizontal: tablet ? wp(28) : wp(7)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 10.0,
                child: Container(
                    padding: EdgeInsets.fromLTRB(tablet ? wp(4) : wp(8), hp(2),
                        tablet ? wp(4) : wp(8), hp(3)),
                    child: Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: TextfieldClassic(
                                key: fnamekey,
                                paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
                                fontSize: tablet ? hp(2.7) : hp(2.1),
                                labelText: eptxt('first_name'),
                                stream: registerBloc.firstName,
                                onChanged: (value) {
                                  registerBloc.changeFirstname(value);
                                },
                              ),
                            ),
                            Expanded(
                              child: TextfieldClassic(
                                leftBorder: true,
                                paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
                                fontSize: tablet ? hp(2.7) : hp(2.1),
                                labelText: eptxt('last_name'),
                                stream: registerBloc.lastName,
                                onChanged: (value) {
                                  registerBloc.changeLastName(value);
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: tablet ? hp(0.3) : hp(0.5),
                        ),
                        TextfieldClassic(
                          fontSize: tablet ? hp(2.7) : hp(2.1),
                          paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
                          labelText: eptxt('email'),
                          stream: registerBloc.email,
                          onChanged: (value) {
                            registerBloc.changeEmail(value);
                          },
                        ),
                        SizedBox(
                          height: tablet ? hp(0.3) : hp(0.5),
                        ),
                        TextfieldPassword(
                          fontSize: tablet ? hp(2.7) : hp(2.1),
                          paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
                          labelText: eptxt('password'),
                          stream: registerBloc.password,
                          //onChanged: registerBloc.changePassword,
                          onChanged: (value) {
                            registerBloc.changePassword(value);
                          },
                          showValidations: true,
                        ),
                        SizedBox(
                          height: tablet ? hp(0.3) : hp(0.5),
                        ),
                        TextfieldNumber(
                          key: numberKey,
                          fontSize: tablet ? hp(2.7) : hp(2.1),
                          paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
                          labelText: eptxt('mobile_number'),
                          stream: registerBloc.number,
                          onChanged: (value) {
                            registerBloc.changeNumber(value);
                          },
                        ),
                        SizedBox(
                          height: tablet ? hp(0.3) : hp(0.5),
                        ),
                        StreamBuilder<String>(
                            stream: industrySelected,
                            builder: (context, snapshot) {
                              var str = "";
                              if (snapshot.data != null) {
                                str = json.decode(snapshot.data)["name"];
                              }
                              return TextfieldDropdown(
                                fontSize: tablet ? hp(2.7) : hp(2.1),
                                paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
                                labelText: "Industry",
                                items: snapshot.data != null
                                    ? [
                                        {"value": 0, "name": str}
                                      ]
                                    : [],
                                startValue: snapshot.data != null,
                                defaultText: snapshot.data != null ? str : "",
                                onTap: () {
                                  _ModalIndustry();
                                },
                              );
                            }),
                        SizedBox(
                          height: tablet ? hp(0.3) : hp(0.5),
                        ),
                        StreamBuilder<String>(
                            stream: typeSelected,
                            builder: (context, snapshot) {
                              var str = "";
                              if (snapshot.data != null) {
                                str = json.decode(snapshot.data)["name"];
                              }
                              return TextfieldDropdown(
                                fontSize: tablet ? hp(2.7) : hp(2.1),
                                paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
                                items: snapshot.data != null
                                    ? [
                                        {"value": 0, "name": str}
                                      ]
                                    : [],
                                labelText: "Type",
                                startValue: snapshot.data != null,
                                defaultText: snapshot.data != null ? str : "",
                                onTap: () {
                                  _ModalIndustry(isType: true);
                                },
                              );
                            }),
                      ],
                    )))),
        SizedBox(
          height: tablet ? hp(2.3) : hp(4),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  seller = !seller;
                  consent = !consent;
                });
              },
              child: Image.asset(
                "assets/createaccount/${seller && consent ? "" : "dis"}agree.png",
                height: tablet ? hp(4) : wp(5.5),
              ),
            ),
            Text(
              "  ePaisa's ",
              style: TextStyle(
                fontSize: tablet ? hp(2.6) : wp(3.4),
                color: AppColors.TermsGray,
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
              onTap: () {
                _showDialog("seller");
              },
              child: Text(
                eptxt('seller_agreement'),
                style: TextStyle(
                  fontSize: tablet ? hp(2.6) : wp(3.4),
                  color: AppColors.PrimaryBlue,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              " ${eptxt('and')} ",
              style: TextStyle(
                  fontSize: tablet ? hp(2.6) : wp(3.4),
                  color: AppColors.TermsGray,
                  fontWeight: FontWeight.w600),
            ),
            GestureDetector(
                onTap: () {
                  _showDialog("consent");
                },
                child: Text(
                  eptxt('e_sign'),
                  style: TextStyle(
                      fontSize: tablet ? hp(2.6) : wp(3.4),
                      color: AppColors.PrimaryBlue,
                      fontWeight: FontWeight.w700),
                ))
          ],
        ),
        SizedBox(
          height: tablet ? hp(2.3) : hp(4),
        ),
        Container(
            margin: new EdgeInsets.symmetric(
                horizontal: tablet ? width * 0.29 : wp(7)),
            child: StreamBuilder<bool>(
                stream: registerBloc.createValid,
                builder: (context, snapshot) {
                  return ButtonGradient(
                    disabled: !snapshot.hasData ||
                        !seller ||
                        !consent ||
                        industrySelected.value == null ||
                        typeSelected.value == null,
                    paddingVertical: tablet ? hp(2.5) : hp(2.5),
                    borderRadius: hp(4),
                    letterSpacing: tablet ? 2 : 1,
                    fontSize: tablet ? hp(2.5) : hp(1.8),
                    title: "${eptxt('create_an_account').toUpperCase()}",
                    callback: () async {
                      if (snapshot.hasData &&
                          seller &&
                          consent &&
                          industrySelected.value != null) {
                        await registerBloc.Create(
                            numberKey.currentState.getNumberString(),
                            context,
                            () => _showDialog("created"),
                            industrySelected.value,
                            typeSelected.value);
                      }
                    },
                  );
                })),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BackgroundImage.buildBackgroundImage(tablet: tablet),
              height: hp(100),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Align(
                        alignment: FractionalOffset.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: hp(tablet ? 7 : 4.5), left: wp(2.3)),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: hp(tablet ? 5 : 4.65),
                          ),
                        ),
                      ),
                    ),
                  ),
                  _buildCardbackground(width, context, height),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(String option) {
    // flutter defined function
    Navigator.of(context).push(new PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        switch (option) {
          case 'seller':
            return AgreementDialog(
              selectOption: (bool val) {
                setState(() {
                  seller = val;
                });
                registerBloc.changeFirstname(fnamekey.currentState.value);
              },
            );
            break;
          case 'consent':
            return ConsentDialog(
              selectOption: (val) {
                setState(() {
                  consent = val;
                });
                registerBloc.changeFirstname(fnamekey.currentState.value);
              },
            );
            break;
          case 'create':
            return ConfirmationDialog(action: () {
              _showDialog("otp");
            });
            break;
          case 'otp':
            return OTPCreateDialog(action: () {
              _showDialog("created");
            });
            break;
          case 'resend':
            return ResendOTPDialog(action: () {
              _showDialog("otp");
            });
            break;
          case 'created':
            return AccountCreatedDialog();
            break;
          default:
            return Container();
            break;
        }
      },
    ));
  }
}

class TableIndustries extends StatefulWidget {
  const TableIndustries({
    Key key,
    @required this.listIndustries,
    @required this.modal,
    @required this.industrySelected,
    @required this.industries,
  }) : super(key: key);

  final List<Map<String, dynamic>> listIndustries;
  final GlobalKey<DialogCommonState> modal;
  final BehaviorSubject<String> industrySelected;
  final List<IndustryData> industries;

  @override
  _TableIndustriesState createState() => _TableIndustriesState();
}

class _TableIndustriesState extends State<TableIndustries> {
  var openIndex = 0;
  List<Widget> list = new List<Widget>();
  Map<String, GlobalKey<RowIndustryState>> keys =
      Map<String, GlobalKey<RowIndustryState>>();
  @override
  void initState() {
    // TODO: implement initState
    for (var i = 0; i < widget.listIndustries.length; i++) {
      keys["in$i"] = new GlobalKey<RowIndustryState>();
    }
    for (var i = 0; i < widget.listIndustries.length; i++) {
      list.add(
        RowIndustry(
            key: keys["in$i"],
            closePrevious: (val) {
              keys["in$openIndex"].currentState.closeInfo(false);
              openIndex = val;
            },
            closeModal: () {
              widget.modal.currentState.closeModal();
            },
            indexSelected: widget.industrySelected,
            index: i,
            select: (val) {
              widget.industrySelected.sink.add(json.encode(val));
            },
            industry: widget.listIndustries[i]),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hp(48.3),
      child: Column(
        children: <Widget>[
          widget.industries.length > 0
              ? Expanded(
                  child: SingleChildScrollView(
                  child: Column(children: list),
                ))
              : Expanded(
                  child: Container(
                  alignment: Alignment.center,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                          height: hp(22),
                        ),
                        SizedBox(
                          height: hp(2),
                        ),
                        Text(
                          eptxt('your_cart_is_empty'),
                          style: TextStyle(
                              fontSize: hp(2.7),
                              fontWeight: FontWeight.w700,
                              color: AppColors.IconGray),
                        )
                      ],
                    ),
                  ),
                )),
        ],
      ),
    );
  }
}

class TableType extends StatefulWidget {
  const TableType({
    Key key,
    @required this.listIndustries,
    @required this.modal,
    @required this.industrySelected,
    @required this.industries,
  }) : super(key: key);

  final List<Map<String, dynamic>> listIndustries;
  final GlobalKey<DialogCommonState> modal;
  final BehaviorSubject<String> industrySelected;
  final List<BusinessTypeData> industries;

  @override
  _TableTypeState createState() => _TableTypeState();
}

class _TableTypeState extends State<TableType> {
  var openIndex = 0;
  List<Widget> list = new List<Widget>();
  Map<String, GlobalKey<RowIndustryState>> keys =
      Map<String, GlobalKey<RowIndustryState>>();
  @override
  void initState() {
    // TODO: implement initState
    for (var i = 0; i < widget.listIndustries.length; i++) {
      keys["in$i"] = new GlobalKey<RowIndustryState>();
    }
    for (var i = 0; i < widget.listIndustries.length; i++) {
      list.add(
        RowType(
            key: keys["in$i"],
            closePrevious: (val) {
              keys["in$openIndex"].currentState.closeInfo(false);
              openIndex = val;
            },
            closeModal: () {
              widget.modal.currentState.closeModal();
            },
            indexSelected: widget.industrySelected,
            index: i,
            select: (val) {
              widget.industrySelected.sink.add(json.encode(val));
            },
            industry: widget.listIndustries[i]),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hp(48.3),
      child: Column(
        children: <Widget>[
          widget.industries.length > 0
              ? Expanded(
                  child: SingleChildScrollView(
                  child: Column(children: list),
                ))
              : Expanded(
                  child: Container(
                  alignment: Alignment.center,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                          height: hp(22),
                        ),
                        SizedBox(
                          height: hp(2),
                        ),
                        Text(
                          eptxt('your_cart_is_empty'),
                          style: TextStyle(
                              fontSize: hp(2.7),
                              fontWeight: FontWeight.w700,
                              color: AppColors.IconGray),
                        )
                      ],
                    ),
                  ),
                )),
        ],
      ),
    );
  }
}
