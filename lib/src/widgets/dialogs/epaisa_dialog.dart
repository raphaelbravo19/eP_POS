import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:flutter/material.dart';

class EpaisaDialog extends StatelessWidget {
  const EpaisaDialog({
    Key key,
    @required this.context,
    @required this.close,
    this.body,
    @required this.bodyHeight,
    this.header,
    this.overflow,
    this.width,
  }) : super(key: key);

  final BuildContext context;
  final Function close;
  final Widget body;
  final Widget overflow;
  final Widget header;
  final double bodyHeight;
  final double width;
  @override
  Widget build(BuildContext context) {
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final bodyTop = hp(50) - bodyHeight;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0),
      body: Container(
        alignment: Alignment.center,
        width: wp(100),
        height: hp(100),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () => close(),
              child: Container(
                width: wp(100),
                height: hp(100),
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            Positioned(
              top: bodyTop,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(hp(1.6)),
                      color: Colors.white,
                    ),
                    width: width,
                    child: Column(
                      children: <Widget>[
                        header,
                        body,
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: (bodyHeight) + bodyTop,
              child: overflow,
            )
          ],
        ),
      ),
    );
  }
}

class EpaisaDialogHeader extends StatelessWidget {
  const EpaisaDialogHeader({
    Key key,
    @required this.hp,
    @required this.close,
    this.height,
    this.title,
  }) : super(key: key);

  final Function hp;
  final Function close;
  final String title;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: hp(0.4),
              ),
            ),
          ),
          height: height != null ? height : hp(7.5),
          child: Text(
            title,
            style: TextStyle(
              color: AppColors.BackPrimaryGray,
              fontWeight: FontWeight.bold,
              fontSize: height * 0.35,
            ),
          ),
        ),
        Positioned(
          top: -hp(0.2),
          right: tablet?hp(2):hp(1),
          child: Container(
            alignment: Alignment.center,
            height:height != null ? height : hp(7.5),
            child: GestureDetector(
              child: Image.asset(
                'assets/general_icons/xbutton.png',
                height: height * 0.35,
              ),
              onTap: () => close(),
            ),
          ),
        )
      ],
    );
  }
}
