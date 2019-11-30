import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  RegisterEvent([List props = const []]) : super(props);
}

class FirstNameChanged extends RegisterEvent {
  final String firstName;

  FirstNameChanged({@required this.firstName}) : super([firstName]);

  @override
  String toString() => 'FirstNameChanged { firstName :$firstName }';
}

class LastNameChanged extends RegisterEvent {
  final String lastName;

  LastNameChanged({@required this.lastName}) : super([lastName]);

  @override
  String toString() => 'LastNameChanged { lastName :$lastName }';
}

class EmailChanged extends RegisterEvent {
  final String email;

  EmailChanged({@required this.email}) : super([email]);

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PasswordChanged extends RegisterEvent {
  final String password;

  PasswordChanged({@required this.password}) : super([password]);

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class MobileNumberChanged extends RegisterEvent {
  final String mobileNumber;

  MobileNumberChanged({@required this.mobileNumber}) : super([mobileNumber]);

  @override
  String toString() => 'MobileNumberChanged { mobileNumber: $mobileNumber }';
}

class ESignConcentChanged extends RegisterEvent {
  final bool accepted;
  ESignConcentChanged({this.accepted});
}

class SellerAgreementChanged extends RegisterEvent {
  final bool accepted;
  SellerAgreementChanged({this.accepted});
}

class IndustryChanged extends RegisterEvent {
  final String industryId;
  IndustryChanged({this.industryId});
}

class BusinessTypeChanged extends RegisterEvent {
  final String businessTypeId;
  BusinessTypeChanged({this.businessTypeId});
}

class SubmitForm extends RegisterEvent {
  final Function callback;

  SubmitForm({this.callback}): super([callback]);
}
