import 'dart:async';
import 'dart:convert';

import 'package:epaisa_pos/data/initial/countries/api_service.dart';
import 'package:epaisa_pos/src/logic/personal_bloc/personal_bloc.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/validators/Validator.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient.dart';
import 'package:epaisa_pos/src/widgets/cards/toggle_card.dart';
import 'package:epaisa_pos/src/widgets/header_card/header_widget.dart';
import 'package:epaisa_pos/src/views/employee/widgets/row_structure.dart';
import 'package:epaisa_pos/src/widgets/textfields/texfield_number.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_dropdown.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_password.dart';
import 'package:epaisa_pos/src/widgets/utils/dialogs_helper.dart';
import 'package:epaisa_pos/src/widgets/utils/request_helper.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class PasswordWidget extends StatefulWidget {
  @override
  _PasswordWidgetState createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  ChangePasswordBloc bloc = ChangePasswordBloc();

  @override
  Widget build(BuildContext context) {
    final bool tablet = isTablet(MediaQuery.of(context));
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    double fontSize = tablet ? hp(2.8) : hp(2.00);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var layoutwidth = tablet ? height * 0.55 : width * 0.85;
    var layoutHeight = tablet ? height : height * 0.8;

    Widget passwordStructure({Widget child, String infoText}) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: tablet ? hp(2) : wp(5),
          ),
          child,
          Text(
            infoText,
            style: TextStyle(
              fontSize: tablet ? hp(2) : wp(3),
              color: AppColors.DisabledText,
            ),
          )
        ],
      );
    }

    Widget buildCurrentPassword() {
      return passwordStructure(
          infoText: 'Please enter current password',
          child: TextfieldPassword(
            stream: bloc.currentPassword,
            paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
            fontSize: tablet ? hp(2.7) : hp(2.1),
            labelText: "Current Password",
            onChanged: (str) {
              bloc.changeCurrent(str);
              print(bloc.currentStream.value);
            },
          ));
    }

    Widget newPasswordStructure() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: tablet ? hp(2) : wp(5),
          ),
          TextfieldPassword(
            stream: bloc.newPassword,
            paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
            fontSize: tablet ? hp(2.7) : hp(2.1),
            labelText: "New Password",
            onChanged: (str) {
              bloc.changeNew(str);
            },
            showValidations: true,
            alwaysValidations: true,
          ),
        ],
      );
    }

    Widget buildConfirmPassword() {
      return passwordStructure(
          infoText: 'Please re-type password',
          child: TextfieldPassword(
            stream: bloc.renewPassword,
            paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
            fontSize: tablet ? hp(2.7) : hp(2.1),
            labelText: "Re-Type New Password",
            onChanged: (str) {
              bloc.changeRenew(str);
            },
          ));
    }

    Widget saveButton() {
      return ButtonGradiant(
        layoutHeight * 0.025,
        layoutwidth,
        'SAVE',
        textStyle: TextStyle(
            fontSize: tablet ? layoutHeight * 0.03 : layoutHeight * 0.025,
            color: AppColors.PrimaryWhite,
            fontWeight: FontWeight.w600),
        onPressed: () async {
          showLoading(context);
          await bloc.changePassword(context);
        },
      );
    }

    Widget buildPassword() {
      return Padding(
        padding: EdgeInsets.only(
            left: wp(7), right: wp(7), top: tablet ? hp(0.1) : wp(3)),
        child: Column(
          children: <Widget>[
            buildCurrentPassword(),
            newPasswordStructure(),
            buildConfirmPassword(),
            SizedBox(height: tablet ? hp(2) : wp(5)),
            saveButton(),
            //name(),
          ],
        ),
      );
    }

    return buildPassword();
  }
}

class ChangePasswordBloc extends Object with Validators {
  final currentStream = BehaviorSubject<String>.seeded("");
  final newStream = BehaviorSubject<String>.seeded("");
  final renewStream = BehaviorSubject<String>.seeded("");
  //final sameStream = BehaviorSubject<bool>.seeded(false);
  //final _password = BehaviorSubject<String>();
  final api = ApiService.create();

  Stream<String> get currentPassword =>
      currentStream.stream.transform(validatePassword);
  Stream<String> get newPassword =>
      newStream.stream.transform(validatePassword);
  Stream<String> get renewPassword =>
      renewStream.stream.transform(validatePassword);
  /* Stream<String> get renewPassword =>
      renewStream.stream.transform(validatePassword);
 */
  Function(String) get changeCurrent => currentStream.sink.add;
  Function(String) get changeNew => newStream.sink.add;
  Function(String) get changeRenew => renewStream.sink.add;
  //Function(String) get changePassword => _password.sink.add;

  changePassword(context) async {
    var token = await getauthkey();
    var userid = await getuserid();
    var merchantid = await getmerchantid();

    try {
      var params = {
        "id": userid,
        "merchantId": merchantid,
        "password": newStream.value != null ? newStream.value : "",
        "currentPassword":
            currentStream.value != null ? currentStream.value : ""
      };

      print("PARAMS $params");

      var res = await api.changePassword(authKey: token, body: params);
      var message = res.body;
      print(message);
      Navigator.pop(context);
      showDialogMessage(context, "Password Successfully Updated", () {});
    } catch (e) {
      print(e);
      if (e.body != null) {
        Navigator.pop(context);
        showDialogMessage(context, json.decode(e.body)["message"], () {});
      }
    }
  }

  dispose() {
    print('dispose');
    currentStream.close();
    newStream.close();
    renewStream.close();
  }
}
