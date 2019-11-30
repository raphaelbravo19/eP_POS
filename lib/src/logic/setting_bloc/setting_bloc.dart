import 'package:rxdart/rxdart.dart';

class SettingBloc {
  final _showHardwareController = BehaviorSubject<bool>.seeded(false);
  final _selectedSettingNameController = PublishSubject<String>();
  final _filterSettingQuery = BehaviorSubject<String>();
  Stream<bool> get showHardwareStream => _showHardwareController.stream;
  Sink<bool> get showHardwareSink => _showHardwareController.sink;

  Stream<String> get selectedSettingNameStream =>
      _selectedSettingNameController.stream;
  Sink<String> get selectedSettingNameSink =>
      _selectedSettingNameController.sink;

  Stream<String> get filterSettingQueryStream => _filterSettingQuery.stream;
  Sink<String> get filterSettingQuerySink => _filterSettingQuery.sink;
  void dispose() {
    _showHardwareController.close();
    _selectedSettingNameController.close();
    _filterSettingQuery.close();
  }
}
