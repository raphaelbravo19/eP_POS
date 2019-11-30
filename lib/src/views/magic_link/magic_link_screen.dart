import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/login/login_screen.dart';
import 'package:epaisa_pos/src/views/magic_link/magic_direct.dart';
import 'package:epaisa_pos/src/views/magic_link/magic_sign.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:epaisa_pos/src/views/create_account/create_account_screen.dart';

class MagicLinkScreen extends StatefulWidget {
  @override
  _MagicLinkScreenState createState() => _MagicLinkScreenState();
}

class _MagicLinkScreenState extends State<MagicLinkScreen> {
  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    List<Map<String, dynamic>> titles = [
      {
        "title": multilang.get('welcome_slide_title'),
        "descriptions": tablet
            ? [
                multilang.get('welcome_slide_description_ln0'),
                multilang.get('welcome_slide_description_ln1')
              ]
            : [
                multilang.get('welcome_slide_description_pt0'),
                multilang.get('welcome_slide_description_pt1')
              ],
        "image": "tablet"
      },
      {
        "title": multilang.get('payments_slide_title'),
        "descriptions": [
          multilang.get('payments_slide_description_0'),
          multilang.get('payments_slide_description_1'),
        ],
        "image": "phone"
      },
      {
        "title": multilang.get('business_slide_title'),
        "descriptions": [
          multilang.get('business_slide_description_0'),
          multilang.get('business_slide_description_1')
        ],
        "image": "phones"
      }
    ];
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
              child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: hp(14),
                          ),
                          Expanded(
                            child: Container(
                              child: SlideItem(
                                titles: titles,
                                index: index,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: hp(10.2) + wp(4),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: 3,
                  pagination: SwiperCustomPagination(builder:
                      (BuildContext context, SwiperPluginConfig config) {
                    print(config.activeIndex);
                    return Container(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: tablet ? hp(8) : wp(3),
                        ),
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
                                padding: EdgeInsets.only(
                                  left: tablet ? 0 : wp(3),
                                ),
                                alignment: Alignment.bottomLeft,
                                child: Image.asset(
                                  "assets/magiclink/logo_magic.png",
                                  width: tablet ? hp(28) : wp(35),
                                ),
                              ),
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: ButtonGradient(
                                    callback: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()));
                                    },
                                    darkShadow: true,
                                    shadowLevel: 2,
                                    paddingVertical:
                                        tablet ? hp(2.6) : hp(1.85),
                                    fontSize: tablet ? hp(2.6) : wp(3.1),
                                    fontWeight: FontWeight.w700,
                                    borderRadius: hp(5),
                                    primaryColor: AppColors.LightPink,
                                    secondaryColor: AppColors.PrimaryWhite,
                                    textColor: AppColors.MagicColor,
                                    title: multilang
                                        .get('get_started')
                                        .toUpperCase(),
                                  ),
                                ),
                                SizedBox(
                                  width: tablet ? hp(30) : wp(6),
                                ),
                                Expanded(
                                  child: ButtonGradient(
                                    callback: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MagicDirectScreen(),
                                        ),
                                      );
                                    },
                                    darkShadow: true,
                                    shadowLevel: 2,
                                    paddingVertical:
                                        tablet ? hp(2.6) : hp(1.85),
                                    fontSize: tablet ? hp(2.6) : wp(3.1),
                                    fontWeight: FontWeight.w700,
                                    borderRadius: hp(5),
                                    primaryColor: AppColors.LightPink,
                                    secondaryColor: AppColors.PrimaryWhite,
                                    textColor: AppColors.MagicColor,
                                    title:
                                        multilang.get('sign_in').toUpperCase(),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: hp(2.3),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(3, (index) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        left: index == 0
                                            ? 0
                                            : tablet ? wp(2.4) : wp(6)),
                                    decoration: BoxDecoration(
                                        color: config.activeIndex == index
                                            ? AppColors.DarkGray
                                            : AppColors.Gray,
                                        shape: BoxShape.circle),
                                    height: tablet ? hp(2.5) : hp(2.2),
                                    width: tablet ? hp(2.5) : hp(2.2),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })),
            ),
          ],
        ),
      ),
    );
  }
}

class SlideItem extends StatelessWidget {
  const SlideItem({
    Key key,
    @required this.titles,
    @required this.index,
  }) : super(key: key);

  final List<Map<String, dynamic>> titles;
  final int index;

  Widget slideText(tablet, hp, wp) {
    return Container(
      margin: EdgeInsets.only(
        left: tablet ? hp(8) : 0,
        top: tablet ? hp(16) : 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment:
            tablet ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: <Widget>[
          if (!tablet)
            Expanded(
              child: Container(),
            ),
          Column(
            crossAxisAlignment:
                tablet ? CrossAxisAlignment.start : CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                // color: Colors.red,
                alignment: Alignment.center,
                child: Text(
                  titles[index]["title"],
                  style: TextStyle(
                    fontSize: tablet ? hp(5.4) : wp(5.3),
                    color: AppColors.DarkWhite,
                    fontWeight: tablet ? FontWeight.w600 : FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: tablet ? hp(10) : hp(3.5),
              ),
              ...List.generate(titles[index]["descriptions"].length, (dindex) {
                return Container(
                  alignment: Alignment.center,
                  child: Text(
                    titles[index]["descriptions"][dindex],
                    style: TextStyle(
                      fontSize: tablet ? hp(3.6) : wp(3.4),
                      color: AppColors.DarkWhite,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
              SizedBox(
                height: hp(2.5),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget slideImage(tablet, hp, wp) {
    return Container(
      // color: Colors.green,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              // color: Colors.red,
              padding: EdgeInsets.only(
                  left: wp(2),
                  right: tablet ? 0 : wp(2),
                  top: index == 1 ? hp(3.5) : 0),
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "assets/magiclink/${titles[index]["image"]}_magic.png",
                scale: tablet ? 0.8 : 1,
              ),
            ),
          ),
          SizedBox(
            height: index == 1 ? 0 : index == 0 ? hp(8) : hp(4.3),
          ),
          if (!tablet)
            Opacity(
              opacity: 0,
              child: Column(
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        titles[index]["title"],
                        style: TextStyle(
                            fontSize: tablet ? hp(5) : wp(5.3),
                            color: AppColors.DarkWhite,
                            fontWeight: FontWeight.w700),
                      )),
                  ...List.generate(titles[index]["descriptions"].length,
                      (dindex) {
                    return Container(
                      alignment: Alignment.center,
                      child: Text(
                        titles[index]["descriptions"][dindex],
                        style: TextStyle(
                            fontSize: tablet ? hp(3.1) : wp(3.4),
                            color: AppColors.DarkWhite,
                            fontWeight: FontWeight.w600),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hp = ScreenUtils.of(context).hp;
    final wp = ScreenUtils.of(context).wp;
    final tablet = ScreenUtils.of(context).isTablet;
    return tablet
        ? Row(
            children: <Widget>[
              slideText(tablet, hp, wp),
              Expanded(
                child: slideImage(tablet, hp, wp),
              ),
            ],
          )
        : Stack(
            children: <Widget>[
              slideText(tablet, hp, wp),
              slideImage(tablet, hp, wp),
            ],
          );
  }
}
