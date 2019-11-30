import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/devices/device_screen.dart';
import 'package:epaisa_pos/src/views/help/widgets/card_item.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_toggle.dart';
import 'package:epaisa_pos/src/widgets/cards/paired_card.dart';
import 'package:flutter/material.dart';

class CustomizeHomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final bool tablet = isTablet(MediaQuery.of(context));
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var layoutwidth = tablet ? height * 0.65 : width * 0.85;
    var layoutHeight = tablet ? height : height * 0.8;

    Widget printerTitle() {
      return Column(
        children: <Widget>[
          Text(
            "Home Screen View",
            style: TextStyle(
              color: AppColors.PrimaryBlue,
              fontWeight: FontWeight.bold,
              fontSize: tablet ? hp(2.5) : wp(5),
            ),
          ),
          Text(
            "How would you like to see the products?",
            style: TextStyle(
              fontSize: tablet ? hp(2.5) : wp(3.2),
              fontWeight: FontWeight.w500,
              color: AppColors.DarkGray,
            ),
          )
        ],
      );
    }

    Widget noPrinterImage() {
      return Padding(
        padding: EdgeInsets.only(
            top: tablet ? hp(1) : wp(10), bottom: tablet ? hp(2) : wp(8)),
        child: Column(
          children: <Widget>[
            Image.asset("assets/general_icons/NoPrinter.png",
                height: tablet ? hp(10) : wp(15),
                width: tablet ? hp(10) : wp(15)),
            SizedBox(
              height: tablet ? hp(3) : wp(5),
            ),
            Text(
              "No Printers Detected",
              style: TextStyle(
                  color: AppColors.NoPrinterText,
                  fontWeight: FontWeight.bold,
                  fontSize: tablet ? hp(2) : wp(5)),
            )
          ],
        ),
      );
    }

    Widget cartView() {
      return Column(
        children: <Widget>[
          SizedBox(
            height: tablet ? hp(2) : wp(2),
          ),
          Text(
            "Cart View",
            style: TextStyle(
              color: AppColors.PrimaryBlue,
              fontWeight: FontWeight.bold,
              fontSize: tablet ? hp(2.5) : wp(5),
            ),
          ),
          SizedBox(
            height: tablet ? hp(2) : wp(2),
          ),
        ],
      );
    }

    Widget buildPairedPrinters() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            PairedAssignedCard(
              name: "2 x 4",
              icon: "assets/hardware/Printer.png",
              color: AppColors.PrimaryWhite,
              showModel: false,
            ),
            PairedAssignedCard(
              name: "3 x 4",
              icon: "assets/hardware/Printer.png",
              color: AppColors.IconGray,
              showModel: false,
            ),
          ],
        ),
      );
    }

    Widget card({
      String title,
      String iconPath,
    }) {
      return Padding(
        padding: EdgeInsets.only(
            left: tablet ? hp(3) : wp(0), right: tablet ? hp(3) : wp(0)),
        child: Container(
            padding: EdgeInsets.only(
                top: tablet ? hp(1) : wp(3),
                left: tablet ? hp(0) : wp(2),
                right: tablet ? hp(0) : wp(2)),
            child: CardItem(
              fontSize: tablet ? hp(2.3) : wp(4.2),
              verticalTabletCard: 1.35,
              verticalMobileCard: 1.35,
              borderRadiusValue: 1,
              icon: Image.asset(
                iconPath,
                height: tablet ? hp(6.4) : wp(12),
              ),
              title: title,
              showForwardArrow: false,
              otherWidget: ButtonToggle(
                size: tablet ? hp(1.6) : wp(2.9),
              ),
            )),
      );
    }

    Widget buildPrinter() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: tablet ? hp(2) : wp(5),
          ),
          printerTitle(),
          //noPrinterImage(),
          buildPairedPrinters(),
          Divider(
            color: AppColors.DarkGray,
          ),
          cartView(),
          card(
            title: "Enable S No.",
            iconPath: "assets/devices/Sound.png",
          ),
        ],
      );
    }

    return buildPrinter();
  }
}
