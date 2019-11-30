import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart' as prefix0;
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/login/login_screen.dart';
import 'package:epaisa_pos/src/views/magic_link/magic_sign.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MagicDirectScreen extends StatefulWidget {
  @override
  _MagicDirectScreenState createState() => _MagicDirectScreenState();
}

class _MagicDirectScreenState extends State<MagicDirectScreen> {
  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.MagicColor,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              "assets/splashscreen/background_landscape.png",
              color: Colors.white,
              fit: BoxFit.cover,
            ),
            SafeArea(
              
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: tablet ? hp(8) : wp(3)),
                      margin: EdgeInsets.only(
                        bottom: hp(2),
                        top: tablet ? hp(2) : 0,
                      ),
                      width: wp(100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: hp(13),
                            child: Container(
                              padding: EdgeInsets.only(left: tablet ? wp(0) : wp(3)),
                              alignment: Alignment.bottomLeft,
                              child: Image.asset(
                                "assets/magiclink/logo_magic.png",
                                width: tablet ? hp(28) : wp(35),
                              ),
                            ),
                          ),
                          if (tablet)
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  TextsItem(tablet: tablet, hp: hp, wp: wp),
                                  Expanded(
                                    child: ImageItem(
                                      wp: wp,
                                      tablet: true,
                                      hp: hp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (!tablet)
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: ImageItem(
                                      wp: wp,
                                      tablet: false,
                                      hp: hp,
                                    ),
                                  ),
                                  TextsItem(tablet: tablet, hp: hp, wp: wp),
                                ],
                              ),
                            ),
                          SizedBox(
                            height: hp(2),
                          ),
                          if (tablet)
                            Container(
                              margin: EdgeInsets.only(bottom: hp(5.3)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: signInButton(wp, context, hp, tablet),
                                  ),
                                  SizedBox(
                                    width: tablet ? hp(30) : wp(6),
                                  ),
                                  Expanded(
                                    child: magicLinkButton(wp, context, hp, tablet),
                                  ),
                                ],
                              ),
                            ),
                          if (!tablet)
                            Column(
                              children: <Widget>[
                                magicLinkButton(wp, context, hp, tablet),
                                SizedBox(
                                  height: hp(2),
                                ),
                                signInButton(wp, context, hp, tablet),
                                SizedBox(
                                  height: hp(5),
                                ),
                              ],
                            )
                        ],
                      )),
                      Positioned(
              right: tablet ? wp(2.5) : wp(4),
              top: tablet ? hp(5.2) : hp(3.5),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                child: tablet
                    ? Image.asset(
                        "assets/general_icons/Rounded.png",
                        color: AppColors.PrimaryWhite,
                        height: hp(3.8),
                        )
                    : Image.asset(
                        "assets/general_icons/Rounded.png",
                        color: AppColors.PrimaryWhite,
                        height: hp(2.2),
                      ),
              ),
            )
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  Container signInButton(
      Function wp, BuildContext context, Function hp, bool tablet) {
    return Container(
      padding: tablet
          ? EdgeInsets.only(right: 0)
          : EdgeInsets.symmetric(horizontal: wp(7)),
      child: ButtonGradient(
        callback: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
        },
        darkShadow: true,
        shadowLevel: 2,
        paddingVertical: tablet ? hp(2.45) : hp(1.85),
        fontSize: tablet ? hp(2.6) : wp(3.1),
        fontWeight: FontWeight.w700,
        borderRadius: hp(5),
        primaryColor: AppColors.LightPink,
        secondaryColor: AppColors.PrimaryWhite,
        textColor: AppColors.MagicColor,
        title: multilang.get('signin_manually').toUpperCase(),
      ),
    );
  }

  Container magicLinkButton(
      Function wp, BuildContext context, Function hp, bool tablet) {
    return Container(
      padding: tablet
          ? EdgeInsets.only(left: 0)
          : EdgeInsets.symmetric(horizontal: wp(7)),
      child: ButtonGradient(
        callback: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MagicSignScreen(),
            ),
          );
        },
        darkShadow: true,
        shadowLevel: 2,
        paddingVertical: tablet ? hp(2.5) : hp(1.85),
        fontSize: tablet ? hp(2.6) : wp(3.1),
        fontWeight: FontWeight.w700,
        borderRadius: hp(5),
        primaryColor: AppColors.LightPink,
        secondaryColor: AppColors.PrimaryWhite,
        textColor: AppColors.MagicColor,
        title: multilang.get('send_magic_link').toUpperCase(),
      ),
    );
  }
}

class ImageItem extends StatelessWidget {
  const ImageItem({
    Key key,
    @required this.wp,
    @required this.hp,
    @required this.tablet,
  }) : super(key: key);

  final Function wp;
  final Function hp;
  final bool tablet;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      alignment: Alignment.centerRight,
      // margin: EdgeInsets.only(left: tablet ? hp(16) : 0),
      padding: tablet
          ? EdgeInsets.symmetric(vertical: hp(12))
          : EdgeInsets.only(left: wp(23), right: wp(16)),
      child: Image.asset(
        "assets/magiclink/mail_magic.png",
      ),
    );
  }
}

class TextsItem extends StatelessWidget {
  const TextsItem({
    Key key,
    @required this.tablet,
    @required this.hp,
    @required this.wp,
  }) : super(key: key);

  final bool tablet;
  final Function hp;
  final Function wp;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: tablet ? hp(16) : 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:
            tablet ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(
              multilang.get('typing_slide_title'),
              style: TextStyle(
                fontSize: tablet ? hp(5) : wp(5),
                color: AppColors.DarkWhite,
                fontWeight: tablet ? FontWeight.w600 : FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: tablet ? hp(8) : hp(2),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              tablet
                  ? multilang.get('typing_slide_description_ln')
                  : multilang.get('typing_slide_description_pt'),
              textAlign: tablet ? TextAlign.left : TextAlign.center,
              style: TextStyle(
                fontSize: tablet ? hp(3.2) : wp(3.4),
                color: AppColors.DarkWhite,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
