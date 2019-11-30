import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:flutter/material.dart';

class PairedAssignedCard extends StatelessWidget {
  final String name, modelName, icon;
  final Color color;
  final bool showModel;
  final Function onTap;

  PairedAssignedCard({
    this.name = '',
    this.modelName = '',
    this.icon = '',
    this.color,
    this.showModel = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final bool tablet = isTablet(MediaQuery.of(context));

    Widget buildCard() {
      return GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap();
          }
        },
        child: Padding(
          padding: EdgeInsets.only(
              top: tablet ? hp(2) : wp(3),
              bottom: tablet ? hp(2) : wp(3),
              left: tablet ? hp(2) : wp(3),
              right: tablet ? hp(2) : wp(3)),
          child: Container(
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: color, width: 2.0)),
            child: Padding(
              padding: EdgeInsets.only(
                  top: tablet ? hp(2) : wp(3),
                  bottom:
                      tablet ? hp(showModel ? 2 : 0) : wp(showModel ? 3 : 0),
                  right: tablet ? hp(4) : wp(5),
                  left: tablet ? hp(4) : wp(5)),
              child: Column(
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                        color: AppColors.DarkGray,
                        fontSize: tablet ? hp(2.5) : wp(4),
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: tablet ? hp(2) : wp(3),
                        bottom: tablet ? hp(2) : wp(3)),
                    child: Image.asset(
                      icon,
                      height: tablet ? hp(12) : wp(20),
                      width: tablet ? hp(12) : wp(20),
                    ),
                  ),
                  showModel
                      ? Text(
                          modelName,
                          style: TextStyle(
                              color: AppColors.DarkGray,
                              fontSize: tablet ? hp(2) : wp(4),
                              fontWeight: FontWeight.bold),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return buildCard();
  }
}
