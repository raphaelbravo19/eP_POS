import 'dart:io';

import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:epaisa_pos/data/models/business_type_dao.dart';
import 'package:epaisa_pos/data/models/industry_dao.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/views/add_new_business/widgets/add_new_business_widget.dart';
import 'package:epaisa_pos/src/views/view_upload_kyc/view_upload_kyc_screen.dart';
import 'package:epaisa_pos/src/views/view_upload_kyc/widgets/view_upload_kyc_widget.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient.dart';
import 'package:epaisa_pos/src/widgets/dialogs/dialog_with_header.dart';
import 'package:epaisa_pos/src/views/employee/widgets/row_structure.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_dropdown.dart';
import 'package:epaisa_pos/src/widgets/utils/dialogs_helper.dart';
import 'package:epaisa_pos/src/widgets/utils/image_helper.dart';
import 'package:flutter/material.dart';

class AddBusinessDetailsScreen extends StatefulWidget {
  AddBusinessBloc bloc;
  AddBusinessDetailsScreen({this.bloc});
  @override
  _AddBusinessDetailsScreenState createState() =>
      _AddBusinessDetailsScreenState();
}

class _AddBusinessDetailsScreenState extends State<AddBusinessDetailsScreen> {
  Future getTypes() async {
    var dao = BusinessTypeDao(db);
    var types = await dao.getAll();
    return types.map((x) => {"name": x.name, "value": x.id}).toList();
  }

  Future getIndustries() async {
    var dao = IndustryDao(db);
    var industries = await dao.getAll();
    return industries.map((x) => {"name": x.name, "value": x.id}).toList();
  }

