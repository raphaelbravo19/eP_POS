import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/data/models/industry_dao.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/view_upload_kyc/view_upload_kyc_screen.dart';
import 'package:epaisa_pos/src/views/view_upload_kyc/widgets/view_upload_kyc_widget.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient.dart';
import 'package:epaisa_pos/src/widgets/dialogs/dialog_with_header.dart';
import 'package:epaisa_pos/src/widgets/header_card/header_widget.dart';
import 'package:epaisa_pos/src/views/employee/widgets/row_structure.dart';
import 'package:epaisa_pos/src/widgets/textfields/texfield_number.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_dropdown.dart';
import 'package:flutter/material.dart';

final db = AppDatabase();

class BusinessDetailsInfoScreen extends StatefulWidget {
  CurrentCompany company;
  BusinessDetailsInfoScreen({this.company});
  @override
  _BusinessDetailsInfoScreenState createState() =>
      _BusinessDetailsInfoScreenState();
}

class _BusinessDetailsInfoScreenState extends State<BusinessDetailsInfoScreen> {
  List<IndustryData> industries = [];
  final industriyDao = IndustryDao(db);

  @override
  void initState() {
    industriyDao.getAll().then((data) {
      setState(() {
        industries = data;
      });
    });
    super.initState();
  }

  Future getIndustries() async {
    var list = await industriyDao.getAll();
    return list.map((item) => {"name": item.name, "value": item.id}).toList();
  }

  @override
  Widget build(BuildContext context) {
    final bool tablet = isTablet(MediaQuery.of(context));
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    double fontSize = tablet ? hp(2.8) : hp(2.00);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var layoutwidth = tablet ? height * 0.20 : width * 0.25;
    var layoutHeight = tablet ? height * 0.70 : height * 0.6;

    Widget panNo() {
      return RowStructure(
        imagePath: 'assets/my_account/pan_sh.png',
        child: TextfieldClassic(
          fontSize: tablet ? hp(2.7) : hp(2.1),
          paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
          labelText: "PAN Number",
          alwaysFocus: true,
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
              ),
            ),
          );
        },
      ));
    }

    Widget kycDate() {
      return RowStructure(
        imagePath: 'assets/my_account/pan_sh.png',
        child: TextfieldClassic(
          fontSize: tablet ? hp(2.7) : hp(2.1),
          paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
          labelText: "KYC Date",
          //alwaysFocus: true,
          //hintText: "AAAPL1234C",
          showClearButton: false,
          customIcon: ButtonGradiant(
            tablet ? hp(1.3) : wp(2),
            tablet ? wp(11.5) : wp(30),
            'VIEW KYC',
            textStyle: TextStyle(
                fontSize: tablet ? hp(2) : wp(3.4),
                letterSpacing: tablet ? 0 : 1.5,
                color: AppColors.PrimaryWhite,
                fontWeight: FontWeight.w600),
            onPressed: () {
              tablet
                  ? _showKYCDialog("View KYC")
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (_) => ViewUploadKycScreen(
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
        child: TextfieldDropdown(
          items: [
            {"name": "Individual", "value": 0},
            {"name": "Individual", "value": 1},
            {"name": "Individual", "value": 2}
          ],
          paddingBottomInput: hp(0.8),
          fontSize: fontSize,
          labelText: "Type",
        ),
      );
    }

    Widget yearlyRevenue() {
      return RowStructure(
        imagePath: 'assets/my_account/yearly_sh.png',
        child: TextfieldDropdown(
          items: [
            {"name": "2,00,000 to 3,00,000", "value": 0},
            {"name": "2,00,000 to 3,00,000", "value": 1},
            {"name": "2,00,000 to 3,00,000", "value": 2}
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
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return TextfieldDropdown(
                  items: snapshot.data,
                  paddingBottomInput: hp(0.8),
                  fontSize: fontSize,
                  labelText: "Industry",
                  initValue: widget.company.industryId,
                );
              } else {
                return TextfieldDropdown(
                  items: [
                    {"name": "Item Example", "value": "0"}
                  ],
                  paddingBottomInput: hp(0.8),
                  fontSize: fontSize,
                  labelText: "Industry",
                );
              }
            },
            future:
                getIndustries() /* ()async {
            return await industries
                .map((item) => {"name": item.name, "value": item.id})
                .toList();*/

            ),
      );
    }

    Widget category() {
      return RowStructure(
        imagePath: 'assets/my_account/category_sh.png',
        child: TextfieldDropdown(
          items: [
            {"name": "Restaurant", "value": 0},
            {"name": "Restaurant", "value": 1},
            {"name": "Restaurant", "value": 2},
          ],
          paddingBottomInput: hp(0.8),
          fontSize: fontSize,
          labelText: "Category",
        ),
      );
    }

    Widget buildEmployee() {
      return Padding(
        padding: EdgeInsets.only(top: tablet ? wp(0) : wp(2)),
        child: Column(
          children: <Widget>[
            type(),
            panNo(),
            kycDate(),
            yearlyRevenue(),
            industry(),
            category()
          ],
        ),
      );
    }

    return buildEmployee();
  }
}
