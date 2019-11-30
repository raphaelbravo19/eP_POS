import 'dart:async';

import 'package:epaisa_pos/data/initial/countries/api_service.dart';
import 'package:epaisa_pos/src/validators/Validator.dart';
import 'package:epaisa_pos/src/widgets/utils/dialogs_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class CreateAccountBloc extends Object with Validators {
  final _email = BehaviorSubject<String>();
  final _firstName = BehaviorSubject<String>();
  final _lastName = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _number = BehaviorSubject<String>();
  final _industry = BehaviorSubject<String>();
  final _type = BehaviorSubject<String>();
  final api = ApiService.create();
  //final _password = BehaviorSubject<String>();

  // Add data to stream
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get firstName =>
      _firstName.stream.transform(validateFirstName);
  Stream<String> get lastName => _lastName.stream.transform(validateLastName);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<String> get number => _number.stream.transform(validateNumber);
  Stream<String> get industry => _industry.stream.transform(validateEmpty);
  Stream<String> get type => _type.stream.transform(validateEmpty);
  Stream<bool> get createValid => Observable.combineLatest5(email, firstName,
      lastName, password, number, (em, fn, ln, pw, nb) => true);
  //Stream<String> get password => _password.stream.transform(validatePassword);

  // Stream<bool> get savecardValid =>
  //     Observable.combineLatest2(email, password, (em, pw) => true);

  // Change data
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changeFirstname => _firstName.sink.add;
  Function(String) get changeLastName => _lastName.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changeNumber => _number.sink.add;
  Function(String) get changeIndustry => _industry.sink.add;
  Function(String) get changeType => _type.sink.add;
  void Create(String completenumber, BuildContext ctx, Function success,
      String valueIndustry, String valueType) async {
    Map<String, dynamic> params = {
      "firstName": _firstName.value,
      "lastName": _lastName.value,
      "username": _email.value,
      "password": _password.value,
      "mobile": completenumber,
      "industry": valueIndustry,
      "type": valueType
    };
    print(params);
    showLoading(ctx);
    try {
      var res = await api.register(params);
      print(res.body);
      print(res.body["object"]);
      if (res.body["object"] == "error") {
        Navigator.pop(ctx);
        showDialogMessage(ctx, res.body["message"],(){});
      } else {
        Navigator.pop(ctx);
        success();
      }
    } catch (e) {
      print(e);
      //var error = json.decode(e.body);
      //showDialogMessage(ctx, error["message"]);
    }
  }

  dispose() {
    print('dispose');
    _email.close();
    _firstName.close();
    _lastName.close();
    _password.close();
    _number.close();
    _industry.close();
    _type.close();
     //_changePasswordEventController.close();
    // _passwordVisibilityStreamController.close();
    // passwordVisibilitySink.close();
    // // _loginController.close();
  }
}

CreateAccountBloc createAccountBloc = CreateAccountBloc();