  Future getIndustriesChildren(id) async {
    var dao = IndustryDao(db);
    var industries = await dao.getChildren(id);
    return industries.map((x) => {"name": x.name, "value": x.id}).toList();
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = tablet ? hp(2.5) : hp(2.00);

    Widget panNo() {
      return RowStructure(
        imagePath: 'assets/my_account/pan_sh.png',
        child: TextfieldClassic(
          stream: widget.bloc.pannumber,
          fontSize: tablet ? hp(2.5) : hp(2.1),
          paddingBottomInput: tablet ? hp(1.3) : hp(1.2),
          labelText: "PAN Number",
          onChanged: (val) {
            widget.bloc.changePan(val);
          },
          initialValue: widget.bloc.panStream.value,
        ),
      );
    }

    void _showKYCDialog(String message) {
      // flutter defined function

      Navigator.of(context).push(new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          var selected = 0;
          return DialogWithHeader(
              //key: _modal,
              message: message,
              width: hp(70),
              marginContent: hp(1),
              height: hp(68),
              content: Expanded(
                  child: ViewUploadKycWidget(
                showViewButton: true,
              )));
        },
      ));
    }

    Widget kycDate() {
      return RowStructure(
        imagePath: 'assets/my_account/pan_sh.png',
        child: TextfieldClassic(
          fontSize: tablet ? hp(2.5) : hp(2.1),
          paddingBottomInput: tablet ? hp(1.3) : hp(1.2),
          labelText: "KYC Date",
          //alwaysFocus: true,
          //hintText: "AAAPL1234C",
          showClearButton: false,
          customIcon: ButtonGradiant(
            tablet ? hp(1.3) : wp(2),
            tablet ? wp(12.5) : wp(37),
            'UPLOAD KYC',
            textStyle: TextStyle(
                fontSize: tablet ? hp(2) : wp(3.4),
                letterSpacing: tablet ? 0 : 1.5,
                color: AppColors.PrimaryWhite,
                fontWeight: FontWeight.w600),
            onPressed: () {
              tablet
                  ? _showKYCDialog("Upload KYC")
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (_) => ViewUploadKycScreen(
                          bloc: widget.bloc,
                          onShow: ({int type}) {
                            if (widget.bloc.idStream.value != "") {
                              showLoading(context);
                            }
                            switch (type) {
                              case 0:
                                widget.bloc.idStream.value != ""
                                    ? downloadKYC(widget.bloc.idStream.value,
                                        "businessPan", () {
                                        Navigator.pop(context);
                                      })
                                    : openFile("businessPan");
                                break;
                              case 1:
                                widget.bloc.idStream.value != ""
                                    ? downloadKYC(widget.bloc.idStream.value,
                                        "bankStatement", () {
                                        Navigator.pop(context);
                                      })
                                    : openFile("bankStatement");
                                break;
                              case 2:
                                widget.bloc.idStream.value != ""
                                    ? downloadKYC(widget.bloc.idStream.value,
                                        "companyProof", () {
                                        Navigator.pop(context);
                                      })
                                    : openFile("companyProof");
                                break;
                              case 3:
                                widget.bloc.idStream.value != ""
                                    ? downloadKYC(widget.bloc.idStream.value,
                                        "addressProof", () {
                                        Navigator.pop(context);
                                      })
                                    : openFile("addressProof");
                                break;
                              default:
                                break;
                            }
                          },
                          onUpload: ({File file, int type}) {
                            switch (type) {
                              case 0:
                                widget.bloc.changeBP(file);
                                break;
                              case 1:
                                widget.bloc.changeBS(file);
                                break;
                              case 2:
                                widget.bloc.changeCP(file);
                                break;
                              case 3:
                                widget.bloc.changeAP(file);
                                break;
                              default:
                                break;
                            }
                          },
                          showViewButton: true,
                        ),
                      ),
                    );
            },
          ),
        ),
      );
    }

    Widget type() {
      return RowStructure(
        imagePath: 'assets/my_account/type_sh.png',
        extraShadow: false,
        child: FutureBuilder(
            future: getTypes(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                if (widget.bloc.typeStream.value == null) {
                  widget.bloc.changeType(snapshot.data[0]["value"]);
                }
                return TextfieldDropdown(
                  items: snapshot.data,
                  paddingBottomInput: hp(0.8),
                  fontSize: fontSize,
                  initValue: widget.bloc.typeStream.value,
                  labelText: "Type",
                  onChanged: (val) {
                    widget.bloc.changeType(val);
                  },
                );
              } else {
                return Container();
              }
            }),
      );
    }

    Widget yearlyRevenue() {
      return RowStructure(
        imagePath: 'assets/my_account/yearly_sh.png',
        child: TextfieldDropdown(
          items: [
            {"name": "0 to 25 lakh Rupees", "value": 0},
            {"name": "25 lakh to 5 Core Rupees", "value": 1},
            {"name": "5 Core to 10 Core Rupees", "value": 2},
            {"name": "More than 10 Core Rupees", "value": 3}
          ],
          paddingBottomInput: hp(0.8),
          fontSize: fontSize,
          labelText: "Yearly Revenue",
        ),
      );
    }

    Widget industry() {
      return RowStructure(
        imagePath: 'assets/my_account/industry_sh.png',
        child: FutureBuilder(
            future: getIndustries(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                if (widget.bloc.industryStream.value == null) {
                  widget.bloc.changeIndustry(snapshot.data[0]["value"]);
                }
                return TextfieldDropdown(
                  items: snapshot.data,
                  paddingBottomInput: hp(0.8),
                  fontSize: fontSize,
                  labelText: "Industry",
                  initValue: widget.bloc.industryStream.value,
                  onChanged: (val) {
                    widget.bloc.changeIndustry(val);
                  },
                );
              } else {
                return Container();
              }
            }),
      );
    }

    Widget category() {
      return RowStructure(
        imagePath: 'assets/my_account/category_sh.png',
        child: StreamBuilder<String>(
            stream: widget.bloc.industryStream,
            builder: (context, snapshot) {
              if (snapshot.data != null && snapshot.data != "") {
                print(snapshot.data);
                return FutureBuilder(
                    future: getIndustriesChildren(snapshot.data),
                    builder: (context, snap) {
                      if (snap.data != null) {
                        if (widget.bloc.categoryStream.value == null &&
                            snap.data.length > 0) {
                          widget.bloc.changeCategory(snap.data[0]["value"]);
                        }
                        return TextfieldDropdown(
                          items: snap.data,
                          paddingBottomInput: hp(0.8),
                          fontSize: fontSize,
                          initValue: widget.bloc.categoryStream.value,
                          labelText: "Category",
                          onChanged: (str) {
                            widget.bloc.changeCategory(str);
                          },
                        );
                      } else {
                        return Container();
                      }
                    });
              } else {
                return Container();
              }
            }),
      );
    }

    Widget buildEmployee() {
      return Padding(
        padding: EdgeInsets.only(top: tablet ? wp(0) : wp(2)),
        child: Column(
          children: <Widget>[
            type(),
            panNo(),
            yearlyRevenue(),
            kycDate(),
            industry(),
            //category(),
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
