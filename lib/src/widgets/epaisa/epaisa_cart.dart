import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';

class EpaisaCart extends StatelessWidget {
  const EpaisaCart({
    Key key,
    this.size,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    final wp = ScreenUtils.of(context).wp;
    final hp = ScreenUtils.of(context).hp;
    var tablet = isTablet(MediaQuery.of(context));

    return Container(
      width: size,
      child: Stack(
        alignment: Alignment.center,
        overflow: Overflow.visible,
        children: <Widget>[
          Image.asset(
            'assets/payments/cart.png',
            height: size != null ? size : hp(tablet ? 4 : 3.5),
          ),
          Positioned(
            top: size != null ? size * -0.3 : -5,
            right: size != null ? size * 0.1 : -5,
            child: Container(
              height: size != null ? size * 0.6 : hp(2),
              width: size != null ? size * 0.6 : hp(2),
              padding: EdgeInsets.all(1),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(10),
              ),
              child: FittedBox(
                child: Text(
                  '4',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
