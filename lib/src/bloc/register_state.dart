import 'package:epaisa_pos/src/validators/Validators.dart';
import 'package:meta/meta.dart';

typedef TestFunction = bool Function(String value);

class ValidationTest {
  final String name;
  bool passed;
  final TestFunction test;
  ValidationTest({this.name, this.passed = false, this.test});
}

abstract class IValidationField {
  bool touched;
  bool valid;
  dynamic value;
  IValidationField({
    @required this.touched,
    @required this.valid,
  });
}

class CeValidationField {
  Map<String, ValidationTest> validations;
  CeValidationField({
    this.validations,
  });

  addValidation(String name, TestFunction test) {
    if (validations == null) {
      validations = {};
    }

    validations[name] = ValidationTest(name: name, test: test);
  }

  bool runValidations(String value) {
    final List<String> errors = [];
    validations.forEach((name, test) {
      if (test.test(value)) {
        test.passed = true;
      } else {
        test.passed = false;
        errors.add(test.name);
        // throw 'Failed on ${test.name} validation.';
      }
    });
    return errors.isEmpty;
  }

  ValidationTest getValidation(String name) {
    // print('getValidation');
    // print(validations);
    if (validations[name] == null) {
      return null;
    }
    return validations[name];
  }
}

class CePasswordField extends CeValidationField implements IValidationField {
  bool touched;
  bool valid;
  var value;
  CePasswordField({
    this.touched = false,
    this.valid = false,
    this.value,
  }) {
    this.addValidation('length', (value) {
      return Validators.minLength(value);
    });
    this.addValidation('special', (value) {
      return Validators.oneSpecial(value);
    });
    this.addValidation('number', (value) {
      return Validators.oneNumber(value);
    });
  }

  validate(value) {
    valid = runValidations(value);
  }
}

class CeTextField extends CeValidationField implements IValidationField {
  bool touched;
  bool valid;
  var value;
  CeTextField({
    this.touched = false,
    this.valid = false,
    this.value,
  });
}

@immutable
class RegisterState {
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool isTouched;
  final bool sellerAgreementAccepted;
  final bool eSignConcentAccepted;
  final CeTextField email;
  final CeTextField firstName;
  final CeTextField lastName;
  final CeTextField mobileNumber;
  final CeTextField industry;
  final CeTextField businessType;
  final CePasswordField password;

  bool get isFormValid {
    return firstName.valid &&
        lastName.valid &&
        email.valid &&
        mobileNumber.valid &&
        password.valid &&
        industry.valid &&
        businessType.valid &&
        eSignConcentAccepted &&
        sellerAgreementAccepted;
  }

  bool get termsAccepted => sellerAgreementAccepted && eSignConcentAccepted;

  RegisterState({
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
    @required this.isTouched,
    @required this.email,
    @required this.firstName,
    @required this.lastName,
    @required this.mobileNumber,
    @required this.password,
    @required this.sellerAgreementAccepted,
    @required this.eSignConcentAccepted,
    @required this.industry,
    @required this.businessType,
  });

  factory RegisterState.empty() {
    return RegisterState(
      password: CePasswordField(),
      mobileNumber: CeTextField(),
      email: CeTextField(),
      firstName: CeTextField(),
      lastName: CeTextField(),
      industry: CeTextField(),
      businessType: CeTextField(),
      isTouched: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      eSignConcentAccepted: false,
      sellerAgreementAccepted: false,
    );
  }

  // factory RegisterState.loading() {
  //   return RegisterState(
  //     password: CePasswordField(),
  //     email: CeTextField(),
  //     firstName: CeTextField(),
  //     lastName: CeTextField(),
  //     mobileNumber: CeTextField(),
  //     industry: CeTextField(),
  //     businessType: CeTextField(),
  //     isTouched: true,
  //     isSubmitting: true,
  //     isSuccess: false,
  //     isFailure: false,
  //     eSignConcentAccepted: true,
  //     sellerAgreementAccepted: true,
  //   );
  // }

  // factory RegisterState.failure() {
  //   return RegisterState(
  //     password: CePasswordField(),
  //     email: CeTextField(),
  //     firstName: CeTextField(),
  //     lastName: CeTextField(),
  //     mobileNumber: CeTextField(),
  //     industry: CeTextField(),
  //     businessType: CeTextField(),
  //     isTouched: true,
  //     isSubmitting: false,
  //     isSuccess: false,
  //     isFailure: true,
  //     eSignConcentAccepted: true,
  //     sellerAgreementAccepted: true,
  //   );
  // }

  // factory RegisterState.success() {
  //   return RegisterState(
  //     password: CePasswordField(),
  //     email: CeTextField(),
  //     firstName: CeTextField(),
  //     lastName: CeTextField(),
  //     mobileNumber: CeTextField(),
  //     industry: CeTextField(),
  //     businessType: CeTextField(),
  //     isTouched: true,
  //     isSubmitting: false,
  //     isSuccess: true,
  //     isFailure: false,
  //     eSignConcentAccepted: true,
  //     sellerAgreementAccepted: true,
  //   );
  // }

  RegisterState update({
    CeTextField email,
    CeTextField mobileNumber,
    CeTextField firstName,
    CeTextField lastName,
    CePasswordField password,
    CeTextField industry,
    CeTextField businessType,
    bool isTouched,
    Map passwordValidations,
    bool eSignConcentAccepted,
    bool sellerAgreementAccepted,
  }) {
    return copyWith(
      email: email,
      password: password,
      mobileNumber: mobileNumber,
      firstName: firstName,
      lastName: lastName,
      industry: industry,
      businessType: businessType,
      isTouched: isTouched,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      eSignConcentAccepted: eSignConcentAccepted,
      sellerAgreementAccepted: sellerAgreementAccepted,
    );
  }

  RegisterState copyWith({
    CeTextField email,
    CeTextField firstName,
    CeTextField lastName,
    CeTextField mobileNumber,
    CeTextField industry,
    CeTextField businessType,
    CePasswordField password,
    bool isTouched,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
    bool eSignConcentAccepted,
    bool sellerAgreementAccepted,
  }) {
    return RegisterState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      password: password ?? this.password,
      industry: industry ?? this.industry,
      businessType: businessType ?? this.businessType,
      isTouched: isTouched ?? this.isTouched,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      eSignConcentAccepted: eSignConcentAccepted ?? this.eSignConcentAccepted,
      sellerAgreementAccepted:
          sellerAgreementAccepted ?? this.sellerAgreementAccepted,
    );
  }

  @override
  String toString() {
    return '''RegisterState {
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      isTouched: $isTouched,
    }''';
  }
}
