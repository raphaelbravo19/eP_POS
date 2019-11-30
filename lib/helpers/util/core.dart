import 'core_builder.dart';
import 'environment.dart';

class Core {
  static final Core _instance = new Core._internal();

  factory Core() {
    return _instance;
  }

  static CoreBuilder _builder = new CoreBuilder();

  Core._internal() {
    _builder.environment = BuildEnvironment.DEVELOPMENT;
    _builder.clientId = "VyBqmaWHtyrbRSMzmbgbOy2I";
    _builder.encryptionKey = "0V7BpWR5r2Zy58ZRkHxeTKLn";
    _builder.iv = "VyBqmaWH";
    _builder.loggingEnabled = true;
  }

  set builder(CoreBuilder coreBuilder) => _builder = coreBuilder;

  bool get isLoggingEnabled => _builder.loggingEnabled;

  String get baseUrl => _builder.environment.value;

  String get clientId => _builder.clientId;

  String get encryptionKey => _builder.encryptionKey;

  String get iv => _builder.iv;
}
