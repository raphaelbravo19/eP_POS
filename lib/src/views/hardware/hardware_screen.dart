import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/card_reader/card_reader_screen.dart';
import 'package:epaisa_pos/src/views/cash_drawer/cash_drawer_screen.dart';
import 'package:epaisa_pos/src/views/devices/device_screen.dart';
import 'package:epaisa_pos/src/views/help/widgets/card_item.dart';
import 'package:epaisa_pos/src/views/printer/printer_screen.dart';
import 'package:epaisa_pos/src/views/screen_with_cart/screen_with_cart.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_toggle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HardwareScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool tablet = isTablet(MediaQuery.of(context));
    return tablet
        ? ScreenWithCart(
            body: buildEpaisaScaffold(context, tablet),
          )
        : buildEpaisaScaffold(context, tablet);
  }

  EpaisaScaffold buildEpaisaScaffold(BuildContext context, bool tablet) {
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;

    Widget card({
      String title,
      String iconPath,
      Widget screenName,
    }) {
      return Container(
          padding: EdgeInsets.only(
              top: tablet ? hp(1) : wp(3),
              left: tablet ? hp(0) : wp(2),
              right: tablet ? hp(0) : wp(2)),
          child: CardItem(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => screenName));
            },
            fontSize: tablet ? hp(2.3) : wp(4.2),
            verticalTabletCard: 1,
            verticalMobileCard: 1.35,
            icon: Image.asset(
              iconPath,
              height: hp(6.4),
            ),
            title: title,
            arrowColor: AppColors.SettingArrow,
          ));
    }

    Widget buildHardwareList() {
      return Column(
        children: <Widget>[
          card(
              title: eptxt('printers'),
              iconPath: "assets/hardware/Printer.png",
              screenName: PrinterScreen()),
          card(
              title: eptxt('card_reader'),
              iconPath: "assets/hardware/CardReader.png",
              screenName: CardReaderScreen()),
          card(
              title: eptxt('cash_drawers'),
              iconPath: "assets/hardware/CashDrawer.png",
              screenName: CashDrawerScreen()),
        ],
      );
    }

    return EpaisaScaffold(
      appBar: EpaisaAppBar(
        back: true,
        title: 'HARDWARE',
      ),
      body: buildHardwareList(),
    );
  }
}
