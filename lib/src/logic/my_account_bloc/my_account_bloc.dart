import 'package:rxdart/rxdart.dart';

class MyAccountBloc {
  final selectedMyAccountOption = BehaviorSubject<String>();

  Stream<String> get selectedMyAccountOptionStream =>
      selectedMyAccountOption.stream;
  Sink<String> get selectedMyAccountOptionSink => selectedMyAccountOption.sink;

  void dispose() {
    selectedMyAccountOption.close();
  }
}

MyAccountBloc myAccountBloc = MyAccountBloc();
