import 'dart:async';
import 'dart:convert';

import 'package:epaisa_pos/data/initial/countries/api_service.dart';
import 'package:epaisa_pos/src/validators/Validator.dart';
import 'package:epaisa_pos/src/widgets/utils/dialogs_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class MagicBloc extends Object with Validators {
  final semail = BehaviorSubject<String>();
  final smobile = BehaviorSubject<String>();

  // Add data to stream
  Stream<String> get email => semail.stream.transform(validateMagicEmail);
  Stream<String> get mobile => smobile.stream.transform(validateMagicNumber);

  Function(String) get changeMail => semail.sink.add;
  Function(String) get changeMobile => smobile.sink.add;

  void sendEmail(str, ctx) async {
    try {
      var receiver = str;
      var type = 1;
      if (receiver != '') {
        var res = await ApiService.create()
            .login({"loginType": 2, "receiver": receiver, "type": type});
        print(res.body);
        var message = "We sent you a mail";
        Navigator.pop(ctx);
        showDialogMessage(ctx, message, () {});
      } else {
        Navigator.pop(ctx);
      }
    } catch (e) {
      print(e.body);
      Navigator.pop(ctx);
      showDialogMessage(ctx, json.decode(e.body)["message"], () {});
    }
  }

  void sendMobile(str, ctx) async {
    try {
      var receiver = str;
      var type = 2;
      if (receiver != '') {
        var res = await ApiService.create()
            .login({"loginType": 2, "receiver": receiver, "type": type});
        print(res.body);

        var message = "We sent you a sms";
        Navigator.pop(ctx);
        showDialogMessage(ctx, message, () {});
      } else {
        Navigator.pop(ctx);
      }
    } catch (e) {
      print(e.body);
      Navigator.pop(ctx);
      showDialogMessage(ctx, json.decode(e.body)["message"], () {});
    }
  }

  dispose() {
    print('dispose');
    semail.close();
    smobile.close();
  }
}
