class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static final RegExp _nameRegExp = RegExp(
    r'^[a-zA-Z]+$',
  );

  static final RegExp _mobileNumberRegExp = RegExp(r'^[0-9]+$');
  static final RegExp _minLength = RegExp(r'^.{8,}$');
  static final RegExp _atLeastOneNumber = RegExp(r'.*[0-9].*');
  static final RegExp _atLeastOneSpecial = RegExp(r'.*\W');

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email) && email != "";
  }

  static isValidName(String name) {
    return _nameRegExp.hasMatch(name) && name != "";
  }

  static minLength(String value) {
    return _minLength.hasMatch(value);
  }

  static oneNumber(String value) {
    return _atLeastOneNumber.hasMatch(value);
  }

  static oneSpecial(String value) {
    return _atLeastOneSpecial.hasMatch(value);
  }

  static Map validatePassword(String password) {
    Map validations = {
      "length": _minLength.hasMatch(password),
      "number": _atLeastOneNumber.hasMatch(password),
      "special": _atLeastOneSpecial.hasMatch(password),
    };

    return validations;
  }

  static isValidMobileNumber(String mobileNumber) {
    return _mobileNumberRegExp.hasMatch(mobileNumber) &&
        mobileNumber.length == 10;
  }
}
