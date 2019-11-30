import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double height;

  Logo(this.height, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/loginscreen/ep_logo.png',
      height: height,
    );
  }
}
