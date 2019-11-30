import 'package:epaisa_pos/src/bloc/bloc.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/employee/widgets/row_structure.dart';
import 'package:epaisa_pos/src/views/personal/widgets/personal_widget.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/textfields/texfield_number.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_dropdown.dart';
import 'package:epaisa_pos/src/logic/personal_bloc/personal_bloc.dart';
import 'package:flutter/material.dart';
import 'package:epaisa_pos/src/widgets/dialogs/dialog_common.dart';
import 'package:epaisa_pos/src/widgets/header_card/header_widget.dart';

class AddEmployee extends StatelessWidget {
  final personBloc = PersonalBloc();
  final locationBloc = LocationBloc();
  @override
  void dispose() {
    locationBloc.dispose();
  }

  AddEmployee({this.backaction});
  final Function backaction;
  GlobalKey<TextfieldClassicState> _controller = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final bool tablet = isTablet(MediaQuery.of(context));
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    double fontSize = tablet ? hp(2.8) : hp(2.00);
    final dialog = DialogCommon(context: context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var layoutwidth = tablet ? height * 0.20 : width * 0.25;
    var layoutHeight = tablet ? height * 0.70 : height * 0.6;

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
            )),
            Expanded(
                child: TextfieldClassic(
              leftBorder: true,
              paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
              fontSize: tablet ? hp(2.7) : hp(2.1),
              labelText: "Last Name",
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
        ),
      );
    }

    Widget mobNo() {
      return RowStructure(
        imagePath: 'assets/employee/MobileNumber.png',
        child: TextfieldNumber(
          fontSize: tablet ? hp(2.7) : hp(2.1),
          paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
          labelText: eptxt('mobile_number'),
        ),
      );
    }

    Widget birthDate() {
      return RowStructure(
        imagePath: 'assets/employee/Birthdate.png',
        onTap: () => _controller.currentState.openDate(2018, 2020),
        child: TextfieldClassic(
          key: _controller,
          fontSize: tablet ? hp(2.7) : hp(2.1),
          paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
          labelText: "Birthdate",
          disabled: true,
          onTap: () {
            _controller.currentState.openDate(2018, 2020);
          },
        ),
      );
    }

    Widget store() {
      return RowStructure(
        imagePath: 'assets/my_account/Country.png',
        child: TextfieldDropdown(
          items: [
            {"name": "Bandre West", "value": 0},
            {"name": "Bandre West A", "value": 1},
            {"name": "Bandre West B", "value": 2},
          ],
          paddingBottomInput: hp(1),
          fontSize: fontSize,
          labelText: "Store",
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

    Widget roles() {
      return RowStructure(
        imagePath: 'assets/employee/Address.png',
        child: TextfieldDropdown(
          items: [
            {"name": "Cashier", "value": 0},
            {"name": "Cashier A", "value": 1},
            {"name": "Cashier B", "value": 2},
          ],
          paddingBottomInput: hp(1),
          fontSize: fontSize,
          labelText: "Roles",
        ),
      );
    }

    Widget address2() {
      return RowStructure(
        imagePath: '',
        child: TextfieldClassic(
          fontSize: tablet ? hp(2.7) : hp(2.1),
          paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
          onChanged: personBloc.personAddress2Sink,
          stream: personBloc.personAddress2Stream,
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
                paddingBottomInput: hp(1),
                fontSize: fontSize,
                hintText: "City",
              )),
              Expanded(
                  child: TextfieldDropdown(
                leftBorder: true,
                paddingBottomInput: hp(1),
                items: [
                  {"name": "MH", "value": 0},
                  {"name": "UP", "value": 1},
                  {"name": "MP", "value": 2},
                ],
                fontSize: fontSize,
              ))
            ],
          ));
    }

    Widget AddEmployee() {
      return Column(children: <Widget>[Container(
        // margin: EdgeInsets.only(top: hp(2)),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
            horizontal: tablet ? wp(2) : wp(4),
            vertical: hp(2.6)),
        decoration: BoxDecoration(
          color: AppColors.PrimaryWhite,
          image: DecorationImage(
            image: AssetImage('assets/splashscreen/background.png'),
            alignment: Alignment.center,
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
                color: AppColors.DarkGray.withOpacity(0.4),
                offset: Offset(0, 4.0),
                blurRadius: 3.0)
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: hp(0.5)),
              height: tablet ? hp(15) : hp(11),
              width: tablet ? hp(15) : hp(11),
              child: Stack(
                alignment: Alignment.center,
                fit: StackFit.expand,
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(
                        tablet ? hp(7.5) : hp(6),
                      ),
                      child: Image.asset(
                        'assets/employee/userplaceholder.png',
                        color:
                        AppColors.Black.withOpacity(0.21),
                      )),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Image.asset(
                      'assets/my_account/Edit.png',
                      height: tablet ? hp(4.4) : hp(4),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: hp(1.3),
            ),
            Text(
              "Full Name",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: tablet ? hp(2.5) : wp(4.6),
                  color: AppColors.DarkGray),
            ),
            // ProfileImageButton(
            //   account: account,
            //   size: tablet ? hp(15) : hp(10),
            // ),
            // name(),
          ],
        ),
      ),
        SizedBox(
          height: hp(1),
        ),],);
    }

    Widget buildEmployee() {
      return EpaisaScaffold(
        appBar: EpaisaAppBar(
          back: true,
          title: 'ADD NEW EMPLOYEE',
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        /*CommonHeader(),
                      SizedBox(
                        height: wp(tablet ? 1 : 4),
                      ),*/
                        AddEmployee(),
                        name(),
                        email(),
                        mobNo(),
                        store(),
                        roles(),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Spacer(
                        flex: 1,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: wp(5)),
                        child: ButtonGradient(
                          title: "SEND INVITE",
                          paddingVertical: hp(1.9),
                          fontSize: wp(3.5),
                          fontWeight: FontWeight.w700,
                          borderRadius: hp(2),
                        ),
                      ),
                      SizedBox(
                        height: hp(3),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
    }

    return buildEmployee();
  }
}
