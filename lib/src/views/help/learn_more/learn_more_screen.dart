import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class LearnMoreScreen extends StatefulWidget {
  @override
  _LearnMoreScreenState createState() => _LearnMoreScreenState();
}

class _LearnMoreScreenState extends State<LearnMoreScreen> {
  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    List<Map<String, dynamic>> titles = [
      {
        "title": "Welcome to ePaisa",
        "descriptions": [
          "Get started using the app now ",
          "and see the main features"
        ]
      },
      {
        "title": "Receive Payments",
        "descriptions": tablet
            ? [
                "Recieve payments in cash, debit or credit",
                "cards, and many other methods",
              ]
            : [
                "Recieve payments in cash, ",
                "debit or credit cards, and",
                "many other methods",
              ]
      },
      {
        "title": "Manage your Business",
        "descriptions": [
          "Manage your products, inventory and",
          "sales with an intuitive interface"
        ]
      }
    ];
    return Scaffold(
      body: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.only(left: wp(6)),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Spacer(
                    flex: 4,
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: hp(3.5),
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              titles[index]["title"],
                              style: TextStyle(
                                  fontSize: tablet ? hp(5) : wp(6.9),
                                  color: AppColors.DarkWhite,
                                  fontWeight: FontWeight.w600),
                            )),
                        SizedBox(
                          height: hp(6),
                        ),
                        ...List.generate(titles[index]["descriptions"].length,
                            (dindex) {
                          return Container(
                              alignment: Alignment.centerLeft,
                              child: Text(titles[index]["descriptions"][dindex],
                                  style: TextStyle(
                                      fontSize: tablet ? hp(3.1) : wp(4.5),
                                      color: AppColors.DarkWhite,
                                      fontWeight: FontWeight.w600)));
                        }).toList()
                      ],
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                        "assets/learnmore/image_${index + 1}${tablet ? "_landscape" : ""}.png")),
              ),
            );
          },
          itemCount: 3,
          pagination: new SwiperCustomPagination(
              builder: (BuildContext context, SwiperPluginConfig config) {
            print(config.activeIndex);
            return Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: wp(5)),
                margin: EdgeInsets.only(bottom: hp(5)),
                height: tablet ? hp(7) : wp(12),
                width: wp(100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: EdgeInsets.only(left: tablet ? 0 : wp(4)),
                        child: Row(
                          children: List.generate(3, (index) {
                            return Container(
                              margin: EdgeInsets.only(
                                  right: tablet ? wp(2.4) : wp(6)),
                              decoration: BoxDecoration(
                                  color: config.activeIndex == index
                                      ? AppColors.PrimaryBlue
                                      : AppColors.Gray,
                                  shape: BoxShape.circle),
                              height: tablet ? hp(2.5) : hp(2.2),
                              width: tablet ? hp(2.5) : hp(2.2),
                            );
                          }),
                        ),
                      ),
                    ),
                    if (tablet)
                      SizedBox(
                        width: tablet ? wp(37) : wp(30),
                      ),
                    Expanded(
                      flex: 5,
                      child: ButtonGradient(
                          darkShadow: true,
                          callback: () {
                            Navigator.pop(context);
                          },
                          fontSize: tablet ? hp(2.3) : wp(3.2),
                          borderRadius: hp(5),
                          title: "GET STARTED"),
                    ),
                  ],
                ),
              ),
            );
          })),
    );
  }
}
