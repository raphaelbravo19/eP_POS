import 'dart:async';

import 'package:flutter/services.dart';

class BiometricPlugin {
  static const MethodChannel _channel = const MethodChannel('biometric_plugin');

  static Future<Map<dynamic, dynamic>> isSensorAvailable() async {
    return await _channel.invokeMethod('isSensorAvailable');
  }

  static Future<Map<dynamic, dynamic>> deleteKeys() async {
    return await _channel.invokeMethod('deleteKeys');
  }

  static Future<Map<dynamic, dynamic>> createKeys(String title) async {
    return await _channel
        .invokeMethod('createKeys', <String, String>{'title': title});
  }

  static Future<Map<dynamic, dynamic>> simplePrompt(String title) async {
    return await _channel
        .invokeMethod('simplePrompt', <String, String>{'title': title});
  }

  static Future<Map<dynamic, dynamic>> createSignature(
      String title, String payload) async {
    return await _channel.invokeMethod('createSignature', <String, String>{
      'title': title,
      'payload': payload,
    });
  }
}
