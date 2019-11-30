import 'dart:async';

import 'package:email_validator/email_validator.dart';

class Validators {
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (RegExp(r"^((([a-zA-Z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-zA-Z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-zA-Z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-zA-Z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-zA-Z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-zA-Z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-zA-Z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-zA-Z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-zA-Z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-zA-Z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$")
            .hasMatch(email) ||
        email == "") {
      print("Validate Email: $email");
      sink.add(email);
    } else {
      sink.addError('Enter a valid e-mail address');
    }
  });
  final validatePanNumber =
      StreamTransformer<String, String>.fromHandlers(handleData: (pan, sink) {
    if (RegExp(r"^([a-zA-Z]){5}([0-9]){4}([a-zA-Z]){1}?$").hasMatch(pan) ||
        pan == "") {
      print("Validate Email: $pan");
      sink.add(pan);
    } else {
      sink.addError('Enter a valid PAN Number');
    }
  });
  final validateMagicEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (RegExp(r"^((([a-zA-Z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$")
            .hasMatch(email) ||
        email == "") {
      print("Validate Email: $email");
      sink.add(email);
    } else {
      sink.addError('Enter a valid e-mail address');
    }
  });
  final validateFirstName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (RegExp(r'^[a-zA-Z]+$').hasMatch(name)) {
      print("Validate Name: $name");
      sink.add(name);
    } else {
      sink.addError('Enter a valid name');
    }
  });
  final validateLastName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (RegExp(r'^[a-zA-Z]+$').hasMatch(name)) {
      print("Validate Name: $name");
      sink.add(name);
    } else {
      sink.addError('Enter a valid name');
    }
  });
  final validateMagicNumber = StreamTransformer<String, String>.fromHandlers(
      handleData: (number, sink) {
    if ((RegExp(r'^[0-9]+$').hasMatch(number) && number.length == 10 ||
        number == "")) {
      print("Validate Number: $number");
      sink.add(number);
    } else {
      sink.addError('Enter a valid number');
    }
  });
  final validateNumber = StreamTransformer<String, String>.fromHandlers(
      handleData: (number, sink) {
    if ((RegExp(r'^[0-9]+$').hasMatch(number) && number.length == 10) ||
        number == "") {
      print("Validate Number: $number");
      sink.add(number);
    } else {
      sink.addError('Enter a valid number');
    }
  });
  final validateEmpty =
      StreamTransformer<String, String>.fromHandlers(handleData: (text, sink) {
    print("validXX$text");
    if (text != '') {
      print("valid$text");
      sink.add(text);
    } else {
      sink.addError(' ');
    }
  });
  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    var a = isPasswordCharacterCountValid(password) ? "1" : "0";
    var b = isPasswordContainNumber(password) ? "1" : "0";
    var c = isPasswordContainSpecialCharacter(password) ? "1" : "0";
    if ((a == '1' && b == '1' && c == '1') || password == "") {
      print('valid true');
      sink.add(password);
    } else {
      print('$a$b$c');
      sink.addError('$a$b$c');
    }
  });
  final passwordCharacterCount = StreamTransformer<String, bool>.fromHandlers(
      handleData: (password, sink) {
    if (isPasswordCharacterCountValid(password)) {
      sink.add(true);
    } else {
      sink.addError(false);
    }
  });
  final passwordContainNumber = StreamTransformer<String, bool>.fromHandlers(
      handleData: (password, sink) {
    if (isPasswordContainNumber(password)) {
      sink.add(true);
    } else {
      sink.addError(false);
    }
  });

  final passwordContainSpecial = StreamTransformer<String, bool>.fromHandlers(
      handleData: (password, sink) {
    if (isPasswordContainSpecialCharacter(password)) {
      sink.add(true);
    } else {
      sink.addError(false);
    }
  });

  static bool isEmailValid(String email) {
    return EmailValidator.validate(email, true);
  }

  static bool isPasswordValid(String password) {
    return RegExp(r"^(?=.*[0-9A-Za-z])(?=.*[!@#$%^&*()_+])(?=\S+$).{8,}$")
        .hasMatch(password);
  }

  static bool isPasswordCharacterCountValid(String password) {
    print(password.length);
    print(password.length >= 8);
    return password.length >= 8;
  }

  static bool isPasswordContainNumber(String password) {
    return RegExp(".*\\d+.*").hasMatch(password);
  }

  static bool isPasswordContainSpecialCharacter(String password) {
    return RegExp("[^A-Za-z0-9]").hasMatch(password);
  }

  static bool validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    Pattern pattern = "^[0-9]{10}|[0-9]{9}";
    RegExp regex = new RegExp(pattern);
    if (value.length > 10 || value.length < 9) return false;
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }
}
