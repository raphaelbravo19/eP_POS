import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/views/help/learn_more/learn_more_screen.dart';
import 'package:epaisa_pos/src/views/magic_link/magic_link_screen.dart';
import 'package:epaisa_pos/src/widgets/textStyles/medium_bold_white.dart';
import 'package:flutter/material.dart';

class LearnMore extends StatelessWidget {
  final double width;
  final double fontSize;
  final bool isTablet;

  LearnMore(this.width, this.isTablet, {this.fontSize});
  Widget build(context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => LearnMoreScreen()));
      },
      child: Container(
        margin: EdgeInsets.only(top: 15.0),
        width: isTablet ? width * 0.42 : width * 0.6,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                height: 3,
                color: Colors.white,
              ),
            ),
            SizedBox(width: isTablet ? width * 0.02 : width * 0.03),
            Container(
                alignment: Alignment.center,
                child: MediumBoldWhiteText(
                    eptxt('learn_more').toUpperCase(),
                    textStyle: TextStyle(
                        fontSize: fontSize,
                        color: AppColors.PrimaryWhite,
                        fontWeight: FontWeight.w700))
                //varaible above
                ),
            SizedBox(width: isTablet ? width * 0.02 : width * 0.03),
            Expanded(
              child: Container(
                height: 3,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
