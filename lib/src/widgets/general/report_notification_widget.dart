import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:flutter/material.dart';

class ReportNotificationWidget extends StatelessWidget {
  final String paymentIcons, cardName, title;
  final List<Widget> childrens;

  ReportNotificationWidget({this.paymentIcons='', this.cardName='', this.title='', this.childrens});

  @override
  Widget build(BuildContext context) {
    final bool tablet = isTablet(MediaQuery.of(context));
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    double fontSize = tablet ? hp(2.8) : hp(2.00);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var layoutwidth = tablet ? height * 0.55 : width * 0.85;
    var layoutHeight = tablet ? height : height * 0.8;

    Widget paymentNameIconStructure() {
      return Column(
        children: <Widget>[
          Image.asset(
            paymentIcons,
            height: tablet ? hp(7.4) : hp(6.4),
          ),
          Text(
            cardName,
            style: TextStyle(
              color: AppColors.DarkGray,
              fontWeight: FontWeight.w500,
              fontSize: tablet ? hp(2) : wp(3),
            ),
          )
        ],
      );
    }

    Widget titleLogo(){
      return Column(
        children: <Widget>[
          Text(title, style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: wp(10),
            color: AppColors.PrimaryBlue,
          )),
          Row(
            children: childrens,
          )
        ],
      );
    }

    return Container();
  }
}
