import 'core.dart';
import 'dart:developer';

class Log {
  static void printLog(String message) {
    if (Core().isLoggingEnabled) log(message);
  }
}
