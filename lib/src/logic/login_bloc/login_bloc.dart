import 'dart:async';

import 'package:epaisa_pos/helpers/flutter_ortc_plugin/flutter_ortc_plugin.dart';
import 'package:epaisa_pos/helpers/user_merchant_package/user_lib.dart';
import 'package:epaisa_pos/src/networking/networking.dart';
import 'package:epaisa_pos/src/validators/Validator.dart';

import './login_delegate.dart';

import 'package:rxdart/rxdart.dart';

import 'package:http/http.dart' show Response;
import 'dart:convert';

class LoginBloc extends Object with Validators {
  LoginDelegate _delegate;
  bool _isPasswordVisible = false;
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  // Add data to stream
  Stream<String> get email => _email.stream.transform(validateEmail);

  Stream<String> get password => _password.stream.transform(validatePassword);

  Stream<bool> get savecardValid =>
      Observable.combineLatest2(email, password, (em, pw) => true);

  // Change data
  Function(String) get changeEmail => _email.sink.add;

  Function(String) get changePassword => _password.sink.add;

  final _passwordVisibilityStreamController = BehaviorSubject<bool>();

  Function(bool) get changePasswordVisibility =>
      _passwordVisibilityStreamController.sink.add;

  Stream<bool> get passwordVisibility =>
      _passwordVisibilityStreamController.stream;

  final _changePasswordEventController = BehaviorSubject<bool>.seeded(true);

// expose sink for input events
  Sink<bool> get passwordVisibilitySink => _changePasswordEventController.sink;

  LoginBloc() {
// Whenever there is a new event, we want to map it to a new state
    _changePasswordEventController.stream.listen(_mapPasswordEventToState);
  }

  void _mapPasswordEventToState(bool event) {
    print('_mapPasswordEventToState');
    print(event);
    _isPasswordVisible = event;
    changePasswordVisibility(_isPasswordVisible);
  }

  submit(LoginDelegate delegate) async {
    print('submit');
    _delegate = delegate;
    print('Password${_password.value}');
    if ((_email.value == null || _email.value == "") &&
        (_password.value == null || _password.value == "")) {
      _delegate?.onError('Email and Password cannot be blank');
      return;
    } else if (_email.value == null || _email.value == "") {
      _delegate?.onError('Email cannot be blank');
      return;
    } else if (_password.value == null || _password.value == "") {
      _delegate?.onError('Password cannot be blank');
      return;
    } else if (!Validators.isEmailValid(_email.value)) {
      _delegate?.onError('Email address is not valid');
      return;
    }
    if (_password.value == null) {
      _delegate?.onError('Please enter Password');
      return;
    }
    /* else if (!Validators.isPasswordValid(_password.value)) {
      _delegate?.onError('Password is not valid');
      return;
    }
*/
    Response res = await Networking()
        .login(username: _email.value, password: _password.value);

    print("Login StatusCode: ${res.statusCode}");

    if (res.statusCode == 200) {
      final response = json.decode(res.body);
      print(res.body);
      if (response['success'] == 1) {
        AppUserInfo()
            .loginWithJsonValue(response['response'], response['merchant']);
        await FlutterOrtcPlugin.registerORTC(
            response['response']['pubsubToken'],
            response['response']['storeLocationId'].toString());
        syncData();
        _delegate.onSuccess();
      } else {
        _delegate?.onError(response['message']);
      }
    } else {
      _delegate?.onError('Something went wrong please try again');
    }
  }

  syncData() async {
//
  }

  dispose() {
    print('dispose');
    _email.close();
    _password.close();
    _changePasswordEventController.close();
    _passwordVisibilityStreamController.close();
    passwordVisibilitySink.close();
    // _loginController.close();
  }

  void clearText() {}
}

LoginBloc loginBloc = LoginBloc();
