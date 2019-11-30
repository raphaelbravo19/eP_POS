import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart' as tab;
import 'package:epaisa_pos/src/views/dashboard/widgets/badge.dart';
import 'package:flutter/material.dart';

class DashboardItem extends StatelessWidget {
  final String title;
  final String image;
  final bool borderRight;
  final bool borderBottom;
  final bool isTablet;
  final bool commingSoon;
  final double tsize;
  final double size;
  final Map<String, dynamic> badge;
  final Function onTap;
  DashboardItem({
    this.title,
    this.image,
    this.borderBottom = false,
    this.borderRight = false,
    this.isTablet = false,
    this.commingSoon = false,
    this.badge = const {},
    this.size = 1,
    this.tsize = 1,
    @required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final tablet = tab.isTablet(MediaQuery.of(context));

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: <Widget>[
          Container(
            width: (tablet ? wp(70) : wp(83)) / (tablet ? 3 : 2),
            decoration: BoxDecoration(
              // color: Colors.green,
              border: Border(
                right: BorderSide(
                  width: isTablet ? 3 : 2,
                  color: borderRight
                      ? Color.fromRGBO(211, 223, 239, 1)
                      : Colors.transparent,
                ),
                bottom: BorderSide(
                  width: isTablet ? 3 : 2,
                  color: borderBottom
                      ? Color.fromRGBO(211, 223, 239, 1)
                      : Colors.transparent,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Opacity(
                  opacity:
                      badge != null ? badge['text'] == "UPGRADE" ? 0.5 : 1 : 1,
                  child: Container(
                    margin: EdgeInsets.only(
                        bottom:
                            title == "Inventory Management" ? hp(1) : hp(2)),
                    //width: isTablet ? wp(7) * size : wp(16) * size,
                    height: isTablet ? hp(tsize) : hp(size),
                    foregroundDecoration: badge != null
                        ? badge['text'] == "COMING SOON"
                            ? BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                backgroundBlendMode: BlendMode.saturation,
                              )
                            : BoxDecoration()
                        : BoxDecoration(),
                    alignment: Alignment.center,
                    child: Opacity(
                      opacity: badge != null
                          ? badge['text'] == "COMING SOON" ? 0.7 : 1
                          : 1,
                      child: Image.asset(
                        'assets/dashboard/${image}_on.png',
                        fit: BoxFit.fitHeight,
                        colorBlendMode: BlendMode.srcATop,
                        color: commingSoon ? Colors.grey : Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Container(
                    width: tablet ? wp(15) : 120,
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: isTablet ? hp(2.2) : wp(3.5),
                        fontWeight: FontWeight.bold,
                        color: AppColors.BackPrimaryGray,
                      ),
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
          ),
          if (badge != null)
            Positioned(
              top: isTablet ? 20 : 8,
              right: isTablet ? 10 : 16,
              child: Badge(
                isTablet: isTablet,
                backgroundColor: badge['color'],
                text: badge['text'],
              ),
            )
        ],
      ),
    );
  }
}
