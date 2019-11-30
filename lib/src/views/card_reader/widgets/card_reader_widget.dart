import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/devices/device_screen.dart';
import 'package:epaisa_pos/src/views/help/widgets/card_item.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_toggle.dart';
import 'package:flutter/material.dart';

class CardReaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final bool tablet = isTablet(MediaQuery.of(context));
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var layoutwidth = tablet ? height * 0.65 : width * 0.85;
    var layoutHeight = tablet ? height : height * 0.8;

    Widget cardReaderTitle() {
      return Text(
        "Paired Card Readers",
        style: TextStyle(
          color: AppColors.PrimaryBlue,
          fontWeight: FontWeight.bold,
          fontSize: tablet ? hp(2.5) : wp(5),
        ),
      );
    }

    Widget noPrinterImage() {
      return Padding(
        padding: EdgeInsets.only(
            top: tablet ? hp(1) : wp(10), bottom: tablet ? hp(2) : wp(8)),
        child: Column(
          children: <Widget>[
            Image.asset("assets/general_icons/NoCardReader.png",
                height: tablet ? hp(15) : wp(20),
                width: tablet ? hp(15) : wp(20)),
            SizedBox(
              height: tablet ? hp(2) : wp(5),
            ),
            Text(
              "No Card Readers Detected",
              style: TextStyle(
                  color: AppColors.NoPrinterText,
                  fontWeight: FontWeight.bold,
                  fontSize: tablet ? hp(2.5) : wp(5)),
            )
          ],
        ),
      );
    }

    Widget addNewPrinter() {
      return Column(
        children: <Widget>[
          SizedBox(
            height: tablet ? hp(2) : wp(5),
          ),
          Text(
            "Add New Card Reader",
            style: TextStyle(
              color: AppColors.PrimaryBlue,
              fontWeight: FontWeight.bold,
              fontSize: tablet ? hp(2.5) : wp(5),
            ),
          ),
          Text(
            "Detect and pair new card readers",
            style: TextStyle(
              fontSize: tablet ? hp(2) : wp(3.2),
              fontWeight: FontWeight.w500,
              color: AppColors.DarkGray,
            ),
          )
        ],
      );
    }

    Widget buildDetectPrinterButton() {
      return Padding(
        padding: EdgeInsets.all(tablet ? hp(2) : wp(5)),
        child: ButtonGradiant(
          layoutHeight * 0.025,
          layoutwidth,
          'DETECT CARD READER',
          textStyle: TextStyle(
              fontSize: tablet ? layoutHeight * 0.02 : layoutHeight * 0.025,
              color: AppColors.PrimaryWhite,
              fontWeight: FontWeight.w600),
          onPressed: () {
            //print("Hola");
            //loginBloc.submit(this);
          },
        ),
      );
    }

    Widget buildPrinter() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: tablet ? hp(2) : wp(5),
          ),
          cardReaderTitle(),
          SizedBox(
            height: tablet ? hp(3) : wp(0),
          ),
          noPrinterImage(),
          SizedBox(
            height: tablet ? hp(3) : wp(0),
          ),
          Divider(
            color: AppColors.DarkGray,
          ),
          addNewPrinter(),
          buildDetectPrinterButton()
        ],
      );
    }

    return buildPrinter();
  }
}
