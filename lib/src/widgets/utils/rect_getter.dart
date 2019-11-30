import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RectGetter extends StatefulWidget {
  final GlobalKey<_RectGetterState> key;
  final Widget child;

  static Rect getRectFromKey(GlobalKey<_RectGetterState> globalKey) {
    var object = globalKey?.currentContext?.findRenderObject();
    var translation = object?.getTransformTo(null)?.getTranslation();
    var size = object?.semanticBounds?.size;

    if (translation != null && size != null) {
      return new Rect.fromLTWH(
          translation.x, translation.y, size.width, size.height);
    } else {
      return null;
    }
  }

  static GlobalKey<_RectGetterState> createGlobalKey() {
    return new GlobalKey<_RectGetterState>();
  }

  RectGetter({@required this.key, @required this.child}) : super(key: key);

  factory RectGetter.defaultKey({@required Widget child}) {
    return new RectGetter(
      key: new GlobalKey(),
      child: child,
    );
  }

  Rect getRect() {
    return getRectFromKey(this.key);
  }

  RectGetter clone() {
    return new RectGetter.defaultKey(
      child: this.child,
    );
  }

  @override
  _RectGetterState createState() => new _RectGetterState();
}

class _RectGetterState extends State<RectGetter> {
  @override
  Widget build(BuildContext context) => widget.child;
}
