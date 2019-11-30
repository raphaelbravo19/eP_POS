import 'package:bloc/bloc.dart';
import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:epaisa_pos/data/user/user_repository.dart';
import 'package:epaisa_pos/src/bloc/authentication_bloc.dart';
import 'package:epaisa_pos/src/bloc/authentication_event.dart';
import 'package:epaisa_pos/src/bloc/authentication_state.dart';
import 'package:epaisa_pos/src/bloc/deeplink_bloc.dart';
import 'package:epaisa_pos/src/bloc/login_bloc.dart';
import 'package:epaisa_pos/src/bloc/simple_bloc_delegate.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/views/magic_link/magic_link_screen.dart';
import 'package:epaisa_pos/src/views/main_view/main_view_screen.dart';
import 'package:epaisa_pos/src/views/splashscreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:jaguar/jaguar.dart';
import 'package:jaguar_flutter_asset/jaguar_flutter_asset.dart';
import 'dart:io';

import 'package:provider/provider.dart';

final flutterWebviewPlugin = new FlutterWebviewPlugin();

void main() async {
  var isIOS = Platform.isIOS;

  if (isIOS) {
    print("");
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));
  }

  /* final server = Jaguar();
  server.addRoute(serveFlutterAssets());
  await server.serve(logRequests: true);
  server.log.onRecord.listen((r) => print(r));*/
  final UserRepository userRepository = UserRepository();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  // EncryptHelper().test();
  // runApp(MyApp())
  runApp(
    Provider<DeepLinkBloc>(
      builder: (_) => new DeepLinkBloc(),
      child: PocWidget(
        userRepository: userRepository,
      ),
    ),
  );
}

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  double _statusBarHeight = 0.0;
  StatusBarAnimation _statusBarAnimation = StatusBarAnimation.NONE;
  var isIOS = Platform.isIOS;

  @override
  void initState() {
    print("HOLA");
    final initial = Initial();
    initial.init().then((_) => print('Data is Ready!'));
    precacheImage(
        AssetImage("assets/loginscreen/background_landscape.png"), context);
    Multilanguage.setLanguage(
      path: 'assets/json/en.json',
      context: context,
    );
    if (!isIOS) {
      initPlatformState();
      updateStatusBar();
    }
    super.initState();
  }

  Future<void> initPlatformState() async {
    double statusBarHeight;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      statusBarHeight = await FlutterStatusbarManager.getHeight;
    } on PlatformException {
      statusBarHeight = 0.0;
    }
    if (!mounted) return;

    setState(() {
      _statusBarHeight = statusBarHeight;
    });
  }

  void updateStatusBar() {
    FlutterStatusbarManager.setColor(Color(0xFF174285).withOpacity(0),
        animated: false);
    FlutterStatusbarManager.setHidden(false,
        animation: StatusBarAnimation.NONE);
    FlutterStatusbarManager.setStyle(StatusBarStyle.LIGHT_CONTENT);
  }

  Future getPersistance() async {
    var currentUser = await loginBloc.getPersistance();
    return currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ePaisa Pos',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: AppColors.PrimaryBlue, fontFamily: "Montserrat"),
        home: FutureBuilder(
            future: getPersistance(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return SplashScreen(
                  logged: snapshot.data,
                );
              } else {
                return Container(
                  color: Colors.white,
                );
              }
            }));
  }
}

class PocWidget extends StatefulWidget {
  final UserRepository userRepository;
  PocWidget({Key key, this.userRepository}) : super(key: key);

  @override
  _PocWidgetState createState() => _PocWidgetState();
}

class _PocWidgetState extends State<PocWidget> {
  @override
  void initState() {
    precacheImage(
        AssetImage("assets/loginscreen/background_landscape.png"), context);
    Multilanguage.setLanguage(
      path: 'assets/json/en.json',
      context: context,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DeepLinkBloc _bloc = Provider.of<DeepLinkBloc>(context);
    return StreamBuilder<String>(
      stream: _bloc.state,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return App();
        } else {
          print('Redirected: ${snapshot.data}');

          return MaterialApp(
            title: 'ePaisa Pos',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primaryColor: AppColors.PrimaryBlue, fontFamily: "Montserrat"),
            home: SplashScreen(
              magic: snapshot.data,
            ),
          );
        }
      },
    );
  }
}
