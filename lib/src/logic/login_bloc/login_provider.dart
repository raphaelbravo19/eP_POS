import 'package:epaisa_pos/src/logic/login_bloc/login_bloc.dart';
import 'package:flutter/material.dart';

class ProviderLogin extends InheritedWidget {
  final bloc = LoginBloc();

  ProviderLogin({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static LoginBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ProviderLogin)
            as ProviderLogin)
        .bloc;
  }
}
