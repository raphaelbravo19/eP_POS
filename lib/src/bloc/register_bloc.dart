import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:epaisa_pos/src/widgets/utils/dialogs_helper.dart';
import 'package:meta/meta.dart';
import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/data/initial/countries/api_service.dart';
import 'package:epaisa_pos/data/models/authenticated_users_dao.dart';
import 'package:epaisa_pos/data/models/company_dao.dart';
import 'package:epaisa_pos/data/models/stores_dao.dart';
import 'package:epaisa_pos/data/models/users_dao.dart';
import 'package:epaisa_pos/data/models/merchants_dao.dart' as p1;
import 'package:epaisa_pos/data/user/user_repository.dart';
import 'package:epaisa_pos/src/validators/Validators.dart';
import 'package:rxdart/rxdart.dart';
import './bloc.dart';

final db = AppDatabase();

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final api = ApiService.create();
  final merchantsDao = p1.MarchantsDao(db);
  final storesDao = StoresDao(db);
  final usersDao = UsersDao(db);
  final companyDao = CompanyDao(db);
  final auDao = AuthenticatedUsersDao(db);
  UserRepository _userRepository;

  RegisterBloc({
    @required UserRepository userRepository,
  }) :
        // assert(userRepository != null),
        _userRepository = userRepository;

  @override
  RegisterState get initialState => RegisterState.empty();

  @override
  Stream<RegisterState> transformEvents(
    Stream<RegisterEvent> events,
    Stream<RegisterState> Function(RegisterEvent event) next,
  ) {
    final observableStream = events as Observable<RegisterEvent>;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged);
    });
    final debounceStream = observableStream.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super
        .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is FirstNameChanged) {
      yield* _mapFirstNameChangedToState(event.firstName);
    } else if (event is LastNameChanged) {
      yield* _mapLastNameChangedToState(event.lastName);
    } else if (event is MobileNumberChanged) {
      yield* _mapMobileNumberChangedToState(event.mobileNumber);
    } else if (event is ESignConcentChanged) {
      yield* _mapESignConcentChangedToState(event.accepted);
    } else if (event is SellerAgreementChanged) {
      yield* _mapSellerAgreementChangedToState(event.accepted);
    } else if (event is IndustryChanged) {
      yield* _mapIndustryChangedToState(event.industryId);
    } else if (event is BusinessTypeChanged) {
      yield* _mapBusinessTypeChangedToState(event.businessTypeId);
    } else if (event is SubmitForm) {
      yield* _mapSubmitFormToState(event.callback);
    }
  }

  Stream<RegisterState> _mapSubmitFormToState(callback) async* {
    yield currentState.copyWith(
      isSubmitting: true,
    );
    print('Submiting...');
    
    await _userRepository.signUp(currentState);
    callback();
    yield currentState.copyWith(
      isSubmitting: false,
      isSuccess: true,
    );
    
  }

  Stream<RegisterState> _mapIndustryChangedToState(String industryId) async* {
    yield currentState.update(
      isTouched: true,
      industry: CeTextField(
        touched: true,
        valid: industryId != null && industryId != "",
        value: industryId,
      ),
    );
  }

  Stream<RegisterState> _mapBusinessTypeChangedToState(
      String businessTypeId) async* {
    yield currentState.update(
      isTouched: true,
      businessType: CeTextField(
        touched: true,
        valid: businessTypeId != null && businessTypeId != "",
        value: businessTypeId,
      ),
    );
  }

  Stream<RegisterState> _mapSellerAgreementChangedToState(
      bool accepted) async* {
    yield currentState.update(
      isTouched: true,
      sellerAgreementAccepted: accepted,
    );
  }

  Stream<RegisterState> _mapESignConcentChangedToState(bool accepted) async* {
    yield currentState.update(
      isTouched: true,
      eSignConcentAccepted: accepted,
    );
  }

  Stream<RegisterState> _mapEmailChangedToState(String email) async* {
    yield currentState.update(
      isTouched: true,
      email: CeTextField(
        touched: true,
        valid: Validators.isValidEmail(email),
        value: email,
      ),
    );
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
    final passwordField = CePasswordField(touched: true, value: password);

    passwordField.validate(password);
    yield currentState.update(
      password: passwordField,
    );
  }

  Stream<RegisterState> _mapFirstNameChangedToState(String firstName) async* {
    yield currentState.update(
      isTouched: true,
      firstName: CeTextField(
        touched: true,
        valid: Validators.isValidName(firstName),
        value: firstName,
      ),
    );
  }

  Stream<RegisterState> _mapLastNameChangedToState(String lastName) async* {
    yield currentState.update(
      isTouched: true,
      lastName: CeTextField(
        touched: true,
        valid: Validators.isValidName(lastName),
        value: lastName,
      ),
    );
  }

  Stream<RegisterState> _mapMobileNumberChangedToState(
      String mobileNumber) async* {
    yield currentState.update(
      isTouched: true,
      mobileNumber: CeTextField(
        valid: Validators.isValidMobileNumber(mobileNumber),
        touched: true,
        value: mobileNumber,
      ),
    );
  }
}
