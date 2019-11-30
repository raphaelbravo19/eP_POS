import 'dart:async';

import 'package:flutter/services.dart';

class FlutterOrtcPlugin {
  static const MethodChannel _channel =
      const MethodChannel('flutter_ortc_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> registerORTC(
      String userpubsubtoken, String storelocationid) async {
    return await _channel.invokeMethod('registerORTC', <String, String>{
      'userpubsubtoken': userpubsubtoken,
      'storelocationid': storelocationid
    });
  }

  static void setMethodCallHandler(Future<dynamic> handler(MethodCall call)) {
    _channel.setMethodCallHandler(handler);
  }
}
