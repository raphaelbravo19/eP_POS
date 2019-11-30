import 'package:bloc/bloc.dart';

import 'NavigationRoute.dart';

class Navigation extends Bloc<NavigationEvent, NavigationRoute> {
  @override
  NavigationRoute get initialState => NavigationRoute.SCREEN1;

  @override
  Stream<NavigationRoute> mapEventToState(NavigationEvent event) async* {
    switch (event) {
      case NavigationEvent.SCREEN1:
        yield NavigationRoute.SCREEN1;
        break;
      case NavigationEvent.SCREEN2:
        yield NavigationRoute.SCREEN2;
        break;
      case NavigationEvent.SCREEN3:
        yield NavigationRoute.SCREEN3;
        break;
      default:
        yield NavigationRoute.SCREEN1;
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}

Navigation navigation = Navigation();
