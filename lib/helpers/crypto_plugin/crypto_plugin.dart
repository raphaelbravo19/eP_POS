import 'dart:async';

import 'package:flutter/services.dart';

class CryptoPlugin {
  static const MethodChannel _channel = const MethodChannel('crypto_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> encrypt(String text, String key, String iv) async {
    return await _channel.invokeMethod('encrypt', <String, String>{
      'text': text,
      'key': key,
      'iv': iv,
    });
  }

  static Future<String> decrypt(String text, String key, String iv) async {
    return await _channel.invokeMethod('decrypt', <String, String>{
      'text': text,
      'key': key,
      'iv': iv,
    });
  }
}
