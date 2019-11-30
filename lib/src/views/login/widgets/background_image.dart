import 'package:flutter/material.dart';

class BackgroundImage {
  static BoxDecoration buildBackgroundImage({tablet = false}) {
    return BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage(
            'assets/loginscreen/background${tablet ? "_landscape" : ""}.png'),
      ),
    );
  }

  static BoxDecoration buildBackgroundImageWhite() {
    return BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage('assets/loginscreen/white_background.png'),
      ),
    );
  }
}
