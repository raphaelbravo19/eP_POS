import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:flutter/material.dart';

class RowStructure extends StatelessWidget {
  String imagePath;
  Widget child;
  bool extraShadow;
  double customSize;
  GestureTapCallback onTap;
  bool extraSpace;
  RowStructure(
      {this.imagePath,
      this.child,
      this.onTap,
      this.extraShadow = false,
      this.extraSpace = true,
      this.customSize});

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));

    return Container(
      padding: EdgeInsets.only(
          left: wp(0),
          right: wp(3),
          top: wp(tablet ? 0.8 : 1),
          bottom: wp(tablet ? 0 : 1)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (extraSpace)
            SizedBox(
              width: tablet ? wp(2.5) : wp(5),
            ),
          Padding(
            padding: EdgeInsets.only(top: tablet ? hp(1.6) : wp(2)),
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: extraShadow
                    ? BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            offset: tablet
                                ? new Offset(1.5, 1.5)
                                : new Offset(.5, .5),
                            blurRadius: 1,
                          )
                        ],
                      )
                    : BoxDecoration(),
                child: imagePath.isNotEmpty? Image.asset(
                  imagePath,
                  fit: BoxFit.fill,
                  width: customSize != null
                      ? customSize
                      : tablet ? hp(5) : wp(9.3),
                  height: customSize != null
                      ? customSize
                      : tablet ? hp(5) : wp(9.3),
                ) : Container(),
              ),
            ),
          ),
          SizedBox(
            width: tablet ? wp(1.5) : wp(2),
          ),
          Expanded(flex: 8, child: child)
        ],
      ),
    );
  }
}
