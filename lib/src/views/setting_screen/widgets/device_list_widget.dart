import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/help/widgets/card_item.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_toggle.dart';
import 'package:flutter/material.dart';

class DeviceList extends StatefulWidget {
  @override
  _DeviceListState createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {
  List<String> langs = ['en', 'es'];
  int selected = 0;
  @override
  Widget build(BuildContext context) {
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
              borderRadiusValue: 1,
              verticalTabletCard: 1.35,
              verticalMobileCard: 1.35,
              icon: Image.asset(
                iconPath,
                height: tablet ? hp(6.4) : wp(12),
              ),
              title: title,
              showForwardArrow: false,
              otherWidget: ButtonToggle(
                confirmDialog: true,
                size: tablet ? hp(1.6) : wp(2.9),
              ),
            )),
      );
    }

    Widget buildDeviceList() {
      return Column(
        children: <Widget>[
          SizedBox(
            height: tablet ? hp(0.6) : wp(0),
          ),
          card(
            title: eptxt('settings_device_enable_sound'),
            iconPath: "assets/devices/Sound.png",
          ),
          card(
            title: eptxt('settings_device_enable_camera'),
            iconPath: "assets/devices/Camera.png",
          ),
          card(
            title: eptxt('settings_device_enable_fingerprint'),
            iconPath: "assets/devices/Fingerprint.png",
          ),
          // GestureDetector(
          //   onTap: () {
          //     var nextLang = selected == (langs.length - 1) ? 0 : selected + 1;
          //     setState(() {
          //       selected = nextLang;
          //     });
          //     /*
          //     Multilanguage.setLanguage(
          //       path: 'assets/json/${langs[nextLang]}.json',
          //       context: context,
          //     ); */
          //     multilangBloc.changeLanguage(
          //         context: context,
          //         path: 'assets/json/${langs[nextLang]}.json');
          //   },
          //   child: Padding(
          //     padding: EdgeInsets.only(
          //         left: tablet ? hp(3) : wp(0), right: tablet ? hp(3) : wp(0)),
          //     child: Container(
          //       padding: EdgeInsets.only(
          //           top: tablet ? hp(1) : wp(3),
          //           left: tablet ? hp(0) : wp(2),
          //           right: tablet ? hp(0) : wp(2)),
          //       child: CardItem(
          //         fontSize: tablet ? hp(2.3) : wp(4.2),
          //         borderRadiusValue: 2,
          //         verticalTabletCard: 2.5,
          //         verticalMobileCard: 3,
          //         title: eptxt('settings_device_change_language'),
          //         showForwardArrow: false,
          //         otherWidget: Container(
          //           child: Text(langs[selected].toUpperCase()),
          //         ),
          //       ),
          //     ),
          //   ),
          // )
        ],
      );
    }

    return buildDeviceList();
  }
}
