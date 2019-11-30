import 'package:uuid/uuid.dart';

class LocalIdGenerator {
  static String generate() {
    return Uuid().v1();
  }
}
