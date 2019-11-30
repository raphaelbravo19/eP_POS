import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/help/widgets/card_item.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_toggle.dart';
import 'package:flutter/material.dart';

class TransactionWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final bool tablet = isTablet(MediaQuery.of(context));

    Widget buildDivider() {
      return Container(
        height: 0.4,
        padding: EdgeInsets.all(tablet ? hp(2) : wp(0.1)),
        color: Colors.grey,
      );
    }

    Widget buildOnOffCard({String title}) {
      return Container(
          padding: EdgeInsets.only(
              top: tablet ? hp(1.5) : wp(1.5),
              left: tablet ? hp(4) : wp(3),
              right: tablet ? hp(4) : wp(3)),
          child: CardItem(
            fontSize: tablet ? hp(2.2) : wp(4.1),
            horizontalMobileCard: 1,
            verticalMobileCard: 2,
            spaceBeforeTextMobile: 2,
            horizontalTabletCard: 2,
            verticalTabletCard: 2,
            borderRadiusValue: wp(0.08),
            isIcon: false,
            icon: Image.asset(
              '',
              height: hp(0),
            ),
            title: title,
            showForwardArrow: false,
            otherWidget: ButtonToggle(
              confirmDialog: true,
              size: tablet ? hp(1.7) : wp(3),
            ),
          ));
    }

    Widget transactionDesc() {
      String mobDesc =
          '''Transactions will be processed offline when connection 
is not available. Once you are online the transactions will 
be uploaded to the server.''';

      String tabletDesc =
          "Transactions will be processed offline when connection is not available. Once you are online the transactions will be uploaded to the server.";

      return Padding(
        padding: EdgeInsets.only(
            top: tablet ? hp(1) : wp(3),
            bottom: tablet ? hp(1.6) : wp(3),
            left: tablet ? hp(5) : wp(5),
            right: tablet ? hp(4) : wp(0)),
        child: Text(
          tablet ? tabletDesc : mobDesc,
          style: TextStyle(
              fontSize: tablet ? hp(1.82) : wp(3.13),
              color: AppColors.DarkGray,
              fontWeight: FontWeight.w500),
        ),
      );
    }

    Widget buildRefund() {
      return Padding(
        padding: EdgeInsets.only(
            top: tablet ? hp(1) : wp(4),
            bottom: tablet ? hp(0) : wp(1),
            left: tablet ? hp(4) : wp(7),
            right: tablet ? hp(4) : wp(2)),
        child: Text(
          "Refund Permissions",
          overflow: TextOverflow.clip,
          style: TextStyle(
            color: AppColors.PrimaryBlue,
            fontSize: tablet ? hp(2.6) : wp(4.6),
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    Widget buildDeviceList() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: tablet ? hp(0.5) : wp(4),
          ),
          buildOnOffCard(title: "Enable Offline Transactions"),
          transactionDesc(),
          buildDivider(),
          SizedBox(
            height: tablet ? 0 : wp(1),
          ),
          buildOnOffCard(title: "Enable Round-off"),
          SizedBox(
            height: tablet ? hp(2) : wp(3),
          ),
          buildDivider(),
          buildRefund(),
          buildOnOffCard(title: "Send OTP on Refund"),
        ],
      );
    }

    return buildDeviceList();
  }
}
