import 'dart:async';
import 'dart:io';

import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_recognition/speech_recognition.dart';

const languages = const [
  const Language('Francais', 'fr_FR'),
  const Language('English', 'en_US'),
  const Language('Pусский', 'ru_RU'),
  const Language('Italiano', 'it_IT'),
  const Language('Español', 'es_ES'),
];

class Language {
  final String name;
  final String code;

  const Language(this.name, this.code);
}

class SearchField extends StatefulWidget {
  final double paddingVertical;
  final double paddingHorizontal;
  final double fontSize;
  final String hintText;
  final Function asignController;
  final Function callback;
  SearchField({
    Key key,
    this.paddingVertical = 0,
    this.paddingHorizontal = 0,
    this.fontSize,
    this.hintText = "",
    this.callback,
    this.asignController,
  }) : super(key: key);

  @override
  SearchFieldState createState() => SearchFieldState();
}

class SearchFieldState extends State<SearchField> {
  SpeechRecognition _speech;
  final myController = TextEditingController();
  bool _speechRecognitionAvailable = false;
  bool _isListening = false;
  bool _micOn = false;
  Timer _onTimer = null;
  String transcription = '';
  Timer _pressDelay = null;
  var canPress = true;
  Language selectedLang = languages[1];

  @override
  initState() {
    super.initState();
    activateSpeechRecognizer();
    myController.addListener(() {
      if (widget.callback != null) {
        widget.callback(myController.text);
      }
    });

    if (widget.asignController != null) {
      widget.asignController(myController);
    }
  }

  @override
  void dispose() {
    myController.dispose();
    stop();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  void activateSpeechRecognizer() {
    print('_MyAppState.activateSpeechRecognizer... ');
    _speech = new SpeechRecognition();
    _speech.setAvailabilityHandler(onSpeechAvailability);
    _speech.setCurrentLocaleHandler(onCurrentLocale);
    _speech.setRecognitionStartedHandler(onRecognitionStarted);
    _speech.setRecognitionResultHandler(onRecognitionResult);
    _speech
        .setRecognitionCompleteHandler((value) => onRecognitionComplete(value));
    _speech.setErrorHandler(errorHandler);
    _speech
        .activate()
        .then((res) => setState(() => _speechRecognitionAvailable = res));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            vertical: widget.paddingVertical * 0.2,
            horizontal: widget.paddingHorizontal * 0.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.paddingVertical * 0.5),
          color: AppColors.PrimaryWhite,
          boxShadow: [
            new BoxShadow(
                color: AppColors.DarkGray.withOpacity(0.8),
                offset: new Offset(0.6, 1.0),
                blurRadius: 1.0)
          ],
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: widget.paddingVertical * 0.8,
                    horizontal: widget.paddingHorizontal * 0.5),
                child: TextField(
                  style: TextStyle(fontSize: widget.fontSize),
                  controller: myController,
                  decoration: InputDecoration.collapsed(
                    border: InputBorder.none,
                    hintText: _micOn ? 'Listening... (Click mic to finish)' : widget.hintText,
                    hintStyle: TextStyle(
                        fontSize: widget.fontSize * 0.87,
                        fontWeight: FontWeight.w700,
                        color: AppColors.LightGray),
                  ),
                ),
              ),
            ),
            GestureDetector(
              //onTapDown: ,
              /*onTapDown: (val) async {
                if (!_micOn) {
                  if (canPress) {
                    setState(() {
                      _micOn = true;
                    });
                    transcription = "";
                    myController.clear();
                    Map<PermissionGroup, PermissionStatus> permissions =
                        await PermissionHandler()
                            .requestPermissions([PermissionGroup.speech]);

                    start();
                  }
                }
              },
              onTapUp: (va) {
                if (canPress && _micOn) {
                  myController.text = transcription;
                  _onTimer?.cancel();
                  setState(() {
                    _micOn = false;
                  });
                  stop();
                  canPress = false;
                  _pressDelay?.cancel();
                  _pressDelay = new Timer(Duration(milliseconds: 700), () {
                    canPress = true;
                  });
                }
              },*/
              onTap: () async {
                //start();
                if (!_micOn) {
                  if (canPress) {
                    setState(() {
                      _micOn = true;
                    });
                    transcription = "";
                    myController.clear();
                    /*Map<PermissionGroup, PermissionStatus> permissions =
                        await PermissionHandler()
                            .requestPermissions([PermissionGroup.speech]);*/

                    start();

                    if (Platform.isIOS) {
                      _onTimer?.cancel();
                      _onTimer = new Timer(Duration(milliseconds: 2000), () {
                        stop();
                      });
                      canPress = false;
                      _pressDelay?.cancel();
                      _pressDelay = new Timer(Duration(milliseconds: 700), () {
                        canPress = true;
                      });
                    }
                  }
                } else {
                  if (canPress) {
                    myController.text = transcription;
                    _onTimer?.cancel();
                    /*setState(() {
                      _micOn = false;
                    });*/
                    stop();
                    //canPress = false;
                    _pressDelay?.cancel();
                    _pressDelay = new Timer(Duration(milliseconds: 700), () {
                      canPress = true;
                    });
                  }
                }
              },
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.only(left: widget.fontSize * 0.5),
                child: Image.asset(
                  "assets/payments/mic.png",
                  height: widget.fontSize * 1.5,
                  colorBlendMode: BlendMode.srcIn,
                  color: _micOn ? Colors.red : AppColors.BackPrimaryGray,
                ),
              ),
            )
          ],
        ));
  }

  List<CheckedPopupMenuItem<Language>> get _buildLanguagesWidgets => languages
      .map((l) => new CheckedPopupMenuItem<Language>(
            value: l,
            checked: selectedLang == l,
            child: new Text(l.name),
          ))
      .toList();

  void _selectLangHandler(Language lang) {
    setState(() => selectedLang = lang);
  }

  void changeText(String text) {
    myController.text = text;
  }

  Widget _buildButton({String label, VoidCallback onPressed}) => new Padding(
      padding: new EdgeInsets.all(12.0),
      child: new RaisedButton(
        color: Colors.cyan.shade600,
        onPressed: onPressed,
        child: new Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ));

  void start() {
    _speech
        .listen(locale: selectedLang.code)
        .then((result) => print('_MyAppState.start => result $result'));
  }

  void cancel() {
    _speech.cancel().then((result) => setState(() {
          _isListening = !result;
          _micOn = !result;
        }));
  }

  void stop() {
    _speech.stop().then((result) {
      setState(() {
        _isListening = result;
        _micOn = result;
        canPress = !result;
      });
    });
  }

  void onSpeechAvailability(bool result) =>
      setState(() => _speechRecognitionAvailable = result);

  void onCurrentLocale(String locale) {
    print('_MyAppState.onCurrentLocale... $locale');
    setState(
        () => selectedLang = languages.firstWhere((l) => l.code == locale));
  }

  void onRecognitionStarted() => setState(() => _isListening = true);

  void onRecognitionResult(String text) {
    setState(() => transcription = text);
    /* if (Platform.isIOS) {
      _onTimer?.cancel();
      _onTimer = new Timer(Duration(milliseconds: 700), () {
        stop();
        myController.text = transcription;
        setState(() {
          _isListening = false;
          _micOn = false;
        });
      });
    } */
  }

  void onRecognitionComplete(String value) {
    myController.text = value;
    setState(() {
      _isListening = false;
      _micOn = false;
    });
  }

  void errorHandler() => activateSpeechRecognizer();
}
