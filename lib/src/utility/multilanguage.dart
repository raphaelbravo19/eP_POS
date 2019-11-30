import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class MultilanguageBloc {
  final _controller = StreamController<dynamic>.broadcast();
  Function(dynamic) get push => _controller.sink.add;
  Stream<dynamic> get stream => _controller.stream;
  var counter = 0;
  MultilanguageBloc();
  changeLanguage({context, String path}) {
    Multilanguage.setLanguage(path: path, context: context);
    push(null);
  }

  changeLanguageTest(context) {
    Multilanguage.setLanguage(
        path: counter % 2 == 0 ? Languages.en : Languages.es, context: context);
    counter++;
    push(null);
  }

  void dispose() {
    _controller.close();
  }
}

MultilanguageBloc multilangBloc = MultilanguageBloc();

class Languages {
  Languages._();
  static const String en = 'assets/json/en.json';
  static const String es = 'assets/json/es.json';
  static const String fr = 'assets/json/fr.json';
}

String _langKey = 'lang';
String current = 'assets/json/en.json';

class Multilanguage {
  static const MethodChannel _channel =
      const MethodChannel('multilanguage_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  final english = 'assets/json/en.json';
  Map<String, dynamic> phrases;
  Multilanguage(this.phrases);

  static setLanguage(
      {@required String path,
      @required BuildContext context,
      Function() onLoad,
      bool start = false}) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(_langKey) != null && start)
      path = prefs.getString(_langKey);
    var file = await DefaultAssetBundle.of(context).loadString(path);
    print('current');
    print(current);
    current = path;
    prefs.setString(_langKey, path);
    multilang = Multilanguage(jsonDecode(file));
  }

  String get(String key) {
    return phrases != null
        ? phrases[key] ?? '<not found: $key>'
        : '<not found: $key>';
  }

  String getSelected() {
    List<String> splitted = current.split('/');
    List<String> filename = splitted[splitted.length - 1].split('.');
    return filename[0];
  }
}

Multilanguage multilang = Multilanguage(null);
Function(String key) get eptxt => multilang.get;
Function(String key, {bool u}) get lang => (String key, {bool u = false}) {
      if (u) {
        return multilang.get(key).toUpperCase();
      }
      return multilang.get(key);
    };
